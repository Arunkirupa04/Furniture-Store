const express = require("express");
const {
  getAllProducts,
  createProduct,
  updateProduct,
  deleteProduct,
  getProductById,
  createProductReview,
  getProductReviews,
  deleteReview,
  getProductsByCategory,
  getProducts,
} = require("../controllers/productController");
const {
  isAuthenticatedUser,
  authorizeRoles,
} = require("../middlewares/authenticate");

const router = express.Router();

router.route("/products").get(isAuthenticatedUser, getProducts);
router
  .route("/products/category")
  .get(isAuthenticatedUser, getProductsByCategory);
router.route("/admin/product/new").post(createProduct);
// .post(isAuthenticatedUser, authorizeRoles("admin"), createProduct);
router
  .route("/admin/product/:id")
  .put(isAuthenticatedUser, authorizeRoles("admin"), updateProduct)
  .delete(isAuthenticatedUser, authorizeRoles("admin"), deleteProduct);

router.route("/product/:id").get(getProductById);

router.route("/review").put(isAuthenticatedUser, createProductReview);
router
  .route("/reviews")
  .get(getProductReviews)
  .delete(isAuthenticatedUser, deleteReview);

module.exports = router;
