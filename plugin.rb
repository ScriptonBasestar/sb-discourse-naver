# frozen_string_literal: true

# name: sb-discourse-naver
# about: discourse plugin for Naver login and other features
# meta_topic_id:
# version: 0.2.0
# authors: archmagece
# url: https://github.com/scriptonbasestar/sb-discourse-naver

# Load validator before site settings are initialized
require_relative "lib/validators/enable_login_with_naver_validator"

enabled_site_setting :enable_login_with_naver

register_svg_icon "naver"

require_relative "lib/omniauth/strategies/naver"
require_relative "lib/auth/login_with_naver_authenticator"

auth_provider authenticator: Auth::LoginWithNaverAuthenticator.new, icon: "naver"
