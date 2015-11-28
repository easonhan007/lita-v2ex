require "lita"

Lita.load_locales Dir[File.expand_path(
  File.join("..", "..", "locales", "*.yml"), __FILE__
)]

require "lita/handlers/v2ex"

Lita::Handlers::V2ex.template_root File.expand_path(
  File.join("..", "..", "templates"),
 __FILE__
)
