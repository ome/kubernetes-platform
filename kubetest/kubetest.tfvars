# merge-pr1958

external_net = "e25c3173-bb5c-4bbc-83a7-f0551099c8cd"
network_name = "kubetest-network"
floatingip_pool = "ext-net-36"

cluster_name = "kubetest"
number_of_k8s_masters = 1
number_of_k8s_masters_no_etcd = 0
number_of_etcd = 0
number_of_k8s_masters_no_floating_ip = 0
number_of_k8s_masters_no_floating_ip_no_etcd = 0
number_of_k8s_nodes = 0
number_of_bastions = 0
number_of_k8s_nodes_no_floating_ip = 2
number_of_gfs_nodes_no_floating_ip = 2
gfs_volume_size_in_gb = 50
# Don't schedule pods on masters
supplementary_master_groups = ""

public_key_path = "~/.ssh/id_rsa-idrdeployment.pub"
image = "CentOS7-1612"
image_gfs = "CentOS7-1612"
ssh_user = "centos"
ssh_user_gfs = "centos"
flavor_k8s_master = "c511a528-319b-4378-b5ff-1f87ac3288af" # s1.massive
flavor_k8s_node = "1b5cfe48-58fe-4778-b18a-f1067d80ebfa" # s1.gargantuan
flavor_etcd = 3
flavor_gfs_node = "f3fcc537-c1fc-4108-a174-eb5bf52e7481" # s1.huge
flavor_bastion = 3

dns_nameservers = ["8.8.4.4", "8.8.8.8"]

k8s_master_fips = ["193.62.55.95"]
k8s_node_fips = []
bastion_fips = []
