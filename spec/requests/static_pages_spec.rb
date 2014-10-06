require 'rails_helper'

# RSpec.describe "StaticPages", :type => :request do
  # describe "GET /static_pages" do
    # it "works! (now write some real specs)" do
      # get static_pages_index_path
      # expect(response).to have_http_status(200)
    # end
  # end
# end


describe "Static pages" do

  # Homeページに対するテスト
  describe "Home page" do

    # /static_pages/homeにアクセスしたときに
    # Sample Appという語が含まれていること
    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end

    # 正しいタイトルになっていること
    it "should have the right title" do
      visit '/static_pages/home'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Home")
      # これもマッチする
      # expect(page).to have_title("Home")
    end

  end


  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
    end

  end


  describe "About page" do

    it "should have the content 'About Us'" do 
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | About Us")
    end

  end

end
