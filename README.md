# ExChange

This is ExChange, an API to convert amounts between currencies.

ExChange uses [ExchangeRate API](https://www.exchangerate-api.com/) to convert currencies. More specifically it is a wrapper to the [pair conversion endpoint](https://www.exchangerate-api.com/docs/pair-conversion-requests)

Before starting your server, go to [ExchangeRate API](https://www.exchangerate-api.com/) and generate a free API key

To start your `ExChange` server:
  * Install dependencies with `mix deps.get`
  * Set the ExchangeRate API key and url in your environment:
  ```bash
  export CURRENCY_CONVERTER_URL=https://v6.exchangerate-api.com/v6/ 
  export CURRENCY_CONVERTER_API_KEY=<your_api_key>
  ```
  * Start ExChange endpoint with `mix phx.server`

Now you can visit [`localhost:4000/api/convert/100/USD/EUR`](http://localhost:4000/api/convert/100/USD/EUR) from your browser to convert 100 USD to EUR.

Limitations: 
- [Here](https://www.exchangerate-api.com/docs/supported-currencies) is a list of supported currency codes;
- The free API key updates the exchange rate every 24h;
- The API does **not** support negative amounts on the url;

## OpenAPI
The api is documented using openAPI v3.0.

You can use the [openapi.yml file](https://github.com/Gabee01/ExChange/blob/main/openapi.yml) to:

### Generate a Postman collection
1. Click in Import
2. Postman allows you to import both via
- Uploading a downloaded version of the openapi.yaml file
- Via link, using [the raw file link](https://raw.githubusercontent.com/Gabee01/ExChange/main/openapi.yml)

### Swagger
You can also use the openapi file on [swagger editor](https://editor.swagger.io/) to preview the documentation.