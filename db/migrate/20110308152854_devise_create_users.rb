class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
#      t.database_authenticatable :null => false
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""
      t.string :password_salt,      :null => false, :default => ""

#      t.recoverable
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.string   :reset_password_token
      t.string   :remember_token
      
#      t.rememberable
      ## Rememberable
      t.datetime :remember_created_at
      
#      t.trackable
      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable
#      t.string :username
      t.string :language

      t.timestamps
    end

#    add_index :users, :username,             :unique => true
#    add_index :users, :email,                :unique => true
#    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
      User.create!(:email => 'paul123@piguard.com',
                :password => 'paul123',
                :password_confirmation => 'paul123')
#                :encrypted_password => '$2a$10$egY4h32xNN9r5MEyWVtrqeJqP0pS0jLykmJCPHFK.LPcebGchIfXu',
#                :password_salt => '$2a$10$egY4h32xNN9r5MEyWVtrqe')
      
#      User.create(:username => 'terry123',
#                :email => 'terry123@piguard.com',
#                :password => 'paul123',
#                :encrypted_password => '$2a$10$egY4h32xNN9r5MEyWVtrqeJqP0pS0jLykmJCPHFK.LPcebGchIfXu',
#                :password_salt => '$2a$10$egY4h32xNN9r5MEyWVtrqe')
#      
#      User.create(:username => 'toad123',
#                :email => 'toad123@piguard.com',
#                :password => 'paul123',
#                :encrypted_password => '$2a$10$egY4h32xNN9r5MEyWVtrqeJqP0pS0jLykmJCPHFK.LPcebGchIfXu',
#                :password_salt => '$2a$10$egY4h32xNN9r5MEyWVtrqe')
  end

  def self.down
    drop_table :users
  end
end
