def consolidate_cart(cart)
  # code here  
  new_hash = {}
  
  cart.each do |product|
    product.each do |name, price|
      if !new_hash[name]
        new_hash[name] = price.merge({:count => 1})
      end 
    end 
  end 
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

