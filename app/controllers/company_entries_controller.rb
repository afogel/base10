class CompanyEntriesController < ApplicationController
  before_action :set_company
  before_action :set_company_entry, only: %i[ show edit update destroy ]

  # GET /company_entries or /company_entries.json
  def index
    @company_entries = CompanyEntry.all
  end

  # GET /company_entries/1 or /company_entries/1.json
  def show
  end

  # GET /company_entries/new
  def new
    @company_entry = CompanyEntry.new
    @sources = Source.all
  end

  # GET /company_entries/1/edit
  def edit
    @sources = Source.all
  end

  # POST /company_entries or /company_entries.json
  def create
    @company_entry = @company.company_entries.new(company_entry_params)
    @company_entry.user = current_user

    respond_to do |format|
      if @company_entry.save
        format.html { redirect_to company_url(@company), notice: "Company entry was successfully created." }
        format.json { render :show, status: :created, location: @company_entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /company_entries/1 or /company_entries/1.json
  def update
    respond_to do |format|
      if @company_entry.update(company_entry_params)
        format.html { redirect_to company_url(@company), notice: "Company entry was successfully updated." }
        format.json { render :show, status: :ok, location: @company_entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_entries/1 or /company_entries/1.json
  def destroy
    @company_entry.destroy

    respond_to do |format|
      format.html { redirect_to company_entries_url, notice: "Company entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_entry
      @company_entry = CompanyEntry.find(params[:id])
    end

    def set_company
      @company = Company.friendly.find(params[:company_id])
    end

    # Only allow a list of trusted parameters through.
    def company_entry_params
      params.require(:company_entry).permit(:entry_date, :entry_period, :revenue, :cash_burn, :gross_profit, :gross_profit_pct, :ebitda, :cash_on_hand, :cac, :ltv, :arpu, :customer_count, :next_fundraise_at, :source_id)
    end
end
