class RunsController < ApplicationController
  before_filter :set_run

  def show
    @run = @run.decorate

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @run.parsed_result }
    end
  end

  def inspect
    @run = @run.decorate

    @inspection = @run.inspection(params[:file_path])
  end

  private

  def set_run
    repository = Repository.find(params[:repository_id])
    @run = repository.runs.find(params[:id])    
  end

end
