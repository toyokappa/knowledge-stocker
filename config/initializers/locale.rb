# 翻訳文の置き場所を指定
Rails.application.config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]

# デフォルトのロケールを設定する
Rails.application.config.i18n.default_locale = :ja
