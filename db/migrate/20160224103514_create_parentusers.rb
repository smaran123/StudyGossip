class CreateParentusers < ActiveRecord::Migration
  def change
    create_table :parentusers do |t|
      t.integer :user_id
      t.integer :parent_id
      t.integer :school_admin_id
      t.timestamps
    end
  end
end
