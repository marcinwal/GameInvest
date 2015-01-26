helpers do
  def get_quote(cross)
    return YahooFinance.quote(["#{cross}"],[:bid,:ask,:last_trade_price])
  end  
end