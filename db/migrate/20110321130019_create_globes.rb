class CreateGlobes < ActiveRecord::Migration
  def self.up
    create_table :globes do |t|
      t.string :name
      t.string :globe_reference
      t.integer :parent_id
      t.string :security

      t.timestamps
    end
  end

  def self.down
    drop_table :globes
  end
end
