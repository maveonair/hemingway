class RunsController < ApplicationController
  def show
    @run = Run.find(params[:id])
    @run = @run.decorate

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @run.parsed_result }
    end
  end

  def inspect
    @run = Run.find(params[:id])
    @run = @run.decorate

    @inspection = @run.inspection(params[:file_path])
  end
end
