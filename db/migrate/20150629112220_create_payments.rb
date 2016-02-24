class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :first_name
      t.string :last_name
      t.string :card_holder_name
      t.string :email
      t.string :zipcode
      t.string :state
      t.string :street_address
      t.string :city
      t.string :country
      t.string :purchased_at
      t.string :payment_amount
      t.string :net_payment
      t.string :order_number
      t.string :merchant_order_id
      t.string :status, :default => 'Pending'
      t.string :user_type
      t.timestamps
    end
  end
end
