class Event < ApplicationRecord
	has_many :fights
	has_many :teams
end
