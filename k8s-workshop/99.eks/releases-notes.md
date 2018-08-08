
### kubectl  

取得最新版kubectl  

```bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
```

### kubernetes-sigs/aws-iam-authenticator  
`https://github.com/kubernetes-sigs/aws-iam-authenticator/releases`

### kubernetes/kops  
`https://github.com/kubernetes/kops/releases`

### Helm
`https://github.com/helm/helm/releases`

### eks的issue
無法使用metric-server或取監測主機的資料  
https://serverfault.com/questions/917831/horizontalpodautoscaling-on-amazon-eks/918535  
發Ticket問官方也證實了某些第三方的API無法使用，只說未來會改，並把測試結果提交+1而已  
什麼時候會正常也不知道  


