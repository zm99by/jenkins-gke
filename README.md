# jenkins-gke

```
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your-service-account-key.json"
```

```
jenkins-gke/
├── main.tf
├── outputs.tf
├── variables.tf
├── terraform.tfvars
├── .gitignore
├── modules/
│   ├── gke/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── jenkins/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   └── kubernetes/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf


```
