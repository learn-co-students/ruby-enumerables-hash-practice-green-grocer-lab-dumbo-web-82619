def consolidate_cart(cart)
  holder = {}
  
  cart.each{
    |hash|
    hash.each{
      |key, info|
      if holder[key]
        holder[key][:count] += 1
      else holder[key] = info
        holder[key][:count] = 1
      end
    }
  }
  
  return holder
end

def apply_coupons(cart, coupons)
  
  coupons.each do |coupon| 
    coupon.each do |attribute, value| 
      name = coupon[:item] 
    
      if cart[name] && cart[name][:count] >= coupon[:num] 
        if cart["#{name} W/COUPON"] 
          cart["#{name} W/COUPON"][:count] += coupon[:num] 
        else 
          cart["#{name} W/COUPON"] = {:price => coupon[:cost] / coupon[:num], 
          :clearance => cart[name][:clearance], :count => coupon[:num]} 
        end 
  
      cart[name][:count] -= coupon[:num] 
    end 
  end 
end 
  cart 
  
end

def apply_clearance(cart)
  cart.each{
    |name, info|
    if info[:clearance] == true
      info[:price] = (info[:price] * 0.8).round(2)
    end
  }
  return cart
end

def checkout(cart, coupons)
  total = 0
  final_cart = consolidate_cart(cart)
  final_coupon = apply_coupons(final_cart, coupons)
  final_clearence = apply_clearance(final_coupon)
  
  final_clearence.each{
    |name, info|
    total += (info[:price] * info[:count])
  }
  
  if total > 100
    final = total * 0.9
    return final
  else return total
 end
  
end





