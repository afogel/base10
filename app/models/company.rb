# == Schema Information
#
# Table name: companies
#
#  id             :bigint           not null, primary key
#  domain         :string
#  employee_count :integer
#  founders       :string
#  founding_year  :integer
#  hq_city        :string
#  hq_country     :string
#  hq_state       :string
#  hq_zip_code    :string
#  investors      :string
#  name           :string
#  raised         :string
#  round          :string
#  slug           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_companies_on_slug  (slug) UNIQUE
#
class Company < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_and_belongs_to_many :segments
  has_many :industries, through: :segments
  has_and_belongs_to_many :business_models
end
