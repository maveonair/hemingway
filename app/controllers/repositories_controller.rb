class RepositoriesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :create

  def index
    @repositories = RepositoryDecorator.decorate_collection(@repositories)
  end

  def show
    @repository = @repository.decorate
  end

  def new
    @service = Repository::Github::Service.new(current_user)
  end

  def create
    @service = Repository::Github::DeploymentService.new(current_user, repository_params)
    if @service.save
      redirect_to @service.repository
    else
      flash[:alert] = 'Some errors occured, please try again.'
      render 'new'
    end
  end

  def start_run
    service = Run::Service.new(@repository)
    service.run!

    redirect_to @repository
  end

  private

  def repository_params
    params.require(:repository).permit(:name)
  end
end
