task :gm => ["gm:import"]

namespace :gm do
  task :import

  desc "Import all of the existing GM reels database"
  task :import_all => :environment do
    num = 0
    num_error = 0
    config =  ActiveRecord::Base.configurations["migration"]
    client = Mysql2::Client.new(config.symbolize_keys)
    clips = client.query("SELECT gm_clips.*, gm_categories.name_short AS category FROM gm_clips LEFT JOIN gm_categories ON gm_clips.category_id = gm_categories.id")
    clips.each do |clip|
      if clip['clip_thumbs'] != ''
        new_clip = Clip.new(
          :title => clip['clip_name'],
          :description => clip['clip_description'],
          :director => clip['clip_director'],
          # :director_url? - generate directly from clip_director
          :video => clip['clip_movies'],
          :image => clip['clip_thumbs'],
          :agency => clip['clip_agency'],
          :client => clip['clip_client'],
          :year => clip['clip_year'],
          :month => clip['clip_month'],
          :active => clip['clip_active'],
          :category => clip['category'],
          :legacy_id => clip['clip_id'],
        )
        # Can't mass assign tags in create, so break out:
        new_clip.keyword_list = clip['keywords']
        new_clip.technique_list = clip['clip_technique']
        new_clip.save!
        num += 1
        puts num.to_s + ': ' + clip['clip_name']
      else
        num_error += 1
        puts 'Failed: ' + clip['clip_name']
      end
    end
    puts "\nImported #{num} rows.\n\n"
    puts "\nError on #{num_error} rows.\n\n"
  end

  desc "Import new clips to database by legacy_id"
  task :import => :environment do
    num = 0
    num_error = 0
    config =  ActiveRecord::Base.configurations["migration"]
    client = Mysql2::Client.new(config.symbolize_keys)
    clips = client.query("SELECT gm_clips.*, gm_categories.name_short AS category FROM gm_clips LEFT JOIN gm_categories ON gm_clips.category_id = gm_categories.id WHERE gm_clips.clip_id NOT IN (" + Clip.all.map(&:legacy_id).join(',') + ")")
    clips.each do |clip|
      if clip['clip_thumbs'] != ''
        new_clip = Clip.new(
          :title => clip['clip_name'],
          :description => clip['clip_description'],
          :director => clip['clip_director'],
          # :director_url? - generate directly from clip_director
          :video => clip['clip_movies'],
          :image => clip['clip_thumbs'],
          :agency => clip['clip_agency'],
          :client => clip['clip_client'],
          :year => clip['clip_year'],
          :month => clip['clip_month'],
          :active => clip['clip_active'],
          :category => clip['category'],
          :legacy_id => clip['clip_id'],
        )
        # Can't mass assign tags in create, so break out:
        new_clip.keyword_list = clip['keywords']
        new_clip.technique_list = clip['clip_technique']
        new_clip.save!
        num += 1
        puts num.to_s + ': ' + clip['clip_name']
      else
        num_error += 1
        puts 'Failed: ' + clip['clip_name']
      end
    end
    puts "\nImported #{num} rows.\n\n"
    puts "\nError on #{num_error} rows.\n\n"
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
