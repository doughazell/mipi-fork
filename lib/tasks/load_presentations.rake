namespace :presentations do
  desc "Load Presentations from CSV Data: (globe_reference, class, DataElementCollection.name, DataSheet)"
  
  task :tlafs => :environment do
    u = User.find_by_username('paul123')

    File.open("c:/development/mipi/test/data/presentations_tlaf_2012.csv").each do |line|
      values = line.split(',')
      g = Globe.find_by_globe_reference(values[0])
      ds = DataSheet.find_by_name(values[3].chop)
      dec = DataElementCollection.find_by_name_and_data_element_type(values[2], values[1])
      puts values[0]
      if (!g.nil? && !ds.nil? && !dec.nil?) then
        puts values[1]
        pres = Presentation.new :data_sheet => ds, :data_element_collection => dec
        pres.save
      end 
    end
  end
end