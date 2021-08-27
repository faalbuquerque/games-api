class Game < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :genre, presence: true
  validates :grade, presence: true
end
