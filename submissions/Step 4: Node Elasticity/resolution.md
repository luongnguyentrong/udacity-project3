# Resolution: Pod Scheduling Failure Due to Insufficient CPU

## Issue Summary
The Kubernetes pods failed to start because there were no nodes available with sufficient CPU resources. The following error was encountered:

0/2 nodes are available: 2 Insufficient CPU. Preemption: 0/2 nodes are available: 2 No preemption victims found for incoming pod.

markdown
Copy code

## Root Cause
Both of the available nodes in the cluster did not have enough CPU resources to fulfill the requested CPU allocation for the pods. Additionally, Kubernetes was unable to find any preemption candidates to free up CPU resources for the incoming pods.

## Resolution Steps
**Increase Node Capacity**: Add more nodes to the cluster or scale up the existing nodes to provide additional CPU resources by adjusting the number of `nodes_desired_size` and `nodes_max_size` to 3 in `eks.tf` file and rerun `terraform apply`.

```
module "project_eks" {
  source             = "./modules/eks"
  name               = local.name
  account            = data.aws_caller_identity.current.account_id
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id
  nodes_desired_size = 3
  nodes_max_size     = 3
  nodes_min_size     = 1

  depends_on = [
    module.vpc,
  ]
}
```