require 'spec_helper'

# TODO: Remove this?  There is nothing left that is editable.
describe Spree::Admin::AmazonController do
  let(:user) { create(:user) }

  before do
    allow(controller).to receive_messages :spree_current_user => user
    user.spree_roles << Spree::Role.find_or_create_by(name: 'admin')
  end

  describe 'PUT #update' do

    it "sets a flash message" do
      settings = {}

      spree_put :update, settings

      expect(flash[:success]).to eq("Amazon Settings has been successfully updated!")
    end
  end
end
