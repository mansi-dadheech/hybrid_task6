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


