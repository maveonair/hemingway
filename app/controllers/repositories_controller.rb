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
    @service = User::GithubService.new(current_user)
  end

  def create
    @repository =  Repository.new(repository_params)
    @repository.user = current_user

    if @repository.save
      redirect_to @repository
    else
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
