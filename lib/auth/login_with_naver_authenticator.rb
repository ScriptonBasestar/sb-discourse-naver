# frozen_string_literal: true


class Auth::LoginWithNaverAuthenticator < ::Auth::ManagedAuthenticator
  def name
    "naver"
  end

  def enabled?
    SiteSetting.enable_login_with_naver
  end

  def register_middleware(omniauth)
    omniauth.provider :naver,
                      setup:
                        lambda { |env|
                          strategy = env["omniauth.strategy"]
                          strategy.options[:client_id] = SiteSetting.login_with_naver_client_id
                          strategy.options[
                            :client_secret
                          ] = SiteSetting.login_with_naver_client_secret
                          
                          if SiteSetting.login_with_naver_scope.present?
                            strategy.options[:scope] = SiteSetting.login_with_naver_scope
                          end
                          
                          if SiteSetting.login_with_naver_redirect_url.present?
                            strategy.options[:redirect_url] = SiteSetting.login_with_naver_redirect_url
                          else
                            strategy.options[:callback_path] = SiteSetting.login_with_naver_redirect_path
                          end
                        }
  end

  def always_update_user_email?
    SiteSetting.login_with_naver_overrides_email
  end

  def primary_email_verified?(auth)
    SiteSetting.login_with_naver_email_verified
  end

  # 네이버 사용자 정보를 Discourse 사용자 정보로 매핑
  def after_authenticate(auth)
    result = super

    # 네이버에서 제공하는 닉네임을 username으로 사용
    if auth.info&.nickname.present?
      result.username = auth.info.nickname
    end

    # 네이버 프로필 이미지 URL 설정
    if auth.info&.image.present?
      result.avatar_url = auth.info.image
    end

    result
  rescue => e
    Rails.logger.error "Naver authentication error: #{e.message}"
    result
  end
end
