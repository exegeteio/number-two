class HomeController < ApplicationController
  def root
    redirect_to dashboard_index_path if current_user.present?
  end
end
