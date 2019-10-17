otp() {
  declare -a otp
  otp[posteo]='internet/dienstleister/posteo'
  otp[giz]='giz/giz.de'
  oathtool -b --totp $(pass show ${otp[$1]} | grep OTP | cut -d' ' -f2)
}
