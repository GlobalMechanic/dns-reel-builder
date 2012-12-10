task :gm => ["gm:clean", "gm:import"]

namespace :gm do
  task :import

  desc "Import the existing GM reels database"
  task :import => :environment do
    num = 0
    config =  ActiveRecord::Base.configurations["migration"]
    client = Mysql2::Client.new(config.symbolize_keys)
    clips = client.query("SELECT * FROM gm_clips where clip_active = 1")
    clips.each do |clip|
      new_clip = Clip.new(
        :title => clip['clip_name'],
        :description => clip['clip_description'],
        :director => clip['clip_director'],
        :video => clip['clip_movies'],
        :image => clip['clip_thumbs'],
        :agency => clip['clip_agency'],
        :client => clip['clip_client'],
        :year => clip['clip_year'],
        :month => clip['clip_month'],
        # :thumbnail => open(clip[:image]),
      )
      # For some reason, can't mass assign tags in create, so break out:
      new_clip.keyword_list = clip['keywords']
      new_clip.technique_list = clip['clip_technique']
      new_clip.save

      puts num.to_s + ': ' + clip['clip_name']
      num += 1
    end
    puts "\nImported #{num} rows.\n\n"
  end

  desc "Clean out the GM reels frmo the current database"
  task :clean => :environment do
    num = Clip.delete_all
    puts "\nCleaned #{num} rows.\n\n"
  end

  desc "Test database conections"
  task :test => :environment do
    
  end

end
