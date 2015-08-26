class Initial < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :null => false, :unique => true
      t.attachment :picture
    end

    create_table :books do |t|
      t.integer :category_id, :null => false
      t.string :title, :null => false
      t.attachment :picture
      t.text :description
      t.text :author, :null => false
      t.string :year
      t.string :pages
    end
    add_index :books, [:category_id, :title], :unique => true
    add_foreign_key :books, :categories

    create_table :users do |t|
      # From https://github.com/binarylogic/authlogic_example/tree/master
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :email, :null => false, :unique => true # optional, you can use login instead, or both
      t.string :crypted_password
      t.string :password_salt
      t.boolean :uses_oauth, :null => false, :default => false
      t.string :persistence_token, :null => false # required
      t.string :perishable_token, :null => false # required
      t.integer :login_count, :null => false, :default => 0
      t.integer :failed_login_count, :null => false, :default => 0
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip
    end

    create_table :favoritings do |t|
      t.integer :book_id, :null => false
      t.integer :user_id, :null => false
    end
    add_index :favoritings, [:book_id, :user_id], :unique => true
    add_foreign_key :favoritings, :books
    add_foreign_key :favoritings, :users

    create_table :book_reviews do |t|
      t.integer :book_id, :null => false
      t.integer :user_id, :null => false
      t.integer :rating, :null => false
      t.text :description
      t.datetime :created_at, :null => false
    end
    add_index :book_reviews, [:book_id, :created_at], :unique => false, :order => {:book_id => :asc, :created_at => :desc}
    add_foreign_key :book_reviews, :books
  end
end
