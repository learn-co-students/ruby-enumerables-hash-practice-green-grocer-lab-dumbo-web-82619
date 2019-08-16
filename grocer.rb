def consolidate_cart(cart)
  return_hash = {}
  cart.each do |hash|
    hash.each do |k, v|
      if return_hash[k]
        return_hash[k][:count] += 1
      else 
        return_hash[k] = v
        return_hash[k][:count] = 1
      end
    end
  end
  return return_hash
end

def apply_coupons(cart, coupons)
  coup_hash = {}
  coupons.each { |key, value| coup_hash[key] = value}
  temp_hash = {}
  cart.each do |k, v|
    coup_hash.each do |k2,v2| 
      if k2[:item] == k
        if v[:count] >= k2[:num]
          temp_count = v[:count] / k2[:num]
          cou_count = temp_count * k2[:num]
          v[:count] = v[:count] - cou_count
          temp_hash["#{k} W/COUPON"] = {
            :price => k2[:cost] / k2[:num],
            :clearance => v[:clearance],
            :count => cou_count
          }  
        end
      end
    end
  end
  return_hash = cart.merge(temp_hash)
  return_hash
end

def apply_clearance(cart)
  cart.each do |k, v|
    if v[:clearance]
      v[:price] = (v[:price]*0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  concart = consolidate_cart(cart)
  disccart = apply_coupons(concart, coupons)
  finalcart = apply_clearance(disccart)
  total = 0 
  finalcart.each do |k, v|
    total += v[:price] * v[:count]
  end
  if total > 100
    total = total*0.9
  end
  total
end

