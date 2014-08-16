class RepositoriesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: [:create, :settings]

  def index
    @repositories = RepositoryDecorator.decorate_collection(@repositories)
  end

  def show
    @repository = @repository.decorate
  end

  def create
    @service = Repository::Github::AddDeploymentService.new(current_user, repository_params)
    if @service.save
      redirect_to @service.repository
    else
      flash[:alert] = 'Some errors occured, please try again.'
      render 'settings'
    end
  end

  def destroy
    @service = Repository::Github::RemoveDeploymentService.new(current_user, @repository)
    @service.destroy!

    redirect_to [:settings, :repositories], notice: 'Repository was successfuly removed.'
  end

  def settings
    @service = Repository::Github::Service.new(current_user)
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
