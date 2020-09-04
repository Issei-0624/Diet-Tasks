class Diettask < ApplicationRecord
  belongs_to :user
  
    validates :content, presence: true,  length: { maximum: 255 }
     #validates:limit_date, presence: true
     #validates:status, presence: true
end
