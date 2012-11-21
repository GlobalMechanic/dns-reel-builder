task :gm => ["gm:clean", "gm:import"]

namespace :gm do
  task :import

  desc "Import the existing GM reels database"
  task :import => :environment do
    num = 0
    samples = [
      {
        :title => 'Scotia Preshow',
        :description => "Yes Please's directorial debut with Global Mechanic, this kinetic type piece shows in Scotiabank cinemas around Canada. There's a lot of copy packed in this spot, but the clean vector shapes and punchy Scotiabank palette give flow and clarity. Plus we love the stars!",
        :image => 'http://globalmechanic.com/clip/thumbnails/12a07scotiapreshow.png',
        :video => 'http://globalmechanic.com/clip/movies/12a07scotiapreshowhd.mp4',
      },
      {
        :title => 'Rocket Scientist',
        :description => "One of an ongoing series of Lichtenstein Pop Art inspired spots for Smirnoff. Fun to take this poster style and work out a movement language - this one also has the classic porn trope of sexy assistant removing glasses and letting hair down. Roowwwr!",
        :image => 'http://globalmechanic.com/clip/thumbnails/12a02smirnofficerocket_eng.png',
        :video => 'http://globalmechanic.com/clip/movies/12a02smirnoffrocket_easy_30e_r02.m4v',
      }
    ]
    (1..4).each do |n|
      clip = samples[n % samples.length]
      Clip.create(
        :title => "#{clip[:title]} - clip #{n}",
        :description => clip[:description],
        :name => 'Username',
        :video => clip[:video],
        :image => clip[:image],
        # :thumbnail => open(clip[:image]),
      )
      puts (n % samples.length).to_s + ' ' + clip[:image] + ' ' + clip[:video]
      num += 1
    end
    puts "Imported #{num} rows."
  end

  desc "Clean out the GM reels frmo the current database"
  task :clean => :environment do
    num = Clip.delete_all
    puts "Cleaned #{num} rows."
  end

end
