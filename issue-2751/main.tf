module "call" {
  source = "./mod1"
  input  = "test"
  input2 = "test2"
}

module "call1" {
  source = "./mod1"
  input  = "test"
  input2 = "test2"
}

locals {
  i1 = module.call.modout1
  i2 = module.call.modout2
  i3 = module.call1.modout1
  i4 = module.call1.modout2
}
