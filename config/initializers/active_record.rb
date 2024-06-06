Rails.application.config.after_initialize do
  ActiveRecord.yaml_column_permitted_classes += [
    CardGame::Card, 
    CardGame::Deck, 
    CardGame::Row
  ]
end