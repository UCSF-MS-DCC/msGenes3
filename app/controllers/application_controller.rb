class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError, with: -> { render_404 }

  def render_404
    respond_to do |format|
      format.html { render template: 'errors/not_found', status: :not_found }
      format.all { render nothing: true, status: :not_found }
    end
  end
end
