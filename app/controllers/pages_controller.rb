class PagesController < ApplicationController
  def home
  end

  def about
  end

  def services
    @services = Service.where(is_active: true).order(:name)
  end

  def visiting
  end
end