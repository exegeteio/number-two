# frozen_string_literal: true

# Home controller for introducing the site.
class HomeController < ApplicationController
  def index
    redirect_to(dashboard_url) if current_user.present?
  end
end
