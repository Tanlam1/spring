const changeQuantity = (cartItemId, name, part = 0) => {

    const quantity = document.querySelector(`[name="${name}"]`)

    if(quantity) {
        window.location.href = 
            `/cart/update/quantity/${cartItemId}/${quantity.value*1 + part}`
    }

}