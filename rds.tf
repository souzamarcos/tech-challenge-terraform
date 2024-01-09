resource "random_password" "db_product_password"{
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "random_password" "db_order_password"{
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_db_instance" "db_product" {
  depends_on                    = [random_password.db_product_password]
  allocated_storage             = 5
  db_name                       = "ms-product"
  engine                        = "mysql"
  engine_version                = "8.0.34"
  allow_major_version_upgrade   = true
  instance_class                = "db.t3.micro"
  username                      = "fiap"
  password                      = random_password.db_product_password.result
  parameter_group_name          = "default.mysql8.0"
  publicly_accessible           = true
  db_subnet_group_name          = module.vpc.database_subnet_group_name
  availability_zone             = module.vpc.azs[0]
  skip_final_snapshot           = true
}

resource "aws_db_instance" "db_order" {
  depends_on                    = [random_password.db_order_password]
  allocated_storage             = 5
  db_name                       = "ms-order"
  engine                        = "mysql"
  engine_version                = "8.0.34"
  allow_major_version_upgrade   = true
  instance_class                = "db.t3.micro"
  username                      = "fiap"
  password                      = random_password.db_order_password.result
  parameter_group_name          = "default.mysql8.0"
  publicly_accessible           = true
  db_subnet_group_name          = module.vpc.database_subnet_group_name
  availability_zone             = module.vpc.azs[0]
  skip_final_snapshot           = true
}
