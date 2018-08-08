# AWS-EKS+EC2開一個月價格參考

```txt
假設EKS使用於美西奧勒岡,eks platform=0.2/hour

t2.small	1	變數	2 GiB	僅 EBS	每小時 0.023 USD
t2.medium	2	變數	4 GiB	僅 EBS	每小時 0.0464 USD
t2.large	2	變數	8 GiB	僅 EBS	每小時 0.0928 USD
```

以最低規格計算

```txt
EKS 0.2x744=148.8
EC2 0.023x744x3=51.336
148.8+51.336=200.136, 
每個月約台幣6200元,還不算流量與EBS費用
真的很貴!!
```


網路上有人用SPOT加入叢集
理想的狀況是這樣沒錯，可以用來減少費用