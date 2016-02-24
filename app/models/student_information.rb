class StudentInformation < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :phone, :zip_code, :email, :college_name, :role
  validates :first_name, :last_name, :email, :phone, :zip_code,  :college_name, :role, :presence => true
end
