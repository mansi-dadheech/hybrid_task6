# Deploy the Wordpress application on Kubernetes and AWS using terraform.
<br>
## Main Objective: <br>
To create a infrastructure as a code using terraform for using RDS service for wordpress application.<br><br>
## Steps:<br>
**Write an Infrastructure as code using terraform, which automatically deploy the Wordpress application**<br>
For this we have to create two files for wordpress and rds:<br>
***Wordpress***<br>
```
provider "kubernetes" {
  config_context_cluster = "minikube"
}



resource "kubernetes_deployment" "wordpress" {
 
  metadata {
    name = "wordpress"
    labels = {
      test = "wordpressApp"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        test = "wordpressApp"
      }
    }

    template {
      metadata {
        labels = {
          test = "wordpressApp"
        }
      }
    spec {
        container {
          image = "wordpress:4.8-apache"
          name  = "wordpress"
          
        }
    }
}
}
}

resource "kubernetes_service" "service" {
  metadata {
    name = "service"
  }
  spec {
    selector = {
	 test = "wordpressApp"
      
      
    }
    port {
      port        = 8080
      target_port = 80
      node_port   = 30000
    }

    type = "NodePort"
  }
}

```
***Amazon Relational Database System***<br>
```
provider "aws" {
  region     = "ap-south-1"
  profile    = "mansi"
}

resource "aws_db_instance" "default" {
  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "myrdsdb"
  username             = "mansi22dadheech"
  password             = "Mansi1234dadheech"
  parameter_group_name = "default.mysql5.7"
  publicly_accessible  = true
  skip_final_snapshot  = true
  tags = {
  Name = "myrdsdb"
  }
}
```
<br>

On Applying by terraform<br>
```
#terraform init
#terraform apply
```

## Outputs We get:
<br>
![Screenshot (546)](https://user-images.githubusercontent.com/48363834/95426692-f31b5880-0963-11eb-894a-55239ac94766.png)
<br>
After applying...checking for pods.<br>
![Screenshot (547)](https://user-images.githubusercontent.com/48363834/95427031-910f2300-0964-11eb-8c5e-4c99aa49acd4.png)
<br>
Now starting for wordpress service:
getting URL by
![Screenshot (545)](https://user-images.githubusercontent.com/48363834/95427346-07ac2080-0965-11eb-97db-2aaa55af33fc.png)
<br>

Wordpress Site:
<br>
![Screenshot (543)](https://user-images.githubusercontent.com/48363834/95427533-58bc1480-0965-11eb-863d-57540b672c9f.png)<br>
![Screenshot (544)](https://user-images.githubusercontent.com/48363834/95427541-5b1e6e80-0965-11eb-83c7-6cfe92958b0a.png)

<br>
Amazon RDS:
![Screenshot (542)](https://user-images.githubusercontent.com/48363834/95427649-843eff00-0965-11eb-9c6b-e2fdb73d2bd7.png)


