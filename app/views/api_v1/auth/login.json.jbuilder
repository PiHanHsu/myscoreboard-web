json.auth_token @user.authentication_token
json.user_id @user.id
json.username @user.username
json.gender @user.gender
json.email @user.email
json.photo asset_url(@user.head.url)