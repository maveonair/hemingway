class RunsController < ApplicationController
  load_and_authorize_resource :repository
  load_and_authorize_resource :run, through: :repository

  before_action :decorate_run

  def inspect
    @inspection = @run.inspection(params[:file_path])
    octokit = Octokit::Client.new(access_token: current_user.token)
    contents = octokit.contents(@run.name, ref: @run.revision, path: params[:file_path])

    @content = Base64.decode64(contents.content)
  end

  private

  def decorate_run
    @run = @run.decorate
  end
end
