class Payment < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :card_holder_name, :email, :zipcode, :state, :street_address, :city, :country,
:purchased_at, :payment_amount, :net_payment, :order_number, :merchant_order_id, :status, :user_type, :no_of_students, :stu_field_validate

  validates :payment_amount, :presence => true
  validates :payment_amount,  numericality: { only_integer: true, greater_than: 0 }

  validates :no_of_students, :presence => { :if => "student_no_validate?" }
  attr_accessor :stu_field_validate

  def student_no_validate?
    !self.stu_field_validate.nil? and ['no_of_students'].include?(self.stu_field_validate)
  end
end
