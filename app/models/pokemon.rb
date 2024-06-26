class Pokemon < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :primary_type, presence: true
  validates :total, presence: true
  validates :hp, presence: true
  validates :attack, presence: true
  validates :defense, presence: true
  validates :sp_atk, presence: true
  validates :sp_def, presence: true
  validates :speed, presence: true
  validates :generation, presence: true
end
