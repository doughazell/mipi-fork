class CreateDataSheets < ActiveRecord::Migration
  def self.up
    create_table :data_sheets do |t|
      t.string :name
      t.string :display_name
      t.string :class_style
      t.string :style_sheets
      t.integer :profile_id
      t.string :file_location
      t.integer :position

      t.userstamps
      t.timestamps
    end
  end

  def self.down
    drop_table :data_sheets
  end
end
