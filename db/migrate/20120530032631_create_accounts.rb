class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name,      :null => false, :default => ""
      t.string :subdomain, :null => false, :default => ""

      t.timestamps
    end
    add_index :accounts, :name,      :unique => true
    add_index :accounts, :subdomain, :unique => true
  end
end
