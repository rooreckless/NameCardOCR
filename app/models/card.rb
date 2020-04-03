class Card < ApplicationRecord
  validates :name, :company , presence: true
  belongs_to :user
  as_many :episodes
end
