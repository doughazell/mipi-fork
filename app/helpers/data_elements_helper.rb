module DataElementsHelper
  def tailored_output(f, entry_field, column, section)
    if (section == "label")
      f.label column
    elsif (section == "entry")
      f.send("#{entry_field}".to_sym, column.to_sym)
    end
  end
  
  def determine_entry_field_style(new_data_element, column)
    meta_data = DataElementMetaData.find_by_data_element_type_and_name(new_data_element, column)
    if (meta_data.nil?)
      entry_field = "text_field"
    else
      entry_field = meta_data.default_html_modifier
    end
  end
end
