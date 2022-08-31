# frozen_string_literal: true

# == Schema Information
#
# Table name: event_templates
#
#  id                           :bigint           not null, primary key
#  days_delta_from_last         :integer
#  description                  :string
#  is_head                      :boolean          default(FALSE), not null
#  title                        :string
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  event_template_collection_id :bigint           default(0), not null
#  last_event_template_id       :bigint
#
# Indexes
#
#  index_event_templates_on_event_template_collection_id  (event_template_collection_id)
#  index_event_templates_on_last_event_template_id        (last_event_template_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_template_collection_id => event_template_collections.id)
#  fk_rails_...  (last_event_template_id => event_templates.id)
#
class EventTemplate < ApplicationRecord
  belongs_to :last_event_template, class_name: "EventTemplate", optional: true
  belongs_to :event_template_collection
  has_one :next_event_template, class_name: "EventTemplate", foreign_key: "last_event_template", dependent: :nullify,
    inverse_of: :last_event_template
end
