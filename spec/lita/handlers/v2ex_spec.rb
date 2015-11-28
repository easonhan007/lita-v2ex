require "spec_helper"

describe Lita::Handlers::V2ex, lita_handler: true do
  it {is_expected.to route_command("v2ex").to(:fetch_hot_topic)}

  it 'should get content form v2ex' do
    send_command('v2ex')
    expect(replies.last).to include('v2ex.com')
  end

end
