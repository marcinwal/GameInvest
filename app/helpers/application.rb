helpers do
  def get_quote(cross)
    return YahooFinance.quote(["#{cross}"],[:bid,:ask,:last_trade_price])
  end  

  def send_hash_to_jason(hash)
    return json(hash, :encoder => :to_json,:content_type => :js)
  end  
end