def consolidate_cart(cart)
  result = {}
  i = 1
  cart.map do |item|
    item.values[0][:count] ? item.values[0][:count] += i : item.values[0][:count] = i
    result[item.keys[0]] = item.values[0]
  end
  return result
end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item]) #prevents error if no coupon
      if cart[coupon[:item]][:count] >= coupon[:num] #checks qty coupon can apply to & prevents error
        new_name = "#{coupon[:item]} W/COUPON"
        if cart[new_name]
          cart[new_name][:count] += coupon[:num] #increments coupon if multiples 
        else
          cart[new_name] = {:price => coupon[:cost] / coupon[:num], :clearance => cart[coupon[:item]][:clearance], :count => coupon[:num]} #adds new key/value pair to hash(cart) & remembers clearance & adds coupon price & adds coupon count 
        end
        cart[coupon[:item]][:count] -= coupon[:num] #updates non-discounted item count
      end
    end
  end
  return cart
end
          

def apply_clearance(cart)
    cart.reduce({}) do |memo, (key, value)|
      if value[:clearance] == true 
        value[:price] -= value[:price] * 0.20
        value[:price].round(2)
      end
      memo
    end
    return cart
end


=begin 
def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = item[:price] * item[:count]
  cart.keys.each do |item|
    total += item[:price] * item[:count]
  end
  if total > 100.00 
    total -= total * 0.10 
  end
  return total
end
=end


def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each do |key, value|
    total += value[:price] * value[:count]
  end
  total > 100.00 ? total -= total * 0.10 : total
  return total
end


