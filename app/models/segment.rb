# == Schema Information
#
# Table name: segments
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  industry_id :bigint
#
# Indexes
#
#  index_segments_on_industry_id  (industry_id)
#
class Segment < ApplicationRecord
  belongs_to :industry
  has_and_belongs_to_many :companies
end
