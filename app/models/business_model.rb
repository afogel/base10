# == Schema Information
#
# Table name: business_models
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class BusinessModel < ApplicationRecord
  has_and_belongs_to_many :companies
end
