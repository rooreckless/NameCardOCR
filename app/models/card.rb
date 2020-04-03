class Card < ApplicationRecord
  validates :name, :company , presence: true
  belongs_to :user
  has_many :episodes, dependent: :destroy
end
