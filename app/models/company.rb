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
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Company < ApplicationRecord
  has_and_belongs_to_many :segments
  has_many :industries, through: :segments
  has_and_belongs_to_many :business_models
end
