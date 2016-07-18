class SpreeAmazon::Configuration < Spree::Preferences::Configuration
  class_attribute :payment_method
  self.payment_method = ->(currency) {
    Spree::Gateway::Amazon.first
  }

  def use_static_preferences!
    raise "SpreeAmazon::Configuration cannot use static preferences"
  end
end
