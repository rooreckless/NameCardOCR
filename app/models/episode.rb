class Episode < ApplicationRecord
  validates :content, presence: true
  belongs_to :card
  belongs_to :user
end
