module CompaniesHelper
  def industry_names(company)
    company.industries.map(&:name).join(", ")
  end

  def business_model_names(company)
    company.business_models.map(&:name).join(", ")
  end
  
  def segment_names(company)
    company.segments.map(&:name).join(", ")
  end
end
