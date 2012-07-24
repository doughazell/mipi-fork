namespace :esb do
  desc "Manage Data Elements through the command line"
  
  task :load_generators => :environment do
    file = 'C:/Development/mipi/test/data/generator_units.csv'
    puts file
  end
end
