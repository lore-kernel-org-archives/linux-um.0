Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67891C636D4
	for <linux-um@archiver.kernel.org>; Wed, 15 Feb 2023 05:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xzr4xyMk40Ix77YcSg0DS91W+EOc9Fsk5I/w4WceplI=; b=YXl3Uz/KqJ+HiL
	FGDX98Je/FTO3975qTAWZLMfh0wnviQIW5ctnwFW2dq0buV2xBGxwStAmRMP604jh64JhjoWBC8ci
	GwCFw+g8h8K5Ve76GJnd+RjgHMsSVrEnK0VVyMX76bUQbOeNBnqA58WWXLJl7vxUhxaV6XPSqnWpR
	08TT1WPaweHXH15mDRzqXHRsEGtg4eSpyS8BJU9tnJg0+Dy0ojBvgMf/Oofu8b8eG8YJuoQJf+C9+
	kzNBnNcC5BpPIzDLa7jqXAN3Kay5Uem+mokL7nZt0Jvrlb6YVwNJ9b+uyAJNWEeTPjRQrPs1PrlBM
	yI9aMJj1c9Ztjq3xBXKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSAT5-004nT0-Sp; Wed, 15 Feb 2023 05:36:35 +0000
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSAT2-004nSX-U1
	for linux-um@lists.infradead.org; Wed, 15 Feb 2023 05:36:34 +0000
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F0FutM025508;
	Wed, 15 Feb 2023 05:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eMsxikA2FKWM0cAyyuNKptymaSt/npyL9FJnQ+uOQSc=;
 b=FxV3qwIoK5wvwqTwdtx7P/Xe30YZTQUDQ3mDE7kvtyKG9/DvuUhxiQvsmPFBrQVhA80l
 pBrlyPw0yLyyNGvZQiKVPJcZldKd/WKNvlsT7Exo6+iqLrZsekfrishLhD72Dccb5MD/
 /Suy/Ny1G8GO1FykHApHU9azG2cNoH8DurHJ/v6wMLoO6wB0y10B2B1rXWMUCIuH/8Mz
 eov1w0tlxE/dralzhJYIGSokDo5dkkE5DjUHFQT63LV2lw5K3nYaLldH9ZNfCAPpVDGk
 tVrnQkPEHSjhFBuhgPIVBJn7AnogKtCnco+JJGCvN/oQmL5Hhvvk+J8ZbmKWMKIKNXoU cw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nrhx3s0vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Feb 2023 05:36:26 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31F5aQCx028070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Feb 2023 05:36:26 GMT
Received: from [10.213.73.166] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 21:36:24 -0800
Message-ID: <913fea79-09f9-b976-ff1a-cd833784abb6@quicinc.com>
Date: Wed, 15 Feb 2023 11:05:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V1] um: Fix compilation warnings
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>
CC: anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1676410243-10566-1-git-send-email-quic_c_spathi@quicinc.com>
 <1950127775.130646.1676411821807.JavaMail.zimbra@nod.at>
From: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
In-Reply-To: <1950127775.130646.1676411821807.JavaMail.zimbra@nod.at>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _xvosdkay_gpVVwM-dww_kVZiKxqBlj1
X-Proofpoint-GUID: _xvosdkay_gpVVwM-dww_kVZiKxqBlj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_02,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 suspectscore=0 mlxlogscore=677 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150049
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_213632_994273_F818817A 
X-CRM114-Status: GOOD (  11.92  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Ck9uIDIvMTUvMjAyMyAzOjI3IEFNLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4gLS0tLS0g
VXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+PiBWb246ICJTcmluaXZhc2FyYW8gUGF0aGlwYXRp
IiA8cXVpY19jX3NwYXRoaUBxdWljaW5jLmNvbT4KPj4gc3RhdGljIHZvaWQgc2lnX2hhbmRsZXJf
Y29tbW9uKGludCBzaWcsIHN0cnVjdCBzaWdpbmZvICpzaSwgbWNvbnRleHRfdCAqbWMpCj4+IHsK
Pj4gLQlzdHJ1Y3QgdW1sX3B0X3JlZ3MgcjsKPj4gKwlzdHJ1Y3QgdW1sX3B0X3JlZ3MgKnI7Cj4+
IAlpbnQgc2F2ZV9lcnJubyA9IGVycm5vOwo+Pgo+PiAtCXIuaXNfdXNlciA9IDA7Cj4+ICsJciA9
IG1hbGxvYyhzaXplb2Yoc3RydWN0IHVtbF9wdF9yZWdzKSk7Cj4gSSBmZWFyIHRoaXMgaXMgbm90
IGNvcnJlY3Qgc2luY2UgbWFsbG9jKCkgaXMgbm90IGFzeW5jLXNpZ25hbCBzYWZlLgoKVGhhbmtz
IFJpY2hhcmQgZm9yIHF1aWNrIHJlc3BvbnNlLiBDb3VsZCB5b3UgcGxlYXNlIHN1Z2dlc3QgYWx0
ZXJuYXRpdmUgCmZ1bmN0aW9uIG9mIG1hbGxvYygpIHdpdGggYXN5bmMtc2lnbmFsIHNhZmUuCgpp
ZiB0aGF0IGlzIG5vdCBwb3NzaWJsZSBJcyB0aGVyZSBhbnkgb3RoZXIgd2F5IHRvIGZpeCB0aGlz
IHdhcm5pbmc/IE9SIApkbyB3ZSBuZWVkIHRvIGxpdmUgd2l0aCB0aGF0IHdhcm5pbmc/Cgo+Cj4g
VGhhbmtzLAo+IC8vcmljaGFyZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11
bQo=
