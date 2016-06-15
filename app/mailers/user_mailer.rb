class UserMailer < ActionMailer::Base
    default :from => "我的記分板 <myscoreboard@gmail.com>"

  def password_reset(user, token)
    @resource = user
    @token = token
    mail(:to => user.email,
         :subject => '您在我的記分板要求重新設定密碼')
  end

  def send_simple_message
    RestClient.post "https://api:key-96fe84b72a97eaa5d821d6a663a36b8a"\
    "@api.mailgun.net/v3/sandbox83acab4e588d43c1a0dead5ec37c4e9c.mailgun.org/messages",
    :from => "Mailgun Sandbox <postmaster@sandbox83acab4e588d43c1a0dead5ec37c4e9c.mailgun.org>",
    :to => "myscoreboard <myscoreboardapp@gmail.com>",
    :subject => "Hello myscoreboard",
    :text => "Congratulations myscoreboard, you just sent an email with Mailgun!  You are truly awesome!  You can see a record of this email in your logs: https://mailgun.com/cp/log .  You can send up to 300 emails/day from this sandbox server.  Next, you should add your own domain so you can send 10,000 emails/month for free."
  end

end
