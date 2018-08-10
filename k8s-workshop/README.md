# AWS-EKS建置流程 (使用AWS Cloud9做為IDE環境)

## 準備工作  
- **準備AWS Admin / ROOT 權限的帳戶**
- **不要使用公司帳戶或正式環境的AWS帳戶來測試**
- **假設登入AWS帳戶的使用者為abc , 需在該使用者的IAM產生AccessKey**
- **AccessKey測試完畢後務必刪除**

### Cloud9的初始化設定
1.  Cloud9 開啟後，於終端機貼入指令: `git clone https://github.com/ckmates/k8s-workshop.git`
2.  進入`0.cloud9-install`資料夾，執行`c9-lab-ide-build.sh`，執行完畢後請登出 (CTRL+D)並重新開另一個終端機視窗 (ALT+T)
3.  設定`aws cli`  

```shell
     $ aws configure
     AWS Access Key ID [ ***YOUR ID*** ]: 
     AWS Secret Access Key [ ***YOUR KEY*** ]: 
     Default region name [us-west-2]:
     Default output format [None]:
```
4.  設定完畢後，測試一下是否可以使用aws cli , `aws s3 ls`


### Cloud9的其它設定
-  關閉Cloud9自帶的Temp Credential  ![image](k8s-workshop/img/snap_1.png)  
-  調整文字大小顏色，以個人舒適為主

## 建立 EKS Cluster
### EKS部份
1.  建立IAM ROLE並賦予EKS權限
2.  建立IAM Policy參考: `https://docs.aws.amazon.com/zh_tw/eks/latest/userguide/EKS_IAM_user_policies.html`
3.  建立SecurityGroup , 名稱 EKS-Master 僅允許https 443即可  
4.  建立SSH key
5.  切換到EKS功能，並開始建立Cluster , 依照順序輸入必要欄位，過程 ~10min
6.  將畫面上的`API server endpoint` 與 `Certificate authority`記下備用
7.  等EKS 介面顯示`ACTIVE`完成EKS準備工作

### 設定kubeconfig
1.  在Cloud9初始化的時候已將空白設定複製到/home/ec2-user/.kube/config
2.  直接使用Cloud9來編輯檔案或使用`vim /home/ec2-user/.kube/config`

找到`server , certificate-authority-data , args欄位`修改成個人的設定  
其它欄位不要修改

```text
server: <從EKS取得的API Endpoint 要帶https://>
certificate-authority-data : <從EKS取得的Certificate ，不要斷行 >

args:
  - "token"
  - "-i"
  - "<建立EKS時的名稱>"
```  

5.  存檔後在終端機介面輸入 `kubectl config view` 看設定值有沒有正確傳入  
6.  kubectl get svc 測試是否呼叫到EKS，如沒有問題應該會出現類似以下的訊息:

```text
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.100.0.1   <none>        443/TCP   7h
```

## 使用Cloudformation加入Node  

1.  從Cloud9左側的欄位中找到`2.add-node`資料夾
2.  選擇`eks-nodegroup-v2.yaml`按下右建選擇Download到你的電腦桌面
3.  回到AWS，選擇Cloudformation > `Upload a template to Amazon S3`，  
選擇`eks-nodegroup-v2.yaml`上傳
4.  依序填入相關欄位
5.  機器類型預設是 `t2.medium , Spot Instances`
6.  完成後會開始建立Node ~10min，最後取得Outputs的 Value
7.  修改aws-auth-cm.yaml的內容，此檔案位於`/home/ec2-user/.kube/`  
修改方式與kubeconfig相同
8.  只要調整`- rolearn: <ARN of instance role (not instance profile)>`  
將之取代為cloudformation outputs value即可
9.  在此目錄下`/home/ec2-user/.kube/`使用`kubectl apply -f aws-auth-cm.yaml` 讓EKS將Node加入
10. 幾秒後，使用 `kubectl get nodes`，應可取得Node , 狀態Ready即完成建置

```text
NAME                                         STATUS    ROLES     AGE       VERSION
ip-172-31-1-30.us-west-2.compute.internal    Ready     <none>    3h        v1.10.3
ip-172-31-20-21.us-west-2.compute.internal   Ready     <none>    3h        v1.10.3
ip-172-31-42-29.us-west-2.compute.internal   Ready     <none>    3h        v1.10.3
```

11.  至此已完成Cloud9 與 EKS 的建置工作

<!-- ![image](https://github.com/raydigitallife/c9-eks/blob/master/snap_1.png) -->
