# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

**sb-discourse-naver**: Discourse plugin for Naver OAuth login integration.

| Item | Value |
|------|-------|
| Features | Naver OAuth2 login |
| Languages | 48+ locales (full i18n support) |
| Auth Provider | `auth_provider authenticator: ... icon: "naver"` |

---

## Quick Commands

```bash
# Tests (from Discourse directory)
bundle exec rspec plugins/sb-discourse-naver/spec/

# Linting
bundle exec rubocop plugins/sb-discourse-naver/
```

---

## Architecture

### OAuth2 Flow

```
User clicks "Login with Naver"
→ Redirect to nid.naver.com/oauth2.0/authorize
→ User authorizes on Naver
→ Callback to /auth/naver/callback
→ Exchange code for token at nid.naver.com/oauth2.0/token
→ Fetch user info from openapi.naver.com/v1/nid/me
→ Create/update Discourse user
```

### Core Components

| Component | Location | Purpose |
|-----------|----------|---------|
| `OmniAuth::Strategies::Naver` | lib/omniauth/strategies/naver.rb | OAuth2 strategy |
| `Auth::LoginWithNaverAuthenticator` | lib/auth/login_with_naver_authenticator.rb | Discourse authenticator |
| `EnableLoginWithNaverValidator` | lib/validators/ | Settings validator |

### OmniAuth Strategy

```ruby
# Naver API endpoints
site: "https://nid.naver.com"
authorize_url: "https://nid.naver.com/oauth2.0/authorize"
token_url: "https://nid.naver.com/oauth2.0/token"
user_info_url: "https://openapi.naver.com/v1/nid/me"

# User info mapping
uid: response["id"]
name: response["name"]
email: response["email"]           # Naver provides email by default
nickname: response["nickname"]
image: response["profile_image"]   # Strips low-res suffix
gender: response["gender"]         # M/F → male/female
```

---

## Key Settings

```yaml
# Core
enable_login_with_naver: false          # Enable/disable (default: off)

# OAuth Credentials (secret)
login_with_naver_client_id: ""          # Client ID from Naver Developers
login_with_naver_client_secret: ""      # Client Secret

# Scope (optional - Naver auto-provides profile/email)
login_with_naver_scope: ""

# Callback
login_with_naver_redirect_url: ""       # Full URL (takes priority)
login_with_naver_redirect_path: "/auth/naver/callback"  # Path only

# Email handling
login_with_naver_overrides_email: false # Override existing user email
login_with_naver_email_verified: true   # Trust Naver's email verification
```

---

## Directory Structure

```
sb-discourse-naver/
├── plugin.rb                    # Entry, auth_provider registration
├── config/
│   ├── settings.yml             # Site settings
│   └── locales/                 # 48+ language files
├── lib/
│   ├── omniauth/strategies/
│   │   └── naver.rb             # OmniAuth OAuth2 strategy
│   ├── auth/
│   │   └── login_with_naver_authenticator.rb
│   └── validators/
│       └── enable_login_with_naver_validator.rb
└── assets/images/
    └── naver.svg                # Naver icon
```

---

## Naver Developer Setup

1. Go to https://developers.naver.com/
2. Create application (애플리케이션 등록)
3. Select "네이버 로그인" API
4. Add callback URL: `https://your-site.com/auth/naver/callback`
5. Get Client ID and Client Secret
6. Select required user info permissions

### User Info Permissions

| Field | Description | Notes |
|-------|-------------|-------|
| `email` | Email address | Auto-provided |
| `name` | Real name | Auto-provided |
| `nickname` | Nickname | Auto-provided |
| `profile_image` | Profile picture | Auto-provided |
| `gender` | Gender (M/F) | Optional |

**Note**: Unlike Kakao, Naver provides email by default without business approval.

---

## Testing

```bash
# Test OAuth flow manually
# 1. Enable plugin in admin settings
# 2. Configure client_id and client_secret
# 3. Visit /login and click Naver button
# 4. Check rails logs for auth flow
```

---

## Differences from Kakao Plugin

| Feature | Naver | Kakao |
|---------|-------|-------|
| Email access | Default | Requires business approval |
| API response | `response` wrapper | Direct `kakao_account` |
| Scope | Optional | Required for features |
| Gender field | Supported | Not provided |

---

## Common Issues

### Profile Image Shows Placeholder
- Naver returns `nodata_33x33.gif` for users without profile image
- Strategy filters this out automatically

### Callback URL Mismatch
- Ensure redirect URL matches Naver Developer Console exactly
- Use `login_with_naver_redirect_url` for full URL control

---

## Rules

- Store OAuth secrets securely (secret: true in settings.yml)
- Support full i18n (48+ locales maintained)
- Filter out placeholder profile images
- Use `ManagedAuthenticator` base class for standard behavior
- Register SVG icon for login button display
