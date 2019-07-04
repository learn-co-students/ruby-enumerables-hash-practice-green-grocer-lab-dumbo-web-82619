def consolidate_cart(cart)
  # code here
  #first figure out how to convert an array into a hash 
  #next figure out how to consolidate the items
  #add count key and value into the hash
  converted_hash = cart.each {|h| h[:count] = 1}
  converted_hash
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
