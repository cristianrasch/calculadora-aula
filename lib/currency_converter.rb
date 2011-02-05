require 'net/http'

class CurrencyConverter

  def self.eval obj, attr
    if obj.send("#{attr}_curr") == Currency::DEFAULT
      obj.send attr
    else
      convert obj.send(attr), obj.send("#{attr}_curr"), Currency::DEFAULT
    end
  end

  private

  @ex_rates = {}
  CURRENCIES = {Currency::ARS => 'ARS', Currency::USD => 'USD'}

  def self.convert(amount, from_curr, to_curr = Currency::DEFAULT)
    k = key from_curr, to_curr
    unless @ex_rates.has_key?(k) && (Time.now-@ex_rates[k].last) < Conf.curr_conv['cache_timeout'].hours
      fetch_ex_rate from_curr, to_curr
    end
    amount*@ex_rates[k].first
  end
  
  def self.fetch_ex_rate(from_curr, to_curr)
    http = Net::HTTP.new Conf.curr_conv['host']
    response = http.get "/#{CURRENCIES[from_curr]}/#{CURRENCIES[to_curr]}/?k=#{Conf.curr_conv['api_key']}"
    @ex_rates[key(from_curr, to_curr)] = [response.body.to_f, Time.now]
  end
  
  def self.key(from_curr, to_curr)
    "#{from_curr}_#{to_curr}"
  end
  
end