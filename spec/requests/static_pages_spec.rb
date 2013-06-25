require 'spec_helper'

describe "Static Pages" do

  let(:base_title) {"Ruby on Rails Tutorial Sample App"}

  subject { page }

  describe "Home page" do
    before { visit root_path }
  
    it { should have_selector('h1', text: 'Sample App') }

    it { should have_selector('title', text: "Ruby on Rails Tutorial Sample App") }

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

  describe "Help Page" do
    before {visit help_path}

    it {should have_selector('h1', text: 'Help')}

    it {should have_selector('title', text:  "Ruby on Rails Tutorial Sample App | Help")}

  end

  describe "About Page" do
    before {visit about_path}
    it {should have_selector('h1', text: 'About Us')}
    
    it {should have_selector('title', text: "Ruby on Rails Tutorial Sample App | About Us")}

  end

  describe "Contact Page" do
    before {visit contact_path}

    it {should have_selector('h1', text: 'Contact')}
    
    it {should have_selector('title', text:  "Ruby on Rails Tutorial Sample App | Contact")}
  end

end
