# frozen_string_literal: true

class EventTemplateCollectionForm < YAAF::Form
  attr_accessor :title, :event_templates_attributes

  after_commit :link_event_templates

  def initialize(attributes, event_template_collection_model = nil)
    super(attributes)
    @event_template_collection = event_template_collection_model unless event_template_collection_model.nil?
    @models = [event_template_collection]
  end

  def event_template_collection
    @event_template_collection ||= EventTemplateCollection.new(
      title:,
      event_templates_attributes: sanitized_event_templates_attributes
    )
  end

  def sanitized_event_templates_attributes
    event_templates_attributes.values
  end

  def update
    @event_template_collection.update(title:,
                                      event_templates_attributes: sanitized_event_templates_attributes)
  end

  def link_event_templates
    event_templates = @event_template_collection.event_templates
    event_templates.each_with_index do |event_template, index|
      if index.zero?
        event_template.update(is_head: true)
      else
        event_template.update(last_event_template_id: event_templates[index - 1].id, is_head: false)
      end
    end
  end
end
