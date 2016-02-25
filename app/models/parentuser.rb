class Parentuser < ActiveRecord::Base
  attr_accessible :parent_id, :user_id, :school_admin_id,:email
  belongs_to :user
  belongs_to :parent
  belongs_to :school_admin
end
