const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res
        .status(401)
        .json({ message: "Token is required ,access denied" });

    const verifiedToken = jwt.verify(token, process.env.ACCESS_TOKEN_KEY);
    if (!verifiedToken)
      return res
        .status(401)
        .json({ message: "Token is not valid ,access denied" });

    req.userId = verifiedToken.id;
    req.token = token;
    next();
  } catch (error) {
    return res
      .status(500)
      .json({ message: error.message});
  }
};
module.exports = auth;