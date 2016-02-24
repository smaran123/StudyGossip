class CreateStudentInformations < ActiveRecord::Migration
  def change
    create_table :student_informations do |t|
      t.string :first_name
      t.string :last_name
      t.string :college_name
      t.string :phone
      t.string :zip_code
      t.string :role
      t.string :email
      t.timestamps
    end
  end
end
