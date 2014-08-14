class WelcomeController < ApplicationController
  skip_filter :authorize
  layout 'guest'

  def index
  end
end
