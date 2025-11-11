FROM alpine:3.22

# Tools versions
# https://dl.k8s.io/release/stable.txt
ARG KUBECTL_VERSION=1.34.1
# https://github.com/helm/helm/releases
ARG HELM_VERSION=3.19.1
# https://github.com/derailed/k9s/releases
ARG K9S_VERSION=0.50.16

# Install utilities
RUN apk add -u curl jq ca-certificates git bash bash-completion

# kubectl with bash completion
RUN curl -LO https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && echo 'source <(kubectl completion bash)' >>~/.bashrc

# kubectl aliases
RUN curl https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases -o /root/.aliases \
    && echo "source /root/.aliases" >> ~/.bashrc

# kubectx / kubens
RUN curl https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx -o /usr/local/bin/kubectx \
    && curl https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens -o /usr/local/bin/kubens \
    && chmod +x /usr/local/bin/kubectx /usr/local/bin/kubens

# k9s
RUN curl -L https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_Linux_amd64.tar.gz -o /tmp/k9s.tar.gz \
  && tar -xf /tmp/k9s.tar.gz \
  && chmod +x k9s \
  && mv k9s /usr/local/bin/

# kube-ps1
RUN curl https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh -o /usr/local/bin/kube-ps1.sh \
    && echo "source /usr/local/bin/kube-ps1.sh" >> ~/.bashrc \
    && echo "export PS1='[\u@\h \W \$(kube_ps1)] \$ '" >> ~/.bashrc

# Install Helm client
RUN curl -O https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && tar -xvf helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && cp linux-amd64/helm /usr/local/bin/helm \
    && rm -rf linux-amd64

ENV KUBECONFIG=/kubeconfig
CMD ["bash"]
