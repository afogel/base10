# == Schema Information
#
# Table name: industries
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Industry < ApplicationRecord
  has_many :segments
  has_many :companies, through: :segments
end
