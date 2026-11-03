class PagesController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped
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