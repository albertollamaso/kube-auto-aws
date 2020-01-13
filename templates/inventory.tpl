[all]
${connection_strings_master}
${connection_strings_node}

[kube-master]
${list_master}


[kube-node]
${list_node}


[k8s-cluster:children]
kube-node
kube-master

[k8s-cluster:vars]
${elb_api_fqdn}
${api_port}
