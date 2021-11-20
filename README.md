# ExChange

This is ExChange, an API to convert values between currencies.

ExChange uses [ExchangeRate API](https://www.exchangerate-api.com/) to get the current conversion rate. More specifically it uses the [pair conversion endpoint](https://www.exchangerate-api.com/docs/pair-conversion-requests)

To start your `ExChange` server:

  * Install dependencies with `mix deps.get`
  * Set the ExchangeRate API key and url in your environment:
  ```bash
  export CURRENCY_CONVERTER_URL=https://v6.exchangerate-api.com/v6/ 
  export CURRENCY_CONVERTER_API_KEY=<your_api_key>
  ```
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000/api/convert/100/USD/EUR`](http://localhost:4000/api/convert/100/USD/EUR) from your browser to convert 100 USD to EUR.

Limitations: The API does **not** support negative values on the url.