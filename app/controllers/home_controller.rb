class HomeController < ApplicationController
  def index
    redirect_to companies_path if current_user
  end

  def terms
  end

  def privacy
  end
end
