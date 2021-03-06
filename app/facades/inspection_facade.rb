class InspectionFacade
  attr_reader :file_path, :run

  def initialize(user, run, file_path)
    @user = user
    @run = run
    @file_path = file_path
  end

  def repository
    run.repository
  end

  def inspection
    @inspection ||= run.inspection(file_path)
  end

  def content
    response = content_service.contents(run.name, run.revision, file_path)
    Base64.decode64(response.content)
  end

  private

  attr_reader :user

  def content_service
    @content_service ||= Repository::Github::ContentService.new(user)
  end
end
