class Part < ActiveRecord::Base
  has_many :supplier_parts

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
