require 'rails_helper'
require 'spec_helper'
include ApplicationHelper

# RSpec.describe "StaticPages", :type => :request do
  # describe "GET /static_pages" do
    # it "works! (now write some real specs)" do
      # get static_pages_index_path
      # expect(response).to have_http_status(200)
    # end
  # end
# end


describe "Static pages" do

  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  subject { page }

  # Homeページに対するテスト
  describe "Home page" do

    before { visit root_path }

    # /static_pages/homeにアクセスしたときに
    # Sample Appという語が含まれていること
    it { should have_content('Sample App') }
    # it "should have the content 'Sample App'" do
      # # visit '/static_pages/home'
      # # visit root_path
      # expect(page).to have_content('Sample App')
    # end

    # 正しいタイトルになっていること
    # it "should have the right title" do
      # visit '/static_pages/home'
      # expect(page).to have_title("#{base_title} | Home")
      # # これもマッチする
      # # expect(page).to have_title("Home")
    # end

    it { should have_title(full_title('')) }
    # it "should have the base title" do
      # # visit '/static_pages/home'
      # # visit root_path
      # expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    # end

    it { should_not have_title('| Home') }
    # it "should not have a custom page title" do
      # # visit '/static_pages/home'
      # # visit root_path
      # expect(page).not_to have_title('| Home')
    # end

  end


  describe "Help page" do

    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }

    # it "should have the content 'Help'" do
      # # visit '/static_pages/help'
      # visit help_path
      # expect(page).to have_content('Help')
    # end

    # it "should have the title 'Help'" do
      # # visit '/static_pages/help'
      # visit help_path
      # expect(page).to have_title("#{base_title} | Help")
    # end

  end


  describe "About page" do

    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }

    # it "should have the content 'About Us'" do 
      # # visit '/static_pages/about'
      # visit about_path
      # expect(page).to have_content('About Us')
    # end

    # it "should have the title 'About Us'" do
      # # visit '/static_pages/about'
      # visit about_path
      # expect(page).to have_title("#{base_title} | About Us")
    # end

  end


  describe "Contact page" do


    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }

    # it "should have the content 'Contact'" do
      # # visit '/static_pages/contact'
      # visit contact_path
      # expect(page).to have_content('Contact')
    # end

    # it "should have the title 'Contact'" do
      # # visit '/static_pages/contact'
      # visit contact_path
      # expect(page).to have_title("#{base_title} | Contact")
    # end
  end

end
