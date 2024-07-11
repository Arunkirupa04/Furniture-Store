const ErrorHandler = require("../utils/errorHandler");
const catchAsyncError = require("./catchAsyncError");
const jwt = require("jsonwebtoken");
const User = require("../models/userModel");

exports.isAuthenticatedUser = catchAsyncError(async (req, res, next) => {
  let token;

  // Check if token is in Authorization header
  const authHeader = req.headers.authorization;
  if (authHeader && authHeader.startsWith("Bearer ")) {
    token = authHeader.split(" ")[1]; // Extract the token from the 'Bearer <token>' format
    console.log("Token from Authorization header:", token);
  }

  // If token not found in Authorization header, check cookies
  if (!token && req.cookies.token) {
    token = req.cookies.token;
    console.log("Token from cookies:", token);
  }

  // If no token is found in either place, send an error
  if (!token) {
    return next(new ErrorHandler("Login First to Access", 401));
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    console.log("Decoded token:", decoded);

    if (!decoded || !decoded.id) {
      return next(new ErrorHandler("Invalid token", 401));
    }

    req.user = await User.findById(decoded.id);

    if (!req.user) {
      return next(new ErrorHandler("User not found", 404));
    }
    next();
  } catch (error) {
    console.error("JWT verification error:", error);
    return next(new ErrorHandler("Invalid or expired token", 401));
  }
});

exports.authorizeRoles = (...roles) => {
  return (req, res, next) => {
    if (!roles.includes(req.user.role)) {
      return next(new ErrorHandler(`Role ${req.user.role} is not allowed`));
    }
    next();
  };
};
