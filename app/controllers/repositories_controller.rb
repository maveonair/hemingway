class RepositoriesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :create

  def index
    @repositories = RepositoryDecorator.decorate_collection(@repositories)
  end

  def show
    @repository = @repository.decorate
  end

  def choose_account
    @service = Repository::Github::RepositoryService.new(current_user, params[:organization_id])
  end

  def new
    @service = Repository::Github::RepositoryService.new(current_user, params[:organization_id])
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

    redirect_to :repositories, notice: 'Repository was successfuly unfollowed.'
  end

  def start_run
    service = Run::Service.new(@repository)
    service.run!

    redirect_to @repository, notice: 'A refresh of this repositoriy is queued. Check back in a few minutes.'
  end

  def settings
  end

  private

  def repository_params
    params.require(:repository).permit(:name)
  end
end
