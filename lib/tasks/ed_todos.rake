# Namespace for education todos.
require 'securerandom'

namespace :ed_todos do
  desc 'Add educational todos to the database'
  task seed: :environment do
    [
      'Learn how migrations work',
      'Learn how i18n / l10n works',
      'Learn how Unit Tests work',
      'Learn how Integration Tests work',
      'Learn about framework\'s preferred ORM / DB Interaction',
      'Learn how to do CRUD operatoins / APIs',
      'Learn how validations work',
      'Learn how background tasks work',
      'Does this framework support layout swapping?'
    ].each do |t|
      Todo.create!(
        message_id: SecureRandom.uuid,
        username: 'exegete46',
        message: t,
        channel: 'exegete46'
      )
    end
  end
end
