require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "notify_comment" do
    let(:mail) { UserMailer.notify_comment }

    it "renders the headers" do
      expect(mail.subject).to eq("Notify comment")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
