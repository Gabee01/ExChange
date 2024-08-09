# ExChange

## Project Description

ExChange is a robust API designed for converting amounts between various currencies. Built with Elixir and Phoenix, it serves as a powerful wrapper for the ExchangeRate API, specifically utilizing their pair conversion endpoint. This project demonstrates the implementation of a microservice architecture, showcasing how to integrate external APIs and build a scalable, performant currency conversion service.

## Technologies Used

- **Elixir**: A dynamic, functional language designed for building scalable and maintainable applications.
- **Phoenix Framework**: A productive web framework that does not compromise speed or maintainability.
- **ExchangeRate API**: External service used for up-to-date currency conversion rates.
- **OpenAPI 3.0**: Used for API documentation, ensuring clear communication of endpoints and usage.
- **Mix**: Elixir's build tool, used for project management, dependency handling, and task automation.

## Project Structure

The ExChange project follows a standard Elixir/Phoenix application structure:

```
ExChange/
├── config/                 # Configuration files
├── lib/
│   ├── ex_change/          # Core application logic
│   └── ex_change_web/      # Web-related code (controllers, views, router)
├── test/                   # Test files
├── .formatter.exs          # Elixir code formatter configuration
├── .gitignore
├── mix.exs                 # Project configuration and dependencies
├── mix.lock               
├── openapi.yml             # API documentation
└── README.md               # This file
```

Key files:
- `lib/ex_change_web/controllers/converter_controller.ex`: Handles the conversion requests
- `lib/ex_change/conversion_info.ex`: Contains the core conversion logic
- `openapi.yml`: Comprehensive API documentation

## Setup and Running

To set up and run your ExChange server:

1. Clone the repository:
   ```bash
   git clone https://github.com/YourUsername/ExChange.git
   cd ExChange
   ```

2. Go to [ExchangeRate API](https://www.exchangerate-api.com/) and generate a free API key.

3. Set the ExchangeRate API key and URL in your environment:
   ```bash
   export CURRENCY_CONVERTER_URL=https://v6.exchangerate-api.com/v6/ 
   export CURRENCY_CONVERTER_API_KEY=<your_api_key>
   ```

4. Install dependencies:
   ```bash
   mix deps.get
   ```

5. Start the ExChange endpoint:
   ```bash
   mix phx.server
   ```

Your server should now be running. You can test it by visiting [`localhost:4000/api/convert/100/USD/EUR`](http://localhost:4000/api/convert/100/USD/EUR) in your browser to convert 100 USD to EUR.

## API Usage

The main endpoint for currency conversion is:

```
GET /api/convert/{amount}/{from_currency}/{to_currency}
```

Example: `http://localhost:4000/api/convert/100/USD/EUR`

This will convert 100 USD to EUR based on the latest exchange rates.

## Limitations

- Supported currency codes are limited to those provided by the ExchangeRate API. See the [list of supported currencies](https://www.exchangerate-api.com/docs/supported-currencies).
- With the free API key, exchange rates are updated every 24 hours.
- The API does not support negative amounts in the URL.

## OpenAPI Documentation

The API is documented using OpenAPI v3.0. You can use the [openapi.yml file](https://github.com/Gabee01/ExChange/blob/main/openapi.yml) to:

### Generate a Postman collection

1. In Postman, click on "Import"
2. You can import either by:
   - Uploading the downloaded openapi.yaml file
   - Using the [raw file link](https://raw.githubusercontent.com/Gabee01/ExChange/main/openapi.yml)

### View in Swagger UI

You can also use the openapi file on [Swagger Editor](https://editor.swagger.io/) to preview the documentation and interact with the API.

## Interesting Challenges and Learnings

1. **Elixir and Functional Programming**: This project showcases the power of Elixir's functional programming paradigm in building concurrent and fault-tolerant systems.

2. **Phoenix Framework**: Demonstrates how to leverage Phoenix for building high-performance web applications and APIs.

3. **External API Integration**: Illustrates best practices for integrating and working with external APIs, including error handling and rate limiting.

4. **API Documentation**: Shows how to use OpenAPI for clear and interactive API documentation, enhancing developer experience.

5. **Testing in Elixir**: The test suite demonstrates comprehensive testing practices in Elixir, including controller and view tests.

6. **Environment Configuration**: Exemplifies how to manage environment-specific configurations and sensitive data (like API keys) securely.

This project serves as an excellent example of building a microservice in Elixir, demonstrating how to create a clean, well-structured, and documented API that integrates external services.
