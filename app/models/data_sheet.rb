# @author Paul Long
class DataSheet < ActiveRecord::Base
  belongs_to :profile
  belongs_to :user, :foreign_key => 'created_by'
  belongs_to :user, :foreign_key => 'updated_by'
  has_many :presentations
  has_many :data_element_collections, :through => :presentations
  
  def setup_defaults(globe, profile)
    puts "DataSheet.setup_defaults() START"
    if (!globe.parent_id.nil?)
      path_extension = globe.parent.globe_reference + "/" + globe.globe_reference + "/"
    else
      path_extension = globe.globe_reference + "/"
    end
    
    root_path = Rails.root.to_s
    profile_file_name = profile.name.downcase.underscore
    
    new_css_folder = root_path + "/public/stylesheets/custom_styles/" + path_extension
    css_file_db = "/stylesheets/custom_styles/" + path_extension + profile_file_name
    css_file = root_path + "/public/stylesheets/custom_styles/" + path_extension + profile_file_name + ".css"
    
    new_page_folder = root_path + "/app/views/data_sheets/pages/" + path_extension
    page_file_db = "/data_sheets/pages/" + path_extension + profile_file_name + ".html.erb"
    page_file = root_path + "/app/views/data_sheets/pages/" + path_extension + "_" + profile_file_name + ".html.erb"
    
    FileUtils.mkdir_p(new_page_folder)
    FileUtils.mkdir_p(new_css_folder)
    
    source_file_page = root_path + "/app/views/data_sheets/pages/_place_holder.html.erb"
    source_file_css = root_path + "/public/stylesheets/custom_styles/_default_style.css"
    
    puts source_file_page
    puts page_file
    puts source_file_css
    puts css_file
    
    FileUtils.cp(source_file_page, page_file)
    FileUtils.cp(source_file_css, css_file)
    
    style_sheets = css_file_db
    file_location = page_file_db
    
    save!
    puts "DataSheet.setup_defaults() END"
  end
end
