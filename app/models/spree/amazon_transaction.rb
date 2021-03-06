##
# Amazon Payments - Login and Pay for Spree Commerce
#
# @category    Amazon
# @package     Amazon_Payments
# @copyright   Copyright (c) 2014 Amazon.com
# @license     http://opensource.org/licenses/Apache-2.0  Apache License, Version 2.0
#
##
module Spree
  class AmazonTransaction < ActiveRecord::Base
    has_many :payments, :as => :source

    def name
      "Pay with Amazon"
    end

    def cc_type
      "n/a"
    end

    def display_number
      "n/a"
    end

    def month
      "n"
    end

    def year
      "a"
    end

    def reusable_sources(_order)
      []
    end

    def self.with_payment_profile
      []
    end

    def can_capture?(payment)
      (payment.pending? || payment.checkout?) && payment.amount > 0
    end

    def can_credit?(payment)
      payment.completed? && payment.credit_allowed > 0
    end

    def can_void?(payment)
      payment.pending?
    end

    def actions
      %w{capture credit void}
    end

  end
end
