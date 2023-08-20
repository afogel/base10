class CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show edit update destroy ]

  # GET /companies or /companies.json
  def index
    @pagy, @company_entries = pagy(
      CompanyEntry.latest_entries
                  .includes(company: [:business_models, segments: :industry])
                  .order("company_segments.segment_id ASC")
                  .reorder("companies.name ASC")
                  .reorder(sort_column => sort_direction),
      items: params.fetch(:count, 10)
    )
  end
  
  # GET /companies/1 or /companies/1.json
  def show
    @pagy, @company_entries = pagy(
      @company.company_entries.reorder(sort_column => sort_direction), 
      items: params.fetch(:count, 10)
    )
    @annualized = params[:annualized] ? params[:annualized] == "true" : true
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies or /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to company_url(@company), notice: "Company was successfully created." }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1 or /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to company_url(@company), notice: "Company was successfully updated." }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1 or /companies/1.json
  def destroy
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url, notice: "Company was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.fetch(:company, {})
    end

    def sort_column
      %w{ entry_date entry_period revenue cash_burn gross_profit gross_profit_pct ebitda cash_on_hand cac ltv arpu customer_count next_fundraise_at }.include?(params[:sort]) ? params[:sort] : "entry_date"
    end
  
    def sort_direction
      %w{ asc desc }.include?(params[:direction]) ? params[:direction] : "asc"
    end
end
