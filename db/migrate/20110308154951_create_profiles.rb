class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :name
      t.integer :globe_id
      t.integer :position
      
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
