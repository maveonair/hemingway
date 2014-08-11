class WelcomeController < ApplicationController
  def index
    @repository = Repository.new
  end
end
