FROM ubuntu:18.04

# Tools versions
# https://dl.k8s.io/release/stable.txt
ARG KUBECTL_VERSION=1.24.2
# https://github.com/helm/helm/releases
ARG HELM2_VERSION=2.17.0
ARG HELM3_VERSION=3.9.1
# https://github.com/derailed/k9s/releases
ARG K9S_VERSION=0.25.21

# Install utilities
RUN apt-get update -y && apt-get install -y curl jq ca-certificates git vim bash-completion

# kubectl with bash completion
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && kubectl completion bash > /etc/bash_completion.d/kubectl \
    && echo "source /etc/bash_completion" >> ~/.bashrc \
    && echo "source /etc/bash_completion.d/kubectl" >> ~/.bashrc

# kubectl aliases
RUN curl https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases -o /root/.aliases \
    && echo "source /root/.aliases" >> ~/.bashrc

# kubectx / kubens
RUN curl https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx -o /usr/local/bin/kubectx \
    && curl https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens -o /usr/local/bin/kubens \
    && chmod +x /usr/local/bin/kubectx /usr/local/bin/kubens

# k9s
RUN curl -L https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_v${K9S_VERSION}_Linux_x86_64.tar.gz -o /tmp/k9s.tar.gz \
  && tar -xf /tmp/k9s.tar.gz \
  && chmod +x k9s \
  && mv k9s /usr/local/bin/

# kube-ps1
RUN curl https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh -o /usr/local/bin/kube-ps1.sh \
    && echo "source /usr/local/bin/kube-ps1.sh" >> ~/.bashrc \
    && echo "export PS1='[\u@\h \W \$(kube_ps1)] \$ '" >> ~/.bashrc

# Install Helm 3 client
RUN curl -O https://get.helm.sh/helm-v${HELM3_VERSION}-linux-amd64.tar.gz \
    && tar -xvf helm-v${HELM3_VERSION}-linux-amd64.tar.gz \
    && cp linux-amd64/helm /usr/local/bin/helm3 \
    && rm -rf linux-amd64

# Install Helm 2 client
RUN curl -O https://get.helm.sh/helm-v${HELM2_VERSION}-linux-amd64.tar.gz \
    && tar -xvf helm-v${HELM2_VERSION}-linux-amd64.tar.gz \
    && cp linux-amd64/helm /usr/local/bin/helm2 \
    && rm -rf linux-amd64

ENV KUBECONFIG=/kubeconfig
CMD ["bash"]
