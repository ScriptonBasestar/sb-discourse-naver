# frozen_string_literal: true

# name: sb-discourse-naver
# about: discourse plugin for Naver login and other features
# meta_topic_id:
# version: 0.0.1
# authors: archmagece
# url: https://github.com/scriptonbasestar/sb-discourse-naver

enabled_site_setting :enable_login_with_naver

# gem "omniauth-naver"
# gem "sb-omniauth-naver"

# register_asset "stylesheets/discourse-custom-oauth-icons.scss"
register_svg_icon "naver"

require_relative "lib/omniauth/strategies/naver"

require_relative "lib/auth/login_with_naver_authenticator"
require_relative "lib/validators/enable_login_with_naver_validator"

auth_provider authenticator: Auth::LoginWithNaverAuthenticator.new, icon: "naver"
