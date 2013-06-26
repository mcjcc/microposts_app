require 'spec_helper'

def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

describe "Static Pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }
  
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

    describe "follower/following counts" do
      let(:other_user) { FactoryGirl.create(:user)}
      before do
        other_user.follow!(user)
        visit root_path
      end

      it { should have_link("0 following", href: following_user_path(user))}
      it { should have_link("1 followers", href: followers_user_path(user))}
    end
  end
end
end
