# Hemingway

## Dependencies
```sh
$ brew install redis-server
$ brew install libssh2
```

## Bundler configuration
```sh
$ bundle install --path=.bundle
```

## Start Sidekiq
Hint: redis-server must be running.

```sh
$ bundle exec sidekiq
```
