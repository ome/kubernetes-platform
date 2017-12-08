# Infrastructure for managing the Kubernetes platform in the OME

> WARNING: This repository is in development and is not ready for a production deployment of Kubernetes

This repository contains Ansible files for deploying a multi-master
high-availability Kubernetes cluster, and Terraform configuration for
provisioning virtual machines on openstack.

The majority of the work is handled by the [KubeSpray
project](https://github.com/kubernetes-incubator/kubespray/).
A [fork](https://github.com/openmicroscopy/kubespray) exists
in the openmicroscopy organization.


## Example usage

This example uses a configuration defined under `kubetest`.
You can either modify this configuration, or copy the directory.

Create some virtual machines on openstack using the configuration in `kubetest/kubespray.tf` and `kubetest/kubetest.tfvars`:

    ENV=kubetest
    ./run-terraform.sh $ENV init
    ./run-terraform.sh $ENV get
    ./run-terraform.sh $ENV apply

> Terraform uses a [state file](https://www.terraform.io/docs/state/) `$ENV/terraform.tfstate` and does not take existing infrastructure into account, so if multiple users are maintaining the same deployment this file must be shared.
> These terraform commands are idempotent as long as this tfstate file is present.
> If you run terraform without this state file it will create a new set of infrastructure (with the same names).

Install Kubernetes using a dynamic terraform inventory based on the tfstate file, and inventory variables in `kubetest/inventory/inventory.yml`:

    ./run-ansible.sh $ENV

If this works you should have a kubernetes admin file in `kubespray/artifacts/admin.conf`.
Copy this, and edit the `clusters.cluster.server` key to point to the external address of the Kubernetes cluster.

Connect to the cluster using a local `kubectl` client:

    $ kubectl --kubeconfig=admin.conf get nodes

    NAME                     STATUS    ROLES     AGE       VERSION
    kubetest-k8s-master-1    Ready     master    5d        v1.8.3+coreos.0
    kubetest-k8s-node-nf-1   Ready     node      5d        v1.8.3+coreos.0
    kubetest-k8s-node-nf-2   Ready     node      5d        v1.8.3+coreos.0
