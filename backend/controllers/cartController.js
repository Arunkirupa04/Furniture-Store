const catchAsyncError = require("../middlewares/catchAsyncError");
const ErrorHandler = require("../utils/errorHandler");
const Cart = require("../models/cartModel");
const User = require("../models/userModel"); //It wants to change as seller model
const Product = require("../models/productModel");

exports.addToCart = catchAsyncError(async (req, res, next) => {
  console.log("Try to add in cart");
  const userId = req.user._id;
  const { productId, quantity } = req.body;

  // Validate request data
  if (!userId || !productId || !quantity) {
    return next(new ErrorHandler(400, "Invalid request data"));
  }

  // Find the product to ensure it exists
  const product = await Product.findById(productId);
  if (!product) {
    return next(new ErrorHandler(404, "Product not found"));
  }

  // Check if the product is already in another user's cart
  if (product.inCart && product.cartUser.toString() !== userId.toString()) {
    return next(
      new ErrorHandler(400, "Product is already in another user's cart")
    );
  }

  // Find the user's cart or create a new one if it doesn't exist
  let cart = await Cart.findOne({ user: userId });
  if (!cart) {
    cart = new Cart({ user: userId, products: [] });
  }

  const existingProductIndex = cart.products.findIndex((item) => {
    return item.productId.toString() === productId;
  });

  if (existingProductIndex !== -1) {
    // If the product already exists, update its quantity
    cart.products[existingProductIndex].quantity += quantity;
  } else {
    // If the product doesn't exist, add it to the cart
    cart.products.push({
      productId: productId,
      quantity,
    });
  }

  // Save the updated cart and product
  await cart.save();
  await product.save();

  res
    .status(201)
    .json({ success: true, message: "Product added to cart successfully" });
});

exports.getCartProduct = catchAsyncError(async (req, res, next) => {
  try {
    const userId = req.user._id;

    // Find cart items for the specified user and populate the productId field
    let cartItems = await Cart.findOne({ user: userId }).populate(
      "products.productId"
    );

    if (!cartItems) {
      return res
        .status(404)
        .json({ success: false, message: "No cart items found" });
    }

    // Map populated data to required format
    const responseData = cartItems.products.map((item) => ({
      productId: item.productId._id,
      productName: item.productId.name,
      price: item.productId.price,
      brand: item.productId.brand,
      quantity: item.quantity,
      imageUrl: item.productId.images[0].url,
    }));

    res.status(200).json({ success: true, cartItems: responseData });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
});

exports.deleteProductFromCart = catchAsyncError(async (req, res, next) => {
  try {
    const userId = req.user._id;
    const productIdToDelete = req.params.id;

    // Find the user's cart
    const cart = await Cart.findOne({ user: userId });
    if (!cart) {
      return res
        .status(404)
        .json({ success: false, message: "Cart not found" });
    }

    // Find the index of the product to delete
    const productIndexToDelete = cart.products.findIndex(
      (item) => item.productId.toString() === productIdToDelete
    );

    if (productIndexToDelete === -1) {
      return res
        .status(404)
        .json({ success: false, message: "Product not found in the cart" });
    }

    // Remove the product from the cart
    cart.products.splice(productIndexToDelete, 1);

    // Update the cart in the database
    await cart.save();

    // Update the product's cart details
    const product = await Product.findById(productIdToDelete);
    if (product) {
      product.inCart = false;
      product.cartUser = null;
      product.cartTimestamp = null;
      product.isInterested = false;
      product.interestedTimestamp = null;
      await product.save();
    }

    res.status(200).json({
      success: true,
      message: "Product removed from cart successfully",
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
});

//update product quantity
exports.updateCartItemQuantity = catchAsyncError(async (req, res, next) => {
  const userId = req.user._id;
  const productId = req.params.id;
  const { quantity } = req.body;

  // Validate request data
  if (!userId || !productId || !quantity) {
    return next(new ErrorHandler(400, "Invalid request data"));
  }

  // Find the user's cart
  let cart = await Cart.findOne({ user: userId });

  if (!cart) {
    return next(new ErrorHandler(404, "Cart not found"));
  }

  // Find the index of the product in the cart
  const productIndex = cart.products.findIndex((item) => {
    return item.productId.toString() === productId;
  });

  if (productIndex === -1) {
    return next(new ErrorHandler(404, "Product not found in cart"));
  }

  // Update the quantity of the product
  cart.products[productIndex].quantity = quantity;

  // Save the updated cart to the database
  await cart.save();

  res.status(200).json({
    success: true,
    message: "Cart item quantity updated successfully",
  });
});
