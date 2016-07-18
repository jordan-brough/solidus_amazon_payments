require 'spec_helper'

describe SpreeAmazon::Configuration do
  let(:configuration) { SpreeAmazon::Configuration.new }

  describe '#use_static_preferences!' do
    # TODO: Does this work?
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
    let!(:first_gateway) { create(:amazon_gateway) }
    let(:order) { create(:order) }

    context 'with the default selector' do
      it 'returns the first amazon gateway' do
        expect(
          configuration.payment_method.call(order.currency)
        ).to eq(first_gateway)
      end
    end

    context 'with a custom selector' do
      let!(:last_gateway) { create(:amazon_gateway) }

      before do
        configuration.payment_method = ->(currency) do
          expect(currency).to eq(order.currency)
          last_gateway
        end
      end

      it 'returns the last amazon gateway' do
        expect(
          configuration.payment_method.call(order.currency)
        ).to eq(last_gateway)
      end
    end
  end
end
