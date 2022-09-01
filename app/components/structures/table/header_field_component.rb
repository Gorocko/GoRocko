# frozen_string_literal: true

module Structures
  module Table
    class HeaderFieldComponent < ViewComponent::Base
      def initialize(title:)
        @title = title
      end
    end
  end
end
