# frozen_string_literal: true

# name: sb-discourse-naver
# about: discourse plugin for Naver login and other features
# meta_topic_id:
# version: 0.1.0
# authors: archmagece
# url: https://github.com/scriptonbasestar/sb-discourse-naver

enabled_site_setting :enable_login_with_naver

gem "sb-omniauth-naver", "0.3.5"
# gem 'sb-omniauth-naver', git: 'git@github.com:ScriptonBasestar/sb-omniauth-naver.git'

# register_asset "stylesheets/discourse-custom-oauth-icons.scss"
register_svg_icon "naver"

after_initialize do
  require "sb-omniauth-naver"
  # require_relative "lib/omniauth/strategies/naver"

  require_relative "lib/auth/login_with_naver_authenticator"
  require_relative "lib/validators/enable_login_with_naver_validator"

  auth_provider authenticator: Auth::LoginWithNaverAuthenticator.new, icon: "naver"
end
