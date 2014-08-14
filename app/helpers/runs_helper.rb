module RunsHelper

  def severity_label(severity)
    content_tag :span, severity, :class => "label label-severity-#{severity}"
  end

  def github_blame_url(run, file_path, line)
    "https://github.com/#{run.name}/blob/#{run.revision}/#{file_path}#L#{line}"
  end
end
