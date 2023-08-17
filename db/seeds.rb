# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'typhoeus'
require 'nokogiri'

def get_substring_match(elements, class_substring)
  elements.select do |element|
    element['class']&.include?(class_substring)
  end
end
industries = [
  {
    url: "https://base10.vc/research/food-tech",
    name: 'Food Tech'
  }, 
  {
    url: "https://base10.vc/research/retail",
    name: 'Retail'
  },
  {
    url: "https://base10.vc/research/african-fintech",
    name: 'FinTech'
  }
]
BusinessModel.create(name: 'Subscription')
BusinessModel.create(name: 'Transactional')
business_models = BusinessModel.all

industries.each do |industry|
  segments = []
  first = Typhoeus::Request.get(industry[:url])
  # debugger
  doc = Nokogiri::HTML.parse(first.body)
  elements = doc.css('*')
  
  # Select elements whose class attribute includes the specified substring
  selected_tables = get_substring_match(elements, 'research-detail__MarketBorderDivTable')
  selected_tables.each do |table|
    trend_map = {}
    name = get_substring_match(table.css('*'), 'research-detail__MarketGraphTitle').first&.children.text
    description = get_substring_match(table.css('*'), 'research-detail__MarketGraphSubTitle').first&.children&.text
    next if description.nil?
    companies = []
    get_substring_match(table.css('*'), 'research-detail__TrendTRCompany').each do |company|
      parsed_info = company.css('*').map(&:text).map {|el| el.gsub("more", "")}.uniq
      company_map = {}
      company_name = parsed_info[0].empty? ? company.css("img")[0].attr('alt') : parsed_info[0]
      company_map[:name] = company_name
      company_map[:year] = parsed_info[1]
      company_map[:round] = parsed_info[2]
      company_map[:raised] = parsed_info[3]
      company_map[:employees] = parsed_info[4]
      company_map[:location] = parsed_info[5]
      company_map[:founders] = parsed_info[6]
      company_map[:investors] = parsed_info[-1]
      companies << company_map
    end
    trend_map[:name] = name
    trend_map[:description] = description
    trend_map[:companies] = companies
    segments << trend_map
  end
  industry[:segments] = segments
end

industries.each do |industry_raw|
  industry = Industry.find_or_create_by!(name: industry_raw[:name])
  industry_raw[:segments].each do |segment_raw|
    segment = industry.segments.find_or_create_by!(name: segment_raw[:name], description: segment_raw[:description])
    segment_raw[:companies].each_with_index do |company_raw, idx|
      hq_city, hq_country = company_raw[:location].split(",").map(&:strip)

      company = segment.companies.find_or_create_by!(
        name: company_raw[:name],
        founding_year: company_raw[:year] == '-' ? nil : company_raw[:year].to_i,
        round: company_raw[:round] == '-' ? nil : company_raw[:round],
        raised: company_raw[:raised] == '-' ? nil : company_raw[:raised],
        employee_count: company_raw[:employees] == '-' ? nil : company_raw[:employees].to_i,
        founders: company_raw[:founders] == '-' ? nil : company_raw[:founders],
        investors: company_raw[:investors] == '-' ? nil : company_raw[:investors],
        hq_city:,
        hq_country:
      )
      company.business_models.push(idx % 3 == 0 ? business_models : business_models[idx % 2])
    end
  end
end

sources = [
  {
    name: 'pitch deck',
    location: 'some url'
  },
  {
    name: 'call notes',
    location: 'some url'
  },
  {
    name: 'call notes 2',
    location: 'some url'
  }
]

sources.each do |source|
  Source.find_or_create_by!(
    name: source[:name], location: source[:location]
  )
end

user = User.create(name: 'Ariel Fogel', email: 'fogeltine@gmail.com', password: 'password', admin: true)
potential_values = {
  arpu: 1000.times.map { rand(1..1000) % 2 == 0 ? nil : rand(1..1000) },
  cac: 1000.times.map { rand(1..1000) % 2 == 0 ? nil : rand(1..1000) },
  cash_burn: 1000.times.map { rand(1..1000) % 2 == 0 ? nil : rand(1..1000) },
  cash_on_hand: 1000.times.map { rand(1..1000) % 2 == 0 ? nil : rand(1..1000) },
  customer_count: 1000.times.map { rand(1000..10000000) % 2 == 0 ? nil : rand(1000..10000000) },
  ebitda: 1000.times.map { rand(1..1000) % 2 == 0 ? nil : rand(1..1000) },
  entry_date: 1000.times.map { Date.today - rand(1..1000) },
  entry_period: [:annual, :quarterly, :monthly],
  gross_profit: 1000.times.map { rand(1..1000) % 2 == 0 ? nil : rand(1..1000) },
  gross_profit_pct: 1000.times.map { rand < 0.5 == 0 ? nil : (rand * 100.0).truncate(2) },
  ltv: 1000.times.map { rand(1..1000) % 2 == 0 ? nil : rand(1..1000) },
  next_fundraise_at: 1000.times.map { Date.today + rand(1..1000) },
  revenue: 1000.times.map { rand(1..1000) % 2 == 0 ? nil : rand(1..1000) }
}
source_records = Source.all
Company.all.each_with_index do |company, idx|
  # randomly create 1-5 entries for each company
  rand(1..5).times do
    company.company_entries.create(
      user: user,
      source: source_records.sample,
      entry_date: potential_values[:entry_date].sample,
      entry_period: potential_values[:entry_period].sample,
      revenue: potential_values[:revenue].sample,
      cash_burn: potential_values[:cash_burn].sample,
      gross_profit: potential_values[:gross_profit].sample,
      gross_profit_pct: potential_values[:gross_profit_pct].sample,
      ebitda: potential_values[:ebitda].sample,
      cash_on_hand: potential_values[:cash_on_hand].sample,
      cac: potential_values[:cac].sample,
      ltv: potential_values[:ltv].sample,
      arpu: potential_values[:arpu].sample,
      customer_count: potential_values[:customer_count].sample,
      next_fundraise_at: potential_values[:next_fundraise_at].sample
    )
  end
end