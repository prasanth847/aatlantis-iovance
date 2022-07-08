provider "aws"{
     region = var.aws_region
     access_key = var.access_key
     secret_key = var.secret_key
}

module "lambda"{
  source = "./modules/lambda"
  lambda_role_1 = module.iam.lambda_role1
  lambda_role_2 = module.iam.lambda_role2
  lambda_role_3 = module.iam.lambda_role3

}

module "iam"{
  source = "./modules/iam"
}

module "mwaa"{
  source = "./modules/mwaa"
  distillmwaaBucketarn = module.s3.s3_bucket
  distill-mwaa-sgid = module.SecurityGroup.distill-mwaa-sg_id
  mwaa_role_1arn = module.iam.mwaa_role_1
}

module "s3"{
  source = "./modules/s3"
}

module "api_gw"{
  source = "./modules/api_gw"
  api_lambda_funcarn = module.lambda.function_name
}

module "SecurityGroup"{
  source = "./modules/SecurityGroup"
}

module "Transferfamily"{
  source = "./modules/Transferfamily"
  tf_role_1arn = module.iam.tf_role_1
  vender_transfer_lambdaarn = module.lambda.vender_transfer_lambda
}