class RunsController < ApplicationController
  load_and_authorize_resource :repository
  load_and_authorize_resource :run, through: :repository

  before_action :decorate_run

  def inspect
    @inspection = @run.inspection(params[:file_path])
  end

  private

  def decorate_run
    @run = @run.decorate
  end
end
