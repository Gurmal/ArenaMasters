class Fight < ApplicationRecord
	belongs_to :event
	has_many :fight_items, dependent: :destroy
	has_many :gladiators, through: :fight_items
end
