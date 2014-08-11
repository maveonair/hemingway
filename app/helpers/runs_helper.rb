module RunsHelper

  def severity_label(severity)
    content_tag :span, severity, :class => "label label-severity-#{severity}"
  end

  def github_blame_url(run, file_path, line)
    "https://github.com/#{run.github_repo_name}/blob/#{run.commit}/#{file_path}#L#{line}"
  end
end
