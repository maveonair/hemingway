require 'test_helper'

class RepositoriesControllerTest < ActionController::TestCase
  def setup
    login(:maveonair)
  end

  test 'index with authorized_user' do
    get :index

    assert_response :success
    assert_not_nil assigns(:repositories)
  end

  test 'show a repository' do
    phrase = repositories(:phrase)
    get :show, id: phrase.id

    assert_response :success
  end

  test 'choose an account' do
    organization = OpenStruct.new(id: 43,
                   name: 'maveonair.io',
                   avatar_url: 'http://placehold.it/100x100')
    Repository::Github::RepositoryService.any_instance.stubs(:organizations).returns([organization])

    get :choose_account

    assert_response :success
    assert_match 'Select your account or organization', response.body
    assert_match organization.name, response.body
  end

  test 'select project' do
    repository = OpenStruct.new(name: 'Awesome Blog', private?: true)
    Repository::Github::RepositoryService.any_instance.stubs(:repositories).returns([repository])

    get :new

    assert_response :success
    assert_match 'Select project', response.body
    assert_match repository.name, response.body
  end

  test 'create a repository' do
    repository_details = OpenStruct.new(
                          html_url: 'https://github.com/maveonair/hemingway',
                          ssh_url: 'git@github.com:maveonair/hemingway.git')
    Repository::Github::AddDeploymentService.any_instance.stubs(:repository_details).returns(repository_details)
    Repository::Github::AddDeploymentService.any_instance.stubs(:add_deploy_key!)

    post :create, repository: { name: 'maveonair/hemingway' }

    assert_redirected_to Repository.find_by_name('maveonair/hemingway')
  end

  test 'remove a repository' do
    Repository::Github::RemoveDeploymentService.any_instance.stubs(:remove_deploy_key!)

    delete :destroy, id: repositories(:kado).id

    assert_redirected_to controller: 'repositories', action: 'index'
  end

  test 'start a run' do
    Run::Service.any_instance.stubs(:run!)
    phrase = repositories(:phrase)

    post :start_run, id: phrase.id

    assert_redirected_to phrase
  end

  test 'access project settings' do
    get :settings, id: repositories(:phrase).id

    assert_response :success
    assert_match 'Danger Zone', response.body
  end
end
