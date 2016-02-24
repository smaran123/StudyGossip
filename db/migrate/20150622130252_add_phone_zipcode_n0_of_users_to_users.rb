class AddPhoneZipcodeN0OfUsersToUsers < ActiveRecord::Migration
  def change
        add_column :users, :phone, :string
        add_column :users, :zipcode, :string
        add_column :users, :no_of_users, :integer
  end
end
