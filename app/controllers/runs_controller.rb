class RunsController < ApplicationController
  load_and_authorize_resource :repository
  load_and_authorize_resource :run, through: :repository

  def show
    @run = @run.decorate
  end

  def inspect
    file_path = Base64.urlsafe_decode64(runs_params[:file_path])
    @facade = InspectionFacade.new(current_user, @run, file_path)
  end

  private

  def runs_params
    params.permit(:file_path)
  end
end
