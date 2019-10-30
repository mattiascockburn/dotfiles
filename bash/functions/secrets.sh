otp() {
  declare -a otp
  otp[posteo]='internet/dienstleister/posteo'
  otp[giz]='giz/giz.de'
  otp[b1git]='b1/gitlab'
  oathtool -b --totp $(pass show ${otp[$1]} | grep OTP | cut -d' ' -f2)
}
