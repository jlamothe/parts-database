class SupplierPart < ActiveRecord::Base
  belongs_to :part
  belongs_to :supplier

  validates :part, presence: true
  validates :supplier, presence: true
end
