class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable
      t.string :username
      t.string :language

      t.timestamps
    end

    add_index :users, :username,             :unique => true
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
      User.create(:username => 'paul123',
                :email => 'paul123@piguard.com',
                :password => 'paul123')
      
      User.create(:username => 'damo123',
                :email => 'damo123@piguard.com',
                :password => 'damo123')
      
      User.create(:username => 'ali123',
                :email => 'ali123@piguard.com',
                :password => 'ali123')
  end

  def self.down
    drop_table :users
  end
end