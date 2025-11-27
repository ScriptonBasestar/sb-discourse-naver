# Login with Naver Plugin for Discourse / Discourse 네이버 로그인 플러그인

[![Discourse Version](https://img.shields.io/badge/discourse-3.1.999%2B-blue.svg)](https://www.discourse.org/)
[![Plugin Version](https://img.shields.io/badge/version-0.2.0-green.svg)](https://github.com/scriptonbasestar/sb-discourse-naver)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A Discourse plugin that enables authentication via Naver Login (OAuth 2.0) for Korean users.

Discourse에서 네이버 로그인(OAuth 2.0)을 통한 인증을 가능하게 하는 플러그인입니다.

## 🌟 Features / 주요 기능

### English
- **OAuth 2.0 Integration**: Secure authentication via Naver Login API
- **Auto User Creation**: Automatically create user accounts from Naver profile data
- **Profile Sync**: Sync profile pictures, nicknames, and email from Naver
- **Flexible Configuration**: Configurable OAuth scopes and redirect URLs
- **Multilingual Support**: Full Korean and English locale support
- **Discourse 3.1.999+ Compatible**: Supports latest Discourse versions up to 3.5.0

### 한국어
- **OAuth 2.0 연동**: 네이버 로그인 API를 통한 안전한 인증
- **자동 계정 생성**: 네이버 프로필 정보로 사용자 계정 자동 생성
- **프로필 동기화**: 네이버의 프로필 사진, 닉네임, 이메일 동기화
- **유연한 설정**: OAuth 스코프 및 리디렉션 URL 설정 가능
- **다국어 지원**: 완전한 한국어 및 영어 로케일 지원
- **Discourse 3.1.999+ 호환**: 최신 Discourse 3.5.0 버전까지 지원

## 📋 Requirements / 시스템 요구사항

### English
- Discourse 3.1.999 or higher
- Ruby 3.0+ (matching your Discourse installation)
- Valid Naver Developers account and registered application
- SSL/HTTPS enabled domain (required by Naver OAuth)

### 한국어
- Discourse 3.1.999 이상
- Ruby 3.0+ (Discourse 설치 버전과 일치)
- 유효한 네이버 개발자 계정 및 등록된 앱
- SSL/HTTPS가 활성화된 도메인 (네이버 OAuth 필수 요구사항)

## 🚀 Installation / 설치 방법

### English

#### 1. Add Plugin to Discourse

Add the following line to your `app.yml` file in the `hooks.after_code` section:

```yaml
hooks:
  after_code:
    - exec:
        cd: $home/plugins
        cmd:
          - git clone https://github.com/scriptonbasestar/sb-discourse-naver.git
```

#### 2. Rebuild Discourse

```bash
cd /var/discourse
./launcher rebuild app
```

### 한국어

#### 1. Discourse에 플러그인 추가

`app.yml` 파일의 `hooks.after_code` 섹션에 다음 줄을 추가합니다:

```yaml
hooks:
  after_code:
    - exec:
        cd: $home/plugins
        cmd:
          - git clone https://github.com/scriptonbasestar/sb-discourse-naver.git
```

#### 2. Discourse 재빌드

```bash
cd /var/discourse
./launcher rebuild app
```

## ⚙️ Naver Developers Configuration / 네이버 개발자센터 설정

### English

#### 1. Create Naver Application

1. Visit [Naver Developers](https://developers.naver.com/)
2. Sign in with your Naver account
3. Click "Application" → "애플리케이션 등록" (Register Application)
4. Fill in application details:
   - **Application Name**: Your Discourse site name
   - **Use API**: Select "네이버 로그인" (Naver Login)

#### 2. Configure OAuth Settings

1. Go to your application dashboard
2. Navigate to "API 설정" (API Settings)
3. Configure the following:
   - **Provide Information**: Select required fields
     - ✅ **Email Address** (이메일 주소)
     - ✅ **Nickname** (닉네임)
     - ✅ **Profile Image** (프로필 사진)
   - **Service URL**: `https://yourdiscourse.com`
   - **Callback URL**: `https://yourdiscourse.com/auth/naver/callback`

**Important Notes**:
- Callback URL must match exactly (including https://)
- No trailing slash in callback URL
- Service URL must be a valid HTTPS domain

#### 3. Get Application Keys

1. Go to "API 설정" (API Settings) in your application
2. Copy the following:
   - **Client ID** → Use as Client ID
   - **Client Secret** → Use as Client Secret
3. Keep these keys secure - never commit them to version control

### 한국어

#### 1. 네이버 애플리케이션 생성

1. [네이버 개발자센터](https://developers.naver.com/) 방문
2. 네이버 계정으로 로그인
3. "Application" → "애플리케이션 등록" 클릭
4. 애플리케이션 정보 입력:
   - **애플리케이션 이름**: Discourse 사이트 이름
   - **사용 API**: "네이버 로그인" 선택

#### 2. OAuth 설정 구성

1. 애플리케이션 대시보드로 이동
2. "API 설정"으로 이동
3. 다음 항목 설정:
   - **제공 정보**: 필요한 필드 선택
     - ✅ **이메일 주소**
     - ✅ **닉네임**
     - ✅ **프로필 사진**
   - **서비스 URL**: `https://yourdiscourse.com`
   - **Callback URL**: `https://yourdiscourse.com/auth/naver/callback`

**주의사항**:
- Callback URL은 정확히 일치해야 함 (https:// 포함)
- Callback URL 끝에 슬래시(/) 없음
- 서비스 URL은 유효한 HTTPS 도메인이어야 함

#### 3. 애플리케이션 키 확인

1. 애플리케이션의 "API 설정"으로 이동
2. 다음 정보 복사:
   - **Client ID** → Client ID로 사용
   - **Client Secret** → Client Secret으로 사용
3. 이 키들은 안전하게 보관 - 절대 버전 관리에 커밋하지 마세요

## 🔧 Discourse Configuration / Discourse 설정

### English

1. Go to your Discourse Admin Panel → Settings
2. Search for "naver" or navigate to Login settings
3. Configure the following settings:

| Setting | Description | Example |
|---------|-------------|---------|
| `enable login with naver` | Enable Naver login | ✅ Checked |
| `login with naver client id` | Client ID from Naver | `a1b2c3d4e5f6g7h8...` |
| `login with naver client secret` | Client Secret from Naver | `x1y2z3a4b5c6d7e8...` |
| `login with naver scope` | OAuth2 scopes (optional) | Leave empty (auto-provided) |
| `login with naver redirect url` | Custom redirect URL (optional) | Leave empty for default |
| `login with naver overrides email` | Override existing user email | ⬜ Unchecked (recommended) |

**Note**: Naver automatically provides profile information (nickname, email, image) without explicit scope configuration.

### 한국어

1. Discourse 관리자 패널 → 설정으로 이동
2. "naver" 검색 또는 로그인 설정으로 이동
3. 다음 설정들을 구성:

| 설정 | 설명 | 예시 |
|------|------|------|
| `enable login with naver` | 네이버 로그인 활성화 | ✅ 체크 |
| `login with naver client id` | 네이버의 Client ID | `a1b2c3d4e5f6g7h8...` |
| `login with naver client secret` | 네이버의 Client Secret | `x1y2z3a4b5c6d7e8...` |
| `login with naver scope` | OAuth2 스코프 (선택사항) | 비워두기 (자동 제공) |
| `login with naver redirect url` | 커스텀 리디렉션 URL (선택사항) | 기본값 사용시 비워두기 |
| `login with naver overrides email` | 기존 사용자 이메일 덮어쓰기 | ⬜ 해제 (권장) |

**참고**: 네이버는 명시적인 스코프 설정 없이도 프로필 정보(닉네임, 이메일, 이미지)를 자동으로 제공합니다.

## 🧪 Development Setup / 개발 환경 설정

### English

#### 1. Local Development with Localhost

For development with `localhost:4200`:

1. **Naver Developer Settings**:
   - Service URL: `http://localhost:4200`
   - Callback URL: `http://localhost:4200/auth/naver/callback`

2. **Start Rails Server**:
   ```bash
   REDIRECT_URL_ORIGIN=http://localhost:4200 rails s
   ```

3. **Discourse Settings**:
   - Enable: `enable local logins: false` (optional)
   - Enable: `login required: false` (optional)

#### 2. Plugin Development

```bash
# Clone the repository
git clone https://github.com/scriptonbasestar/sb-discourse-naver.git

# Install dependencies
bundle install

# Run tests
bundle exec rspec
```

### 한국어

#### 1. 로컬 개발 환경 (localhost)

`localhost:4200`에서 개발하는 경우:

1. **네이버 개발자센터 설정**:
   - 서비스 URL: `http://localhost:4200`
   - Callback URL: `http://localhost:4200/auth/naver/callback`

2. **Rails 서버 시작**:
   ```bash
   REDIRECT_URL_ORIGIN=http://localhost:4200 rails s
   ```

3. **Discourse 설정**:
   - 활성화: `enable local logins: false` (선택사항)
   - 활성화: `login required: false` (선택사항)

#### 2. 플러그인 개발

```bash
# 저장소 클론
git clone https://github.com/scriptonbasestar/sb-discourse-naver.git

# 의존성 설치
bundle install

# 테스트 실행
bundle exec rspec
```

## 🛠️ Troubleshooting / 문제 해결

### English

#### Common Issues

**1. "Redirect URI Mismatch" Error**
- **Cause**: Mismatch between Discourse callback URL and Naver settings
- **Solution**: Ensure callback URL in Naver console matches exactly: `https://yourdomain.com/auth/naver/callback`
- **Check**: No trailing slash, correct protocol (http vs https)

**2. "Invalid Client" Error**
- **Cause**: Incorrect Client ID or Client Secret
- **Solution**: Verify keys from Naver Developer console and check for extra spaces
- **Tip**: Copy-paste directly from Naver console to avoid typos

**3. "Service State" Error**
- **Cause**: Naver application service status not approved
- **Solution**: Check application status in Naver console - should be "서비스 적용" or "개발중"
- **Note**: Development status is sufficient for testing

**4. Email Not Retrieved**
- **Cause**: Email permission not granted in Naver app
- **Solution**: Ensure "이메일 주소" is checked in "제공 정보" section
- **Note**: Naver provides email by default if permission is granted

**5. SSL/HTTPS Required**
- **Cause**: Naver OAuth requires HTTPS in production
- **Solution**: Enable SSL certificate on your domain
- **Development**: Use `http://localhost` which is exempted

#### Debug Mode

Enable detailed logging:

```ruby
# In Rails console
Rails.logger.level = Logger::DEBUG
```

Check Discourse logs:
```bash
tail -f /var/discourse/shared/standalone/log/rails/production.log | grep -i naver
```

### 한국어

#### 일반적인 문제들

**1. "Redirect URI Mismatch" 오류**
- **원인**: Discourse 콜백 URL과 네이버 설정 불일치
- **해결**: 네이버 콘솔의 Callback URL이 정확히 일치하는지 확인: `https://yourdomain.com/auth/naver/callback`
- **확인**: 끝에 슬래시 없음, 올바른 프로토콜 (http vs https)

**2. "Invalid Client" 오류**
- **원인**: 잘못된 Client ID 또는 Client Secret
- **해결**: 네이버 개발자 콘솔에서 키 확인 및 공백 문자 제거
- **팁**: 오타 방지를 위해 네이버 콘솔에서 직접 복사-붙여넣기

**3. "Service State" 오류**
- **원인**: 네이버 애플리케이션 서비스 상태가 승인되지 않음
- **해결**: 네이버 콘솔에서 애플리케이션 상태 확인 - "서비스 적용" 또는 "개발중"이어야 함
- **참고**: 테스트용으로는 "개발중" 상태로도 충분

**4. 이메일 정보 못 가져오는 경우**
- **원인**: 네이버 앱에서 이메일 권한이 부여되지 않음
- **해결**: "제공 정보" 섹션에서 "이메일 주소"가 체크되어 있는지 확인
- **참고**: 권한이 부여되면 네이버가 기본적으로 이메일 제공

**5. SSL/HTTPS 필요**
- **원인**: 네이버 OAuth는 프로덕션에서 HTTPS 필수
- **해결**: 도메인에 SSL 인증서 활성화
- **개발**: `http://localhost`는 예외 허용됨

#### 디버그 모드

상세 로깅 활성화:

```ruby
# Rails 콘솔에서
Rails.logger.level = Logger::DEBUG
```

Discourse 로그 확인:
```bash
tail -f /var/discourse/shared/standalone/log/rails/production.log | grep -i naver
```

## 📚 OAuth Scopes Reference / OAuth 스코프 참조

### English

Naver automatically provides profile information without explicit scope configuration.

| Information | Provided | Notes |
|-------------|----------|-------|
| **Nickname** | ✅ Always | Used as username in Discourse |
| **Email** | ✅ Always | If permission granted in Naver app |
| **Profile Image** | ✅ Always | Synced as avatar |
| **Gender** | ⬜ Optional | Not used by plugin |
| **Birthday** | ⬜ Optional | Not used by plugin |

**Note**: Unlike Kakao, Naver does not require explicit scope parameters. All information is controlled via "제공 정보" settings in Naver Developer console.

### 한국어

네이버는 명시적인 스코프 설정 없이 프로필 정보를 자동으로 제공합니다.

| 정보 | 제공 여부 | 비고 |
|------|----------|------|
| **닉네임** | ✅ 항상 | Discourse 사용자명으로 사용 |
| **이메일** | ✅ 항상 | 네이버 앱에서 권한 부여 시 |
| **프로필 사진** | ✅ 항상 | 아바타로 동기화 |
| **성별** | ⬜ 선택 | 플러그인에서 미사용 |
| **생일** | ⬜ 선택 | 플러그인에서 미사용 |

**참고**: 카카오와 달리 네이버는 명시적인 스코프 파라미터가 필요하지 않습니다. 모든 정보는 네이버 개발자 콘솔의 "제공 정보" 설정으로 제어됩니다.

## 🤝 Contributing / 기여하기

### English

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

Quick start:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat(scope): add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### 한국어

기여를 환영합니다! 가이드라인은 [CONTRIBUTING.md](CONTRIBUTING.md)를 참조하세요.

빠른 시작:
1. 저장소 포크
2. 기능 브랜치 생성 (`git checkout -b feature/amazing-feature`)
3. 변경사항 커밋 (`git commit -m 'feat(scope): add amazing feature'`)
4. 브랜치에 푸시 (`git push origin feature/amazing-feature`)
5. Pull Request 생성

## 📝 Changelog / 변경 이력

See [CHANGELOG.md](CHANGELOG.md) for version history and release notes.

버전 히스토리 및 릴리스 노트는 [CHANGELOG.md](CHANGELOG.md)를 참조하세요.

## 📄 License / 라이선스

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

이 프로젝트는 MIT 라이선스 하에 배포됩니다 - 자세한 내용은 [LICENSE](LICENSE) 파일을 확인하세요.

## 🔗 Links / 관련 링크

### English
- [Naver Developers](https://developers.naver.com/)
- [Naver Login API Documentation](https://developers.naver.com/docs/login/api/)
- [Discourse Meta](https://meta.discourse.org/)

### 한국어
- [네이버 개발자센터](https://developers.naver.com/)
- [네이버 로그인 API 문서](https://developers.naver.com/docs/login/api/)
- [Discourse 메타](https://meta.discourse.org/)

## 📊 Support / 지원

### English
- **Discourse Versions**: 3.1.999 - 3.5.0+
- **Ruby Versions**: 3.0+
- **Naver API**: OAuth 2.0

### 한국어
- **Discourse 버전**: 3.1.999 - 3.5.0+
- **Ruby 버전**: 3.0+
- **네이버 API**: OAuth 2.0

## 🙋 Questions & Issues / 질문 및 이슈

- **Bug Reports**: [GitHub Issues](https://github.com/scriptonbasestar/sb-discourse-naver/issues)
- **Feature Requests**: [GitHub Issues](https://github.com/scriptonbasestar/sb-discourse-naver/issues)
- **General Questions**: [Discourse Meta](https://meta.discourse.org/)

---

**Made with ❤️ for the Korean Discourse community**
**한국 Discourse 커뮤니티를 위해 ❤️ 으로 제작**
