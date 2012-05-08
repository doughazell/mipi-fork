namespace :data_element do
  desc "Manage Data Elements through the command line"
  
  task :create_class => :environment do

    require "highline/import"
     
    username = ask("Username?")
    u = User.find_by_username(username)
      
    globe_reference = nil
    parent_globe = nil
    data_element_name = ask("Enter new name for the Data Element:").camelcase
    puts data_element_name
    if (data_element_name["DataElement".length * - 1..-1] != "DataElement") then
        data_element_name += "DataElement"
    end

    # Put some test to ensure the class doesn't already exist.    
    #if (data_element_name.constantize) then
    #    puts "The Data Element already exists. Please use a different name."
    #end
    
    
    
    #profile_name = globe_name + " Profile"
    #if agree("Is this a shadow-globe?", true)
    #  puts "It's a SHADOW GLOBE! Find Parent"
    #  parent_globe_reference = ask("What is the reference of the Parent Globe associated with this globe?")
    #  parent_globe = Globe.find_by_globe_reference(parent_globe_reference)
    #end
    #
    #globe_reference = ask("What is you Globe's account name? No spaces").downcase
  end
end