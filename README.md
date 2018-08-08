## AWS-EKS 使用 AWS Cloud 9 做為終端

### 準備工作  
- ***登入者需具備AWS Admin / ROOT 權限，以便進行測試***
- ***假設登入使用者為abc , 需在此使用者的IAM之下產生AccessKey***
- ***AccessKey非常重要，測試完畢後務必刪除!!!!**
- 設定aws configure為上述的AccessKey
- 測試一下是否可以使用aws cli , `aws s3 ls`

#### Cloud9的準備
1.  Cloud9 登入後，透過`c9-first-lab-ide-build.sh`初始化環境
2.  關閉cloud9自帶的temp credential 
3.  取得教材 `git clone https://github.com/ckmates/k8s-workshop`

### 建立 EKS cluster
#### EKS的準備
1.  建立IAM ROLE 分配 EKS 
2.  建立SecurityGroup , 名稱 EKS-Master 僅允許tcp 443 即可
3.  依照畫面指示輸入cluster name等必要欄位，建立EKS過程約十分鐘
4.  將畫面上的`API server endpoint` 與 `Certificate authority`記下備用
5.  等EKS 介面顯示`ACTIVE`完成AWS端準備工作

#### 設定kubeconfig
1.  mkdir ~/.kube
2.  將kubeconfig複製到~/.kube/config
3.  設定環境變數 `export KUBECONFIG=$KUBECONFIG:~/.kube/config-"cluster-name"`
4.  修改kubeconfig 的 cluster 欄位修改完存檔離開

```text
server: <從EKS取得的API Endpoint>
certificate-authority-data : <從EKS取得的Certificate >
```  

5.  可用 `kubectl config view` 看設定值有沒有正確傳入  
6.  kubectl get svc 測試是否可以呼叫到EKS

```text
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.100.0.1   <none>        443/TCP   7h
```

#### 使用cloudformation建立NODE
1.  將檔案傳到cloudformation 依序填入cloudformation出現的欄位
2.  機器類型已經改為t2.medium spot instances
3.  開完機器約10分鐘左右，最後取得outputs的 value
4.  修改aws-auth-cm.yaml的內容
5.  只要調整`- rolearn: <ARN of instance role (not instance profile)>`  
將之取代為cloudformation outputs value即可

6.  最後使用`kubectl apply -f aws-auth-cm.yaml` 讓EKS將NODE加入叢集內
7.  等候一分鐘後，使用 `kubectl get nodes`，應可正確取得目前的NODE狀態

```text
NAME                                         STATUS    ROLES     AGE       VERSION
ip-172-31-1-30.us-west-2.compute.internal    Ready     <none>    3h        v1.10.3
ip-172-31-20-21.us-west-2.compute.internal   Ready     <none>    3h        v1.10.3
ip-172-31-42-29.us-west-2.compute.internal   Ready     <none>    3h        v1.10.3
```
