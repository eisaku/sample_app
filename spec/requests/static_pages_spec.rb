require 'spec_helper'

# テスト対象：StaticPages
describe "StaticPages" do

  subject { page }

  # テストコードの共通化 RSpecの機能
  shared_examples_for "all static pages" do
    it { should have_content(heading)  }
    it { should have_title(full_title(page_title))}
  end

  # Homeページ内容
  describe "Home Page" do
    before { visit root_path }

    let(:heading)    {'Sample App'} 
    let(:page_title) {''} 

    it_should_behave_like "all static pages"
    it { should_not have_title("| Home")    }
 end

  # helpページ内容
  describe "Help Page" do
    before { visit help_path }

    let(:heading)    {'Help'} 
    let(:page_title) {'Help'} 

    it_should_behave_like "all static pages"
 end

  # about ページ内容
  describe "About Page" do
    before { visit about_path }

    let(:heading)    {'About Us'} 
    let(:page_title) {'About'} 

    it_should_behave_like "all static pages"
  end

  # contact ページ内容
  describe "Contact Page" do
    before { visit contact_path }

    let(:heading)    {'Contact'} 
    let(:page_title) {'Contact'} 

    it_should_behave_like "all static pages"
  end

  # リンクをテスト
  it "should have the right links on the layout" do
    visit root_path

    click_link "About"
    expect(page).to have_title(full_title('About'))

    click_link "Help"
    expect(page).to have_title(full_title('Help'))

    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))

    click_link "Home"
    expect(page).to have_title(full_title(''))

    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))

    click_link "sample app"
    expect(page).to have_title(full_title(''))
  end 
end
