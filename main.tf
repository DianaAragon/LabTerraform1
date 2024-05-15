# main.tf

provider "kubernetes" {
  config_path    = "~/.kube/config"  
  config_context = "minikube"        
}

resource "kubernetes_deployment" "apiholadeployment" {
  metadata {
    name = "apihola"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "apihola"
      }
    }

    template {
      metadata {
        labels = {
          app = "apihola"
        }
      }

      spec {
        container {
          image = "dianaa17dg/apihola:latest"
          name  = "apihola"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "apiholaservice" {
  metadata {
    name = "apiholaservice"
  }

  spec {
    selector = {
      app = "apihola"
    }

    port {
      port        = 80
      target_port = 8080
    }
  }
}
resource "kubernetes_deployment" "mongodb" {
  metadata {
    name = "mongodb"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "mongodb"
      }
    }

    template {
      metadata {
        labels = {
          app = "mongodb"
        }
      }

      spec {
        container {
          name  = "mongodb"
          image = "mongo:latest"  
          port {
            container_port = 27017  
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mongodb-service" {
  metadata {
    name = "mongodb-service"
  }

  spec {
    selector = {
      app = "mongodb"
    }

    port {
      port        = 27017
      target_port = 27017
    }
  }
}