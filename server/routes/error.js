const errorMiddleware = (err, req, res, next) => {
  if (err) {
    const errorName = err.name || "Unknow Error!";
    const errorStatus = err.status || 500;
    const errorMessage = err.message || "Something went wrong!";
    const errorStack = err.stack || "Unknown";
    return res.status(errorStatus).json({
      success: false,
      name: errorName,
      message: errorMessage,
      code: errorStatus,
      stack: errorStack,
    });
  }
};

module.exports = errorMiddleware;
