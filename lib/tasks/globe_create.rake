namespace :globe do
  desc "Manage Globes through the command line"
  
  task :create => :environment do

    require "highline/import"
     
    username = ask("Username?")
    u = User.find_by_username(username)
      
    globe_reference = nil
    parent_globe = nil
    globe_name = ask("Enter new name for Globe:")
    profile_name = globe_name + " Profile"
    if agree("Is this a shadow-globe?", true)
      puts "It's a SHADOW GLOBE! Find Parent"
      parent_globe_reference = ask("What is the reference of the Parent Globe associated with this globe?")
      parent_globe = Globe.find_by_globe_reference(parent_globe_reference)
    end

    globe_reference = ask("What is you Globe's account name? No spaces").downcase
    
    main_page = ask("What will be the name of the first page?")
    
    g = Globe.new :name => globe_name, :globe_reference => globe_reference, :parent => parent_globe
    g.save
     
    reg = Registration.new :globe => g, :user => u
    reg.save
    
    p = Profile.new :name => profile_name, :globe => g
    p.save

    if (!parent_globe.nil?)
      path_extension = parent_globe.globe_reference + "/" + globe_reference + "/"
    else
      path_extension = globe_reference + "/"
    end
     
    #new_css_folder = Rails.root.to_s + "/public/stylesheets/custom_styles/" + path_extension
    #css_file_db = "/stylesheets/custom_styles/" + path_extension + "main"
    #css_file = Rails.root.to_s + /public/stylesheets/custom_styles/" + path_extension + "main.css"
    #
    #new_page_folder = Rails.root.to_s + "/app/views/data_sheets/pages/" + path_extension
    #page_file_db = "/data_sheets/pages/" + path_extension + "main.html.erb"
    #page_file = Rails.root.to_s + "/views/data_sheets/pages/" + path_extension + "_main.html.erb"
    #
    #FileUtils.mkdir_p(new_page_folder)
    #FileUtils.mkdir_p(new_css_folder)
    #
    #FileUtils.cp(Rails.root.to_s + '/app/views/data_sheets/pages/_place_holder.html.erb', page_file)
    #FileUtils.cp(Rails.root.to_s + '/public/stylesheets/custom_styles/_default_style.css', css_file)
    
#    ds = DataSheet.new :name => main_page, :style_sheets => css_file_db, :profile => p, :file_location => page_file_db, :creator => u, :updater => u
#    ds.save
#    
#    if (parent_globe.nil?)
#      file = File.open("C:/Windows/System32/drivers/etc/hosts","a+")
#      file << "127.0.0.1                   " + globe_reference + ".lvh.me
#"
#    end
#    
    puts "REMEMBER: If you are offline you'll need to add an entry in the hosts file for " + globe_reference + ".lvh.me"
  end
  
  task :readcontacts => :environment do
    require "highline/import"
     
    globe_reference = ask("Which globe reference?")
    g = Globe.find_by_globe_reference(globe_reference)
    u = User.find_by_username(ask("Username?"))
    dec = DataElementCollection.find_by_name("Contacts")
    File.open("c:/development/ruby/v20/test/data/contacts.csv").each do |line|
      values = line.split(',')
      de = ContactDataElement.new :first_name => values[0], :last_name => values[1], :email => values[2], :globe => g, :name => values[0].downcase + values[1].downcase, :data_element_collection => dec, :user => u
      de.save
    end
  end
  
  task :newglobes => :environment do
    require "highline/import"
    
    u = User.find_by_username(ask("Username?"))
    filename = ask("Filename to load from 'data' folder?")
    if agree("Are these all top-level globes?", true)
      parent_globe = nil
    else
      parent_globe_reference = ask("What is the reference of the Parent Globe associated with this globe?")
      parent_globe = Globe.find_by_globe_reference(parent_globe_reference)
    end
    
    File.open("c:/development/ruby/v20/test/data/" + filename).each do |line|
      values = line.split(',')
      
      g = Globe.new :name => values[0], :globe_reference => values[1], :parent => parent_globe
      g.save
       
      reg = Registration.new :globe => g, :user => u
      reg.save
   
      profile_name = values[0] + " Profile"
      p = Profile.new :name => profile_name, :globe => g
      p.save
      
      if (!parent_globe.nil?)
        path_extension = parent_globe.globe_reference + "/" + values[1] + "/"
      else
        path_extension = globe_reference + "/"
      end
       
      new_css_folder = "c:/development/ruby/v20/public/stylesheets/custom_styles/" + path_extension
      css_file_db = "/stylesheets/custom_styles/" + path_extension + "main"
      css_file = "c:/development/ruby/v20/public/stylesheets/custom_styles/" + path_extension + "main.css"
      
      new_page_folder = "c:/development/ruby/v20/app/views/data_sheets/pages/" + path_extension
      page_file_db = "/data_sheets/pages/" + path_extension + "main.html.erb"
      page_file = "c:/development/ruby/v20/app/views/data_sheets/pages/" + path_extension + "_main.html.erb"
      
      FileUtils.mkdir_p(new_page_folder)
      FileUtils.mkdir_p(new_css_folder)
      
      FileUtils.cp('c:/development/ruby/v20/app/views/data_sheets/pages/_place_holder.html.erb', page_file)
      FileUtils.cp('c:/development/ruby/v20/public/stylesheets/custom_styles/_default_style.css', css_file)
      
      ds = DataSheet.new :name => "defaultpage", :style_sheets => css_file_db, :profile => p, :file_location => page_file_db, :creator => u, :updater => u
      ds.save
      
      if (parent_globe.nil?)
        file = File.open("C:/Windows/System32/drivers/etc/hosts","a+")
        file << "127.0.0.1                   " + globe_reference + ".lvh.me
  "
      end
      
    end
  end
    
  task :cricketclubdata => :environment do
    require "highline/import"
    
    u = User.find_by_username(ask("Username?"))
    filename = ask("Filename to load from 'data' folder?")
    g = Globe.find_by_globe_reference('ecb')

    File.open("c:/development/ruby/v20/test/data/" + filename).each do |line|
      values = line.split(',')
      values.each do |value|
        puts value
      end
      
      shadow = Globe.find_by_globe_reference(values[1])
      p = Profile.find_by_globe_id_and_name(shadow.id, values[8])
      puts shadow.id
      puts values[8]
      puts '--------'
      puts p
      puts '--------'
      puts p.id
      puts values[7]
      ds = DataSheet.find_by_profile_id_and_name(p.id, values[7])
#      pres = Presentation.new :data_sheet => ds, :data_element_collection => dec
#      pres.save
    end
  end
end