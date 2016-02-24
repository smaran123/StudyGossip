class Teacherclass < ActiveRecord::Base
   attr_accessible :cls_id, :subject_id,:user_id,:school_admin_id
  belongs_to :cls
  belongs_to :subject
  belongs_to :user
end
