# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
# Uncomment the following to create an Admin user for Production in Jumpstart Pro
# User.create name: "name", email: "email", password: "password", password_confirmation: "password", admin: true, terms_of_service: true

# frozen_string_literal: true

stud_group = Group.create!(
  name: "Stud"
)

bitch_group = Group.create!(
  name: "Bitch"
)

litter_group_1 = Group.create!(
  name: "litter"
)

dog_1 = Dog.create!(
  name: "cute number 1",
  group_id: stud_group.id
)

Dog.create!(
  name: "cute number 2",
  group_id: bitch_group.id
)

Dog.create!(
  name: "cute number 3",
  group_id: litter_group_1.id
)

Journal.create!(
  notes: "this is test notes",
  loggable: dog_1
)

action_event = ActionEvent.create!(
  title: "my first action event",
  description: "description text",
  due_date: Time.zone.local(2022, 2, 3, 4, 5, 6),
  status: 1
)

ActionEventRecord.create!(
  status: 1,
  eventable: dog_1,
  action_event_id: action_event.id,
  due_date: Time.zone.local(2022, 2, 3, 4, 5, 6)
)
