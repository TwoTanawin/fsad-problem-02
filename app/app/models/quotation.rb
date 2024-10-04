class Quotation < ApplicationRecord
  belongs_to :category
  validates :author_name, presence: true
  validates :quote, presence: true
end
