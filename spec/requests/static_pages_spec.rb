require 'spec_helper'

describe "Static Pages" do

  let(:base_title) {"Ruby on Rails Tutorial Sample App"}

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
    end

    describe "follower/following counts" do
      let(:other_user) { FactoryGirl.create(:user)}
      before do
        other_user.follow!(user)
        visit root_path
      end
      it { should have_link("0 following", href: following_user_path(user))}
      it { should have_link("1 followers", href: followeres_user_path(user))}
    end

  end

end
