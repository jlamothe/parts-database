class Supplier < ActiveRecord::Base
  has_many :supplier_parts

  validates :name, presence: true, uniqueness: true
end
