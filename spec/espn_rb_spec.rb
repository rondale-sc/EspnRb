require 'spec_helper'

describe EspnRb::Headline do
  it "#all_headlines should return 200 response." do
    described_class.all_headlines.code.should eq("200")
  end
end