# ExChange

This is ExChange, an API to convert values between currencies.

ExChange uses [ExchangeRate API](https://www.exchangerate-api.com/) to get the current conversion rate. More specifically it is a wrapper to the [pair conversion endpoint](https://www.exchangerate-api.com/docs/pair-conversion-requests)

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
- [Here](https://www.exchangerate-api.com/docs/supported-currencies) is a list of supported currency codes
- The API does **not** support negative values on the url.