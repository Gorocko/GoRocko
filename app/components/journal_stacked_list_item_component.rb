# frozen_string_literal: true

class JournalStackedListItemComponent < ViewComponent::Base
  include TimeDisplayHelper
  include ApplicationHelper
  def initialize(journal:)
    @journal = journal
  end
end
