<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
<style>
        body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
}

.top-nav {
  background-color: #333;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px;
}

.logo {
  font-size: 24px;
}

.cartt {
  position: relative;
  cursor: pointer;
}

.cart img {
  width: 30px;
  height: 30px;
}

.cart-count {
  position: absolute;
  top: 5px;
  right: 5px;
  background-color: red;
  color: #fff;
  border-radius: 50%;
  padding: 5px;
  font-size: 12px;
}

.cart-drawerr {
  position: fixed;
  top: 25px;
  right: -350px;
  max-height: 400px;
  width: 300px;
  background-color: #f2f2f2;
  padding: 20px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
  transition: right 0.3s ease-in-out;
  overflow-y: auto; 
}


.cart-drawerr.open {
  right: 0;
}

.cart-itemss {
  max-height: 400px;
  overflow-y: auto;
  margin-bottom: 20px;
  /* Set a max height, accounting for the cart header */

}

.checkout-buttonn {
  display: block;
  width: 100%;
  background-color: #333;
  color: #fff;
  border: none;
  padding: 10px;
  font-size: 16px;
  cursor: pointer;
}

.cart-headerr {
  display: flex;
  justify-content: flex-end;
  padding: 3px;
  backdrop-filter: blur(16px) saturate(180%);
    -webkit-backdrop-filter: blur(16px) saturate(180%);
    background-color: rgba(255, 255, 255, 0.75);
    border-radius: 12px;
    border: 1px solid rgba(209, 213, 219, 0.3);
}

.iconn {
  cursor: pointer;
  font-size: 35px;
  padding: 5px;
}
.itemm {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

.title-pricee,
.quantity-removee,
.cart-headerr {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.titlee,
.pricee,
.quantityy,
.removee,
.close-iconn,
.iconn {
  display: inline-block;
  /* Add any additional styles for each element here */
}

.itemss{
    border-bottom: 1px solid;
}

.counterr {
    width: 100px;
    display: flex;
    align-items: center;
    justify-content: center;
}
.counterr input {
    width: 25px;
    border: 0;
    line-height: 15px;
    font-size: 15px;
    text-align: center;
    background: #0052cc;
    color: #fff;
    appearance: none;
    outline: 0;
}
.counterr span {
    display: block;
    font-size: 25px;
    padding: 0 10px;
    cursor: pointer;
    color: #0052cc;
    user-select: none;
}


    </style>
</head>
<body>
    

    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link rel="stylesheet" href="styles.css">
      <title>Top Nav Bar with Cart</title>
    </head>
    <body>
      <nav class="top-nav">
        <div class="logo">Your Logo</div>
        <div class="cartt" onclick="toggleCart()">
          <img src="cart-icon.png" alt="Cart Icon">
          <span class="cart-count">0</span>
        </div>
      </nav>
    
      <div id="cartDrawerr" class="cart-drawerr">
        <div class="cart-headerr">
            <div class="close-iconn"><h4>Your Cart (2)</h4></div>
            <div class="iconn" onclick="toggleCart()">&times;</div>
        </div>

        <div class="cart-itemss">
          <!-- Your dynamically generated cart items will go here -->
    
          <div class="itemm">
            <div class="title-pricee">
              <div class="titlee">
                <h4>Asian's Pizza</h4>
              </div>
              <div class="pricee">&#8377; 100</div>
            </div>
            <div class="quantity-removee">
              <div class="quantityy">
                <div class="counterr">
                  <span class="down" onClick='decreaseCount(event, this)'>-</span>
                  <input type="text" value="1">
                  <span class="up" onClick='increaseCount(event, this)'>+</span>
                </div>
              </div>
              <div class="removee">Remove</div>
            </div>
          </div>
          <hr>
    
          <div class="itemm">
            <div class="title-pricee">
              <div class="titlee">
                <h4>Asian's Pizza</h4>
              </div>
              <div class="pricee">&#8377; 100</div>
            </div>
            <div class="quantity-removee">
              <div class="quantityy">
                <h4>Quantity</h4>
              </div>
              <div class="removee">Remove</div>
            </div>
          </div>
          <hr>


          <div class="itemm">
            <div class="title-pricee">
              <div class="titlee">
                <h4>Asian's Pizza</h4>
              </div>
              <div class="pricee">&#8377; 100</div>
            </div>
            <div class="quantity-removee">
              <div class="quantityy">
                <h4>Quantity</h4>
              </div>
              <div class="removee">Remove</div>
            </div>
          </div>
         
         
         
         
          <!-- Add more cart items here -->
        </div>
    
       
        <button class="checkout-buttonn">Checkout</button>
      </div>
    
    
    
    
   
<script>
    function increaseCount(a, b) {
  var input = b.previousElementSibling;
  var value = parseInt(input.value, 10);
  value = isNaN(value) ? 0 : value;
  value++;
  input.value = value;
}

function decreaseCount(a, b) {
  var input = b.nextElementSibling;
  var value = parseInt(input.value, 10);
  if (value > 1) {
    value = isNaN(value) ? 0 : value;
    value--;
    input.value = value;
  }
}
</script>
    










<script>
    let isCartOpen = false;

    function toggleCart() {
      const cartDrawerr = document.getElementById('cartDrawerr');
      isCartOpen = !isCartOpen;
      if (isCartOpen) {
        cartDrawerr.classList.add('open');
      } else {
        cartDrawerr.classList.remove('open');
      }
    }
    </script>


</body>
</html>