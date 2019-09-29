otp() {
  declare -a otp
  otp[posteo]='internet/dienstleister/posteo'
  oathtool -b --totp $(pass show ${otp[$1]} | grep OTP | cut -d' ' -f2)
}
