class SpreeAmazon::Address
  class << self
    def find(order_reference, gateway:)
      response = mws(order_reference, gateway: gateway).fetch_order_data
      from_response(response)
    end

    def from_response(response)
      if response.destination["PhysicalDestination"].blank?
        return nil
      end
      new attributes_from_response(response.destination["PhysicalDestination"])
    end

    private

    def mws(order_reference, gateway:)
      AmazonMws.new(order_reference, gateway: gateway)
    end

    def attributes_from_response(response)
      {
        address1: response["AddressLine1"],
        name: response["Name"],
        city: response["City"],
        zipcode: response["PostalCode"],
        state_name: response["StateOrRegion"],
        country_code: response["CountryCode"],
        phone: response["Phone"]
      }
    end
  end

  attr_accessor :name, :city, :zipcode, :state_name, :country_code,
                :address1, :phone

  def initialize(attributes)
    attributes.each_pair do |key, value|
      send("#{key}=", value)
    end
  end

  def first_name
    return nil if name.blank?
    name.split(" ").first
  end

  def last_name
    return nil if name.blank?
    names = name.split(" ")
    names.shift
    names.join(" ")
  end

  def country
    @country ||= Spree::Country.find_by(iso: country_code)
  end
end
