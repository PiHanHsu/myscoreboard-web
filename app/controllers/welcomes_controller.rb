class WelcomesController < ApplicationController

  def index
    if current_user.present?
      redirect_to games_path
    else
      render layout: 'other_page_application.html.erb'
    end
  end

end
