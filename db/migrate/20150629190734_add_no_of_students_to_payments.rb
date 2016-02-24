class AddNoOfStudentsToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :no_of_students, :integer
  end
end
