require 'spec_helper'

describe HomeController do
  it "successfully loads index with status 200" do
    get :index
    expect(response).to be_success
    expect(response.status).to eq(200)
  end

  it "renders the home/index template" do
    get :index
    expect(response).to render_template("index")
  end
end
