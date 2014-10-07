require 'spec_helper'

# テスト対象：StaticPages
describe "StaticPages" do

  let(:base_title) { "Ruby on Rails Tutorial Sample App"}

  subject { page }

  # Homeページ内容
  describe "Home Page" do
    before { visit root_path }

    it { should have_content('Sample App')  }
    #it { should have_title("#{base_title}") }
    # spec/supprtが自動的に読みこまれたのでできた！
    it { should have_title(full_title('')) }
    it { should_not have_title("| Home")    }

=begin
    it "should have the content 'Sample App'" do
      expect(page).to have_content('Sample App')
    end

    it "should have the base title" do
      expect(page).to have_title("#{base_title}")
    end

    it "should have a custom title" do
      expect(page).not_to have_title("| Home")
    end
=end
 end

  # helpページ内容
  describe "Help Page" do
    before { visit help_path }

    it "should have the content 'Help'" do
      expect(page).to have_content('Help')
    end

    it "should have the right title" do
      expect(page).to have_title("#{base_title} | Help")
    end
 end

  # about ページ内容
  describe "About Page" do
    before { visit about_path }

    it "should have the content 'About Us'" do
      expect(page).to have_content('About Us')
    end 

    it "should have the right title" do
      expect(page).to have_title("#{base_title} | About")
    end
  end

  # contact ページ内容
  describe "Contact Page" do
    before { visit contact_path }

    it "should have the content 'Contact'" do
      expect(page).to have_content('Contact')
    end 

    it "should have the right title" do
      expect(page).to have_title("#{base_title} | Contact")
    end
  end

=begin
  # テスト対象：/static_pages
  describe "GET /static_pages" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get static_pages_index_path
      response.status.should be(200)
    end
  end
=end

  
end
