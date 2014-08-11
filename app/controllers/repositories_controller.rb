class RepositoriesController < ApplicationController

  def index
    @repositories = Repository.all
  end

  def show
    @repository = Repository.find(params[:id])
  end

  def new
    @repository = Repository.new
  end

  def create
    @repository =  Repository.new(repository_params)
    if @repository.save
      redirect_to @repository
    else
      render 'new'
    end
  end

  def start_run
    repository = Repository.find(params[:id])
    service = Run::Service.new(repository)
    service.run!

    redirect_to repository
  end

  private

  def repository_params
    params.require(:repository).permit(:github_repo_name)
  end
end
