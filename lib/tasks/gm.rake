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
      Clip.create(
        :title => clip['clip_name'],
        :description => clip['clip_description'],
        :name => clip['clip_director'],
        :video => clip['clip_movies'],
        :image => clip['clip_thumbs'],
        # :thumbnail => open(clip[:image]),
      )
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
