# == Schema Information
#
# Table name: quotations
#
#  id          :bigint           not null, primary key
#  author_name :string
#  quote       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_quotations_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Quotation < ApplicationRecord
  belongs_to :category
  validates :author_name, presence: true
  validates :quote, presence: true
end
