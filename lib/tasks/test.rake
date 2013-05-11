require 'debugger'

namespace :test do

  desc "Testing Rake Functionalty"  
  task :params, [:username, :password, :third] do |t, args|
    require "highline/import"
    
    param3 = args[:third].blank? ? "[Unspecified]" : args[:third]
    
#    puts t
    puts args.to_yaml
    puts "First Param: #{args[:username]}"
    puts "Second Param: #{args[:password]}"
    puts "Third Param: #{param3}"
  end

end
    
