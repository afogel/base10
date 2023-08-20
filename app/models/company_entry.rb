# == Schema Information
#
# Table name: company_entries
#
#  id                      :bigint           not null, primary key
#  arpu                    :integer
#  cac                     :integer
#  cash_burn               :integer
#  cash_burn_annualized    :integer
#  cash_on_hand            :integer
#  customer_count          :integer
#  ebitda                  :integer
#  ebitda_annualized       :integer
#  entry_date              :date
#  entry_period            :enum             default("annual")
#  gross_profit            :integer
#  gross_profit_annualized :integer
#  gross_profit_pct        :decimal(, )
#  ltv                     :integer
#  next_fundraise_at       :date
#  revenue                 :integer
#  revenue_annualized      :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  company_id              :bigint           not null
#  source_id               :bigint           not null
#  user_id                 :bigint           not null
#
# Indexes
#
#  index_company_entries_on_company_id  (company_id)
#  index_company_entries_on_source_id   (source_id)
#  index_company_entries_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (source_id => sources.id)
#  fk_rails_...  (user_id => users.id)
#
class CompanyEntry < ApplicationRecord
  belongs_to :user
  belongs_to :source
  belongs_to :company
  enum entry_period: { 
    annual: "year", quarterly: "quarter", monthly: 'month'
  }
  delegate :name, :segments, :industries, to: :company

  validates :entry_date, uniqueness: { scope: :company_id }, presence: true

  scope :freshest_company_data_date, -> { select(:company_id, "MAX(entry_date) AS entry_date").group(:company_id) }
  scope :latest_entries, -> do 
    with(
      recent_entries: CompanyEntry.freshest_company_data_date
    ).joins(
      "INNER JOIN recent_entries 
      ON recent_entries.company_id = company_entries.company_id 
      AND recent_entries.entry_date = company_entries.entry_date".strip
    )
  end

  ANNUALIZED_FIELDS = %i[revenue cash_burn gross_profit ebitda].freeze

  def annualize(field)
    raise ArgumentError, "Field must be one of #{ANNUALIZED_FIELDS}" unless ANNUALIZED_FIELDS.include?(field)
    return if self[field].nil?
    case self[:entry_period]
    when "quarterly"
      self[field] * 4
    when "monthly"
      self[field] * 12
    else
      self[field]
    end
  end
end
