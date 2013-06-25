require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    let(:submit) { "Create my account"}

    describe "with invalid info" do 
      it "should not create a user" do
        expect {click_button submit}.not_to change(User, :count)
      end
    end

    describe "with valid info" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "should create a user" do
        expect {click_button submit}.to change(User, :count).by(1)
      end
  
    end


    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text:  "Ruby on Rails Tutorial Sample App | Sign up") }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user:user, content: "Foo")}
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar")}
    before {visit user_path(user)}

    it { should have_selector('h1', text: user.name)}
    it { should have_selector('title', text: user.name)}

    describe "microposts" do
      it { should have_content(m1.content)}
      it { should have_content(m2.content)}
      it { should have_content(user.microposts.count)}

  end
end