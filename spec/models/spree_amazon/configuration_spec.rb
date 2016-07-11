require 'spec_helper'

describe SpreeAmazon::Configuration do
  let(:configuration) { SpreeAmazon::Configuration.new }

  describe '#use_static_preferences!' do
    # We cannot use_static_preferences since we allow users
    # to configure the settings through the admin UI, calling
    # use_static_preferences will reset all settings to their
    # default values and store them in memory
    it "raises an error" do
      expect {
        configuration.use_static_preferences!
      }.to raise_error("SpreeAmazon::Configuration cannot use static preferences")
    end
  end

  describe '#payment_method' do
    let(:gateway) { double }

    it 'returns the first spree amazon gateway' do
      expect(Spree::Gateway::Amazon).to receive(:first).and_return gateway
      expect(configuration.payment_method.call(Spree::Config.currency))
        .to eq(gateway)
    end
  end
end
