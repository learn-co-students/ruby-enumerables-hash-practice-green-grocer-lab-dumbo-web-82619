def consolidate_cart(cart)
  # code here  
  output = {}
  cart.each do |item_hash|
    item_hash.each do |name, price|
      if output[name].nil?
        output[name] = price.merge({:count => 1})
      else
        output[name][:count] += 1
      end
    end
  end
  output
end

def apply_coupons(cart, coupons)
  # code here
  
end

def apply_clearance(cart)
  # code here
  
end

def checkout(cart, coupons)
  # code here 
 
end

