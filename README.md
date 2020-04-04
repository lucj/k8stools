## Purpose

Image containing several usefull tools to interact with a Kubernetes cluster

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
- helm2 client
- helm3 client
- k9s

## Usage

The following command run a bash shell in a container based on the k8stools images

```
$ docker run -ti \
  -v PATH_TO_KUBE_CONFIG:/kubeconfig \
  lucj/k8stools:TAG
```

