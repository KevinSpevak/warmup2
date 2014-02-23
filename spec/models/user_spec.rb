require 'spec_helper'

describe User do
  it "adds new user" do
    expect(User.addUser('Jimmy', '123')).to eq(true)
    account = User.find_by_user_and_password_and_count("Jimmy", '123', 1)
    expect(account).to be_truthy
  end
end

describe User do
  it "requires new user to have unique username" do
    User.addUser('Jimmy', '123')
    expect(User.addUser('Jimmy', '123')).to be false
  end
end

describe User do
  it "allows an existing user to log in" do
    User.addUser('Jimmy', '123')
    expect(User.login('Jimmy', '123')).to eq(1)
  end
end

describe User do
  it "incriments the login counter" do
    User.addUser('Jimmy', '123')
    expect(User.find_by_user('Jimmy').count).to eq(1)
    User.login('Jimmy', '123')
    expect(User.find_by_user('Jimmy').count).to eq(2)
  end
end

describe User do
  it "rejects bad credentials" do
    expect(User.login('Jimmy', '123')).to eq(-1)
  end
end

describe User do
  it "correctly checks credential format" do
    max_len_str = "1" * 128
    expect(User.check_cred_format("", "")).to eq(-3)
    expect(User.check_cred_format("Jimmy", "")).to eq(1)
    expect(User.check_cred_format(max_len_str, "")).to eq(1)
    expect(User.check_cred_format(max_len_str + "1", "")).to eq(-3)
    expect(User.check_cred_format("1", max_len_str + "1")).to eq(-4)
  end
end


