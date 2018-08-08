
# 建置一套可以展示用的K8S系統流程
引導如何建置一整套 EKS 叢集並實際運作prometheus監控

## k8s套件預先安裝完畢
kubernetes client 元件預先安裝完畢
- helm
- kubectl (必要!!)
- heptio-authenticator-aws (必要!!)
- awscli (必要!!)
- 建立 cluster , 建立 IAM USER , 賦予金鑰

## 修改bashrc

- 最主要可以用 `bash completion`來減少時間
- 使用之前會先備份原本的 bashrc
- AWS-CLI 的自動完成不是很直覺, 難用死了也不改一改,白癡!

```shell
cp ~/.bashrc ~/.bashrc.backup
echo 'source <(kubectl completion bash)' >> ~/.bashrc
echo 'source <(helm completion bash)' >> ~/.bashrc
echo 'export KUBECONFIG=$KUBECONFIG:~/.kube/config' >> ~/.bashrc
complete -C '/home/ubuntu/.local/bin/aws_completer' aws
source ~/.bashrc
```

## EKS大致上的步驟
加入cloudformation worker node 啟動後,加入節點進剛剛建立好的 EKS platform

SG 預先於 EC2 介面先建立,未來要調整也比較方便,懶人法可以先全開免得測試又出現一堆問題

```txt
EKS-Master 只要允許 TCP 443即可
EKS-Node 按照 cloudformation 會建立獨立的 SG 但也先建立好備用
```

### 取得 編輯 套用 kubeconfig
從官方取得kubeconfig並設定好
`export KUBECONFIG=$KUBECONFIG:~/.kube/config-"cluster-name"`
cluster name 換成 EKS platform名稱,其實沒換也沒差,只要能呼叫到即可
可用 `kubectl config view` 看設定值有沒有正確傳入


### 取得 編輯 套用 aws-auth-cm.yaml
按照官方說明取得加入節點的 yaml 文件
這邊會直接再多建立一個 IAM 並賦予此 USER 的金鑰擁有 EKS-admin 權限
預設起cluster的人擁有最大權限,此步驟可以再增加多餘的管理者進入cluster
權限就可以用 IAM 去管理

編輯完成後套用到叢集 `kubectl apply -f aws-auth-cm.yaml`
等幾分鐘用 cloudformation 建立的節點應該會加入
用 `kubectl get svc,no` 查看

