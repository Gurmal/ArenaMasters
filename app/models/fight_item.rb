class FightItem < ApplicationRecord
  belongs_to :fight
  belongs_to :gladiator
end
