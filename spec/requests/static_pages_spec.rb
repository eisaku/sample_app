require 'spec_helper'

# テスト対象：StaticPages
describe "StaticPages" do

  subject { page }

  # Homeページ内容
  describe "Home Page" do
    before { visit root_path }

    it { should have_content('Sample App')  }
    it { should have_title(full_title('')) }
    it { should_not have_title("| Home")    }
 end

  # helpページ内容
  describe "Help Page" do
    before { visit help_path }

    it { should have_content('Help')  }
    it { should have_title(full_title('Help')) }
 end

  # about ページ内容
  describe "About Page" do
    before { visit about_path }

    it { should have_content('About Us')  }
    it { should have_title(full_title('About')) }
  end

  # contact ページ内容
  describe "Contact Page" do
    before { visit contact_path }

    it { should have_content('Contact')  }
    it { should have_title(full_title('Contact')) }
  end
end
