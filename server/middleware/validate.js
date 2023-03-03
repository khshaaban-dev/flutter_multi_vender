const joi = require("joi");
const signupValidator = async (req, res, next) => {
  // signup schema for validation
  const schema = joi
    .object()
    .keys({
      name: joi.string().required(),
      email: joi.string().email({ minDomainSegments: 2 }).required(),
      password: joi.string().min(6).max(20).required(),
    })
    .options({ abortEarly: false });

  // get req body
  const { name, email, password } = req.body;

  const { error } = schema.validate({
    name,
    email,
    password,
  });
  if (error) {
    return res.status(400).json({ msg: error.details.map((v) => v.context) });
  }
  next();
};

module.exports = [signupValidator,];
