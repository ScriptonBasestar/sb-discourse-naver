# 네이버 로그인 플러그인 / Login with Naver Plugin

네이버 계정을 통한 인증을 가능하게 하는 Discourse 플러그인입니다.

A Discourse plugin that enables authentication via Naver account.

## 설치 방법 / Installation

### 1. 플러그인 설치

Discourse 컨테이너의 `app.yml` 파일에 다음 플러그인을 추가하세요:

```yaml
hooks:
  after_code:
    - exec:
        cd: $home/plugins
        cmd:
          - sudo -E -u discourse git clone https://github.com/scriptonbasestar/sb-discourse-naver.git
```

### 2. 컨테이너 재빌드

```bash
cd /var/discourse
./launcher rebuild app
```

## 네이버 개발자 센터 설정 / Naver Developer Center Setup

### 1. 네이버 개발자 센터 계정 생성
- [네이버 개발자 센터](https://developers.naver.com/) 접속
- 네이버 계정으로 로그인
- 새 애플리케이션 등록

### 2. 애플리케이션 설정
- **애플리케이션 이름**: Discourse 사이트 이름
- **사용 API**: 네이버 로그인
- **제공 정보**: 이메일 주소, 프로필 정보 등 필요한 정보 선택
- **서비스 URL**: `https://your-discourse-site.com`
- **Callback URL**: `https://your-discourse-site.com/auth/naver/callback`

## Discourse 관리자 설정 / Discourse Admin Settings

관리자 패널에서 다음 설정을 구성하세요:

### 필수 설정
- `enable_login_with_naver`: `true`로 설정
- `login_with_naver_client_id`: 네이버 개발자 센터에서 발급받은 Client ID
- `login_with_naver_client_secret`: 네이버 개발자 센터에서 발급받은 Client Secret

### 선택 설정
- `login_with_naver_scope`: 요청할 스코프 (기본값: 비어있음)
- `login_with_naver_redirect_url`: 사용자 정의 리다이렉트 URL
- `login_with_naver_redirect_path`: 리다이렉트 경로 (기본값: `/auth/naver/callback`)
- `login_with_naver_overrides_email`: 네이버 이메일로 사용자 이메일 덮어쓰기
- `login_with_naver_email_verified`: 네이버 이메일을 검증됨으로 처리

## 개발 환경 설정 / Development Setup

### 로컬 개발을 위한 설정

1. **네이버 개발자 센터 설정**:
   - 서비스 URL: `http://localhost:4200`
   - Callback URL: `http://localhost:4200/auth/naver/callback`

2. **Discourse 설정**:
   ```bash
   # 환경 변수 설정하여 서버 실행
   REDIRECT_URL_ORIGIN=http://localhost:4200 rails s
   ```

3. **선택적 설정**:
   - `enable_local_logins: false` (네이버 로그인만 사용)
   - `login_required: false` (로그인 없이 접근 가능)

## 지원 버전 / Supported Versions

- Discourse 3.1.x 이상
- Ruby 3.0 이상

## 라이선스 / License

MIT License

## 문제 해결 / Troubleshooting

### 일반적인 문제

1. **로그인 버튼이 표시되지 않음**
   - `enable_login_with_naver` 설정이 활성화되었는지 확인
   - 플러그인이 올바르게 설치되었는지 확인

2. **인증 실패**
   - Client ID와 Client Secret이 올바른지 확인
   - Callback URL이 정확히 설정되었는지 확인
   - 네이버 개발자 센터에서 서비스 상태가 활성화되었는지 확인

3. **이메일 문제**
   - 네이버 계정에 이메일이 등록되어 있는지 확인
   - `login_with_naver_email_verified` 설정 확인

### 로그 확인

Discourse 로그에서 다음 키워드로 검색:
- `naver`
- `oauth`
- `authentication`

## 기여 / Contributing

버그 리포트나 기능 요청은 GitHub Issues에 제출해주세요.

## 참고 자료 / References

- [네이버 로그인 API 문서](https://developers.naver.com/docs/login/api/)
- [Discourse 플러그인 개발 가이드](https://meta.discourse.org/t/beginners-guide-to-creating-discourse-plugins/30515)



