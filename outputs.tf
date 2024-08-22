output "jenkins_url" {
  value = kubernetes_service.jenkins.status[0].load_balancer[0].ingress[0].ip
  description = "The external IP address of Jenkins"
}
