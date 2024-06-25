class Tip < ApplicationRecord
    validates :total_amount, :split, :personal_payout, :occurred_on, presence: true
  
    belongs_to :user
  
   
end
