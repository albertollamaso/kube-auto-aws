#Global Vars
aws_cluster_name = "myk8scluster"

#VPC Vars
aws_vpc_cidr_block       = "10.250.0.0/16"
aws_cidr_subnets_private = ["10.250.177.0/20", "10.250.192.0/20", "10.250.208.0/20"]

#SG whitelist Var
aws_k8s_nodes_wl = ["53.174.7.233/32", "186.118.15.221/32"]


#Kubernetes Cluster

# Number of master

aws_kube_master_num  = 3
aws_kube_master_size = "t2.medium"

# Number of worker

aws_kube_worker_num  = 3
aws_kube_worker_size = "t2.medium"

#Settings AWS ELB

aws_elb_api_port                = 6443
k8s_secure_api_port             = 6443
kube_insecure_apiserver_address = "0.0.0.0"

default_tags = {
  #  Env = "devtest"
  #  Product = "kubernetes"
}

inventory_file = "inventory/hosts"
