class CreatePresentations < ActiveRecord::Migration
  def self.up
    create_table :presentations do |t|
      t.references :data_sheet
      t.references :data_element_collection
      t.datetime :created_at

      t.timestamps
    end
  end

  def self.down
    drop_table :presentations
  end
end
