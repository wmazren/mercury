class AddDetailsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :user_limit, :integer
    add_column :accounts, :activated_at, :datetime
  end
end
