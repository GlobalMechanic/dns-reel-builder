task :gm => ["gm:clean", "gm:import"]

namespace :gm do
  task :import

  desc "Import the existing GM reels database"
  task :import => :environment do
    num = 0

    # clips = [
    #   {
    #     clip_name => 'Scotia Preshow',
    #     clip_description => "Yes Please's directorial debut with Global Mechanic, this kinetic type piece shows in Scotiabank cinemas around Canada. There's a lot of copy packed in this spot, but the clean vector shapes and punchy Scotiabank palette give flow and clarity. Plus we love the stars!",
    #     clip_thumbs => 'http://globalmechanic.com/clip/thumbnails/12a07scotiapreshow.png',
    #     clip_movies => 'http://globalmechanic.com/clip/movies/12a07scotiapreshowhd.mp4',
    #   },
    #   {
    #     clip_name => 'Rocket Scientist',
    #     clip_description => "One of an ongoing series of Lichtenstein Pop Art inspired spots for Smirnoff. Fun to take this poster style and work out a movement language - this one also has the classic porn trope of sexy assistant removing glasses and letting hair down. Roowwwr!",
    #     clip_thumbs => 'http://globalmechanic.com/clip/thumbnails/12a02smirnofficerocket_eng.png',
    #     clip_movies => 'http://globalmechanic.com/clip/movies/12a02smirnoffrocket_easy_30e_r02.m4v',
    #   }
    # ]
    # clips.each do |clip|

    config =  ActiveRecord::Base.configurations["migration"]
    client = Mysql2::Client.new(config.symbolize_keys)
    #client = Mysql2::Client.new(:host => config['host'], :username => config['username'], :database => config['database'], :password => config['password'])
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
