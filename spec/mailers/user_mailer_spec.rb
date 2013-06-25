require "spec_helper"

describe UserMailer do
  describe "micropost_notification" do
    let(:mail) { UserMailer.micropost_notification }

    it "renders the headers" do
      mail.subject.should eq("Micropost notification")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
