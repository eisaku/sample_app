require 'spec_helper'

describe User do

  before do
    @user = User.new( name: "Example User", 
                      email: "user@example.com",
                      password: "foobar",
                      password_confirmation: "foobar")
  end

  subject{ @user }

 # name属性とemail属性の存在をテスト
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }		# Is authoenticate method ?

 # normality confirmation of  @user.valid?
  it { should be_valid } 

 # presence
  describe "when name is not present" do
    before { @user.name = "" }

    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "" }

    it { should_not be_valid }
  end
 
 # length
  describe "when name is too long" do
    before { @user.name = "a"*51 }

    it { should_not be_valid }
  end

 # formats
  describe "when email formats is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com
                     user_at_foo.org
                     example.user@foo.
                     foo@bar_baz.com
                     foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email formats is valid" do
    it "should be valid" do
      addresses = %w[user@foo.com
                     A_US-ER@f.b.org
                     frst.lst@foo.jp
                     a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is alredy taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid } 
  end

  describe "when email address is alredy taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid } 
  end

 # password check
  describe "when password is not present" do
    before do
      @user.password = ""
      @user.password_confirmation =  ""
    end
=begin
    before do
      @user = User.new(name: "Example User", email: "user@example",
                       password: "", password_confirmation: "")
    end
=end

    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }

    it { should_not be_valid }
  end
 
  describe "return value of authenticate " do
    # 事前に登録
    before { @user.save }

    # メモ化(memoize)
    # 以降はfound_userを使うのでDBへアクセスしない
    let(:found_user) { User.find_by(email: @user.email) }
    
    # match
    describe "with valid passward" do
      it { should eq found_user.authenticate(@user.password) }  # パスワードがマッチした時は found_user が返される
    end

    # nomatch
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }# パスワードがマッチした時は false が返される 

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }	    # it = specify
    end
  end
  
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a"*5 }

    it { should be_invalid }   # invalid?
  end

end
