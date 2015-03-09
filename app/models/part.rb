class Part < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
