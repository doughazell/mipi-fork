class CreateEcbCricketClubDataElements < ActiveRecord::Migration
  def self.up
    create_table :ecb_cricket_club_data_elements do |t|
      t.string :location
      t.string :county
      t.string :weburl
      t.string :contact_name
      t.string :contact_number
    end
    create_citier_view(EcbCricketClubDataElement)
  end

  def self.down
    drop_citier_view(EcbCricketClubDataElement)
    drop_table :ecb_cricket_club_data_elements
  end
end
