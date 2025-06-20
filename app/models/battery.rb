class Battery < ApplicationRecord
has_many :availabilities

validates :name, presence: true
validates :capacity, numericality: { greater_than: 0 }
end
