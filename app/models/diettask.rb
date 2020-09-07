class Diettask < ApplicationRecord
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  validates :content, presence: true, length: { maximum: 255 }
  #validates:limit_date, presence: true
  #validates:status, presence: true
end
