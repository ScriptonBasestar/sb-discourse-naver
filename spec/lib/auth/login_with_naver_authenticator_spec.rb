# frozen_string_literal: true

require "rails_helper"

RSpec.describe Auth::LoginWithNaverAuthenticator do
  let(:authenticator) { described_class.new }

  describe "#name" do
    it "returns naver" do
      expect(authenticator.name).to eq("naver")
    end
  end

  describe "#enabled?" do
    it "returns site setting value" do
      SiteSetting.enable_login_with_naver = true
      expect(authenticator.enabled?).to eq(true)

      SiteSetting.enable_login_with_naver = false
      expect(authenticator.enabled?).to eq(false)
    end
  end

  describe "#after_authenticate" do
    let(:auth_hash) do
      OmniAuth::AuthHash.new(
        {
          provider: "naver",
          uid: "123456",
          info: {
            nickname: "testuser",
            email: "test@naver.com",
            image: "http://example.com/image.jpg",
          },
        },
      )
    end

    before { SiteSetting.enable_login_with_naver = true }

    it "maps nickname to username" do
      result = authenticator.after_authenticate(auth_hash)
      expect(result.username).to eq("testuser")
    end

    it "sets avatar_url from image" do
      result = authenticator.after_authenticate(auth_hash)
      expect(result.avatar_url).to eq("http://example.com/image.jpg")
    end

    it "handles missing nickname gracefully" do
      auth_hash.info.delete(:nickname)
      result = authenticator.after_authenticate(auth_hash)
      expect(result.username).to be_nil
    end

    it "handles missing image gracefully" do
      auth_hash.info.delete(:image)
      result = authenticator.after_authenticate(auth_hash)
      expect(result.avatar_url).to be_nil
    end

    it "handles errors gracefully" do
      allow(Rails.logger).to receive(:error)
      allow(authenticator).to receive(:super).and_raise(StandardError, "Test error")

      result = authenticator.after_authenticate(auth_hash)
      expect(Rails.logger).to have_received(:error).with("Naver authentication error: Test error")
    end
  end

  describe "#always_update_user_email?" do
    it "returns site setting value" do
      SiteSetting.login_with_naver_overrides_email = true
      expect(authenticator.always_update_user_email?).to eq(true)

      SiteSetting.login_with_naver_overrides_email = false
      expect(authenticator.always_update_user_email?).to eq(false)
    end
  end

  describe "#primary_email_verified?" do
    let(:auth) { instance_double("Auth") }

    it "returns site setting value" do
      SiteSetting.login_with_naver_email_verified = true
      expect(authenticator.primary_email_verified?(auth)).to eq(true)

      SiteSetting.login_with_naver_email_verified = false
      expect(authenticator.primary_email_verified?(auth)).to eq(false)
    end
  end
end
