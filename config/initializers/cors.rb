Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Permite únicamente el origen de GitHub Pages y el entorno local
    origins "https://tcoz2233.github.io", "http://localhost:8000", "http://127.0.0.1:8000"

    resource "/api/v1/services*",
      headers: :any,
      methods: [:get, :options]
  end
end