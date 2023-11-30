## ✅Github Actions 과 ArgoCD 를 이용하여 CI/CD를 구축합니다. 

### 참고링크
[🔗CI/CD](https://catalog.us-east-1.prod.workshops.aws/workshops/9c0aa9ab-90a9-44a6-abe1-8dff360ae428/ko-KR/110-cicd/100-cicd)
---

### CI/CD Pipeline입니다.
<img src="https://github.com/tthingbini/ecommerce-workshop-src/assets/137377076/d3d3b462-b439-46f8-bb71-f38cde5bfd57">

## **1. ArgoCD 설치**

### **(1)** ArgoCD 를 EKS 클러스터에 설치

다음을 실행 하여 ArgoCD를 eks cluster 에 설치합니다.

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

본 실습에서 사용하지는 않지만, ArgoCD 는 CLI을 제공 합니다. 아래를 실행하여 ArgoCD CLI 를 설치합니다.

```bash
cd ~/environment
VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')

sudo curl --silent --location -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-linux-amd64

sudo chmod +x /usr/local/bin/argocd
```

ArgoCD 서버는 기본적으로 퍼블릭 하게 노출되지 않습니다. 실습의 목적상 이를 변경하여 ELB 를 통해 접속 가능하도록 하겠습니다.

```bash
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

3-4 분 정도 후 아래 명령을 통해 ArgoCD 접속이 가능한 ELB 주소를 얻습니다.

```bash
export ARGOCD_SERVER=`kubectl get svc argocd-server -n argocd -o json | jq --raw-output .status.loadBalancer.ingress[0].hostname`
echo $ARGOCD_SERVER
```

ArgoCD의 Username은 `admin` 입니다. 이것이 사용하는 password는 아래 실행을 통해 얻습니다.

```bash
ARGO_PWD=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`
echo $ARGO_PWD
```

```bash
-wmyKxH2mzZX88Xo
```

위에서 얻은 `$ARGOCD_SERVER`를 브라우저에서 오픈 합니다. 그리고 Username `admin` 을 입력하고 Password 는 `$ARGO_PWD` 값을 입력합니다.



## **2. ArgoCD 설정**

### **(1)** Configure ArgoCD

application 추가

<img src="https://github.com/tthingbini/ecommerce-workshop-src/assets/137377076/ee0a07e7-68cf-4e20-bc79-05f05aaab7fd">

**SOURCE** 섹션의 **Repository URL** 에는 앞서 생성한 **`k8s-manifest-repo`의 git 주소**, **Revision** 에는 `main`, **Path** 에는 `overlays/dev`를 입력합니다.

<img src="https://github.com/tthingbini/ecommerce-workshop-src/assets/137377076/6a631183-6063-4cce-8779-fef4a6a7607a">

**DESTINATION** 섹션의 **Cluster URL**에는 `https://kubernetes.default.svc`, **Namespace** 에는 `default`를 입력 하고 상단의 **Create** 를 클릭합니다.

<img src="https://github.com/tthingbini/ecommerce-workshop-src/assets/137377076/aa20acdf-2de2-4d66-8440-0266c263653b">

정상적으로 설정이 마무리 되면 다음과 같이 **eksworkshop-cd-pipeline** 이 생성됩니다.

<img src="https://github.com/tthingbini/ecommerce-workshop-src/assets/137377076/4ed73b8a-2dde-4cab-b2f8-93308f22556a">

### **3. LoadBalancer로 접속 시 정상적으로 배포되었음을 확인할 수 있습니다.**

<img src="https://github.com/tthingbini/ecommerce-workshop-src/assets/137377076/4c059f08-cf10-4a07-8606-19ce3812f966">
