const createError = (errorStatus, errorMessage) => {
    const error = new Error();
    error.status = errorStatus;
    error.message = errorMessage;
    return error;
}

module.exports = createError;