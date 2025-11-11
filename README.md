## Purpose

Image containing several useful tools to interact with a Kubernetes cluster

## Content

The image contains the following (and usual) packages:
- curl
- jq
- ca-certificates
- git
- vim 
- bash-completion

and the following kubernetes related tools:
- kubectl (with bash completion)
- kubectl aliases (https://github.com/ahmetb/kubectl-aliases)
- kubectx / kubens (https://github.com/ahmetb/kubectx)
- kube-ps1 (https://github.com/jonmosco/kube-ps1)
- helm client
- k9s

Latest version (1.34.1) contains the following components:

- kubectl: 1.34.1
- helm: 3.19.1
- k9s: 0.50.16

## Usage

The following command run a bash shell in a container based on the k8stools images

```bash
docker run -ti -v PATH_TO_KUBE_CONFIG:/kubeconfig lucj/k8stools:1.34.1
```

Once in the shell, you can run any *kubectl* commands against the cluster corresponding to the kubeconfig file provided.

The great *k9s* tool is available, just run it with

```bash
k9s
```
