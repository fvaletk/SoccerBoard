require 'rails_helper'

RSpec.describe User, :type => :model do
  it "is valid with a firstname, lastname, email and password(8)" do
    expect(create(:user)).to be_valid
  end

  it "is invalid without a firstname" do
    user = build(:user,first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without a lastname" do
    user = build(:user,last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without a email" do
    user = build(:user,email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a email" do
    user = build(:user,password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid with a password less than 8 characters" do
    user = build(:user,password: "1234567")
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
  end

  it "is invalid with a duplicate email address" do
    user = create(:user,email:"a@example.com")
    another_user = build(:user,email:"a@example.com")
    another_user.valid?
    expect(another_user.errors[:email]).to include("has already been taken")
  end  

end