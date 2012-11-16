task :gm => ["gm:import"]

namespace :gm do
  task :import

  desc "Import the existing GM reels database"
  task :import => :environment do
    num = 0
    (1..10).each do |n|
      Clip.create :title => "Clip #{n}", :description => 'Some description', :name => 'Username'
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
