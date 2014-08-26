Rails.application.config.middleware.use(OmniAuth::Builder) do
  provider(:github,
          Rails.application.secrets.github_key,
          Rails.application.secrets.github_secret,
          scope: 'repo, user:email')
end
