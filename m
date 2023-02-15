Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A60C636D4
	for <linux-um@archiver.kernel.org>; Wed, 15 Feb 2023 08:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ThnnocyBuYSd5NoHFQN7/en36kR9EnKrVZz6dOmZV7A=; b=uD+bjukyTyATFy
	3viPnT30WyDBVmtb87dqBZ0DKTgXNymXpscn+wuL4m0NUdiXmmuddjr+ipyOFZu6fwyVVDHe+39FW
	1x6pmzAqaY8oNcpYOru8w1ANjX+UYIKdbyqzuWdvTpaKrpXL1D4X6hu76EEgbntyFqGqM/p+M1TfT
	2msUMiZcS/5O1RLm8rigEOaudjx3xDbisCtZ55BUFuJHbLDezcrQ/MEyPH5goUwWAzTWA3Yoj1qxX
	9lcI2rQmq7SOam1Dsmh1JDzDLsKI+enopAHm2fn/NT400HWVePbYlA319AqO3DKbxZFTxZq3Hjw2y
	91kqM9fDBQw0UZwm3oLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSCwM-0059aa-Di; Wed, 15 Feb 2023 08:14:58 +0000
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSCwJ-0059YT-7F
	for linux-um@lists.infradead.org; Wed, 15 Feb 2023 08:14:56 +0000
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F6EJWo023028;
	Wed, 15 Feb 2023 08:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+wPUXjC3Udfj3F/o0omCJqKZy0EOSOZMXFFX6GyxQtA=;
 b=M4R7vi30D1LqYOTxnSVH32c9f1pC6x5HRkYtnsvQRkCXm3faGw+64M28+BkM06pOHw50
 CdV75Zb49EsyHb4r3WIDij2/pgJzqYISlNn30AJ6t5UdiUQKT1QrQgr5OzN+He97Ly1H
 UPmw8F0u5VzIDMRjRiLwEBIDXkLomKSN0QcK1Q2Gw/69+5NwTZidrAJF/kgC9zQgxs0W
 LXB7CPIpJ+NNSEmt444LtlvQ6rj39uVJ+UbcbrR9KmT1qpcAVxu+VeJpISP0eGp8oWGL
 M32f3X/Wyd34vLvve+jBPeWyi1iYKGxakKBYu0hofPhbW1Rm8uOOVCNxEWPFZvab8eGZ Iw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nrprs0r3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Feb 2023 08:14:48 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31F8ElrM020504
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Feb 2023 08:14:47 GMT
Received: from [10.213.73.166] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 15 Feb
 2023 00:14:45 -0800
Message-ID: <9f224c54-ce6b-ad8f-3716-f23c4b6f803c@quicinc.com>
Date: Wed, 15 Feb 2023 13:44:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V1] um: Fix compilation warnings
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Richard Weinberger <richard@nod.at>,
        anton ivanov
	<anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel
	<linux-kernel@vger.kernel.org>
References: <1676410243-10566-1-git-send-email-quic_c_spathi@quicinc.com>
 <1950127775.130646.1676411821807.JavaMail.zimbra@nod.at>
 <913fea79-09f9-b976-ff1a-cd833784abb6@quicinc.com>
 <CAMuHMdUb9cduEae2vzX8LeVG7z0nRrKHrQN6UGJ_YLuWOBbKOg@mail.gmail.com>
From: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
In-Reply-To: <CAMuHMdUb9cduEae2vzX8LeVG7z0nRrKHrQN6UGJ_YLuWOBbKOg@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: omP47rjqb4GLmIn4powJRosGOfeT2qyZ
X-Proofpoint-ORIG-GUID: omP47rjqb4GLmIn4powJRosGOfeT2qyZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_04,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=937
 clxscore=1011 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_001455_308809_76EAE090 
X-CRM114-Status: GOOD (  19.13  )
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

SGkgR3JlZXJ0IFV5dHRlcmhvZXZlbiwKCk9uIDIvMTUvMjAyMyAxOjM3IFBNLCBHZWVydCBVeXR0
ZXJob2V2ZW4gd3JvdGU6Cj4gSGkgU3Jpbml2YXNhcmFvLAo+Cj4gT24gV2VkLCBGZWIgMTUsIDIw
MjMgYXQgNjozNiBBTSBTcmluaXZhc2FyYW8gUGF0aGlwYXRpCj4gPHF1aWNfY19zcGF0aGlAcXVp
Y2luYy5jb20+IHdyb3RlOgo+PiBPbiAyLzE1LzIwMjMgMzoyNyBBTSwgUmljaGFyZCBXZWluYmVy
Z2VyIHdyb3RlOgo+Pj4gLS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+Pj4+IFZvbjog
IlNyaW5pdmFzYXJhbyBQYXRoaXBhdGkiIDxxdWljX2Nfc3BhdGhpQHF1aWNpbmMuY29tPgo+Pj4+
IHN0YXRpYyB2b2lkIHNpZ19oYW5kbGVyX2NvbW1vbihpbnQgc2lnLCBzdHJ1Y3Qgc2lnaW5mbyAq
c2ksIG1jb250ZXh0X3QgKm1jKQo+Pj4+IHsKPj4+PiAtICAgIHN0cnVjdCB1bWxfcHRfcmVncyBy
Owo+Pj4+ICsgICAgc3RydWN0IHVtbF9wdF9yZWdzICpyOwo+Pj4+ICAgICAgIGludCBzYXZlX2Vy
cm5vID0gZXJybm87Cj4+Pj4KPj4+PiAtICAgIHIuaXNfdXNlciA9IDA7Cj4+Pj4gKyAgICByID0g
bWFsbG9jKHNpemVvZihzdHJ1Y3QgdW1sX3B0X3JlZ3MpKTsKPj4+IEkgZmVhciB0aGlzIGlzIG5v
dCBjb3JyZWN0IHNpbmNlIG1hbGxvYygpIGlzIG5vdCBhc3luYy1zaWduYWwgc2FmZS4KPj4gVGhh
bmtzIFJpY2hhcmQgZm9yIHF1aWNrIHJlc3BvbnNlLiBDb3VsZCB5b3UgcGxlYXNlIHN1Z2dlc3Qg
YWx0ZXJuYXRpdmUKPj4gZnVuY3Rpb24gb2YgbWFsbG9jKCkgd2l0aCBhc3luYy1zaWduYWwgc2Fm
ZS4KPj4KPj4gaWYgdGhhdCBpcyBub3QgcG9zc2libGUgSXMgdGhlcmUgYW55IG90aGVyIHdheSB0
byBmaXggdGhpcyB3YXJuaW5nPyBPUgo+PiBkbyB3ZSBuZWVkIHRvIGxpdmUgd2l0aCB0aGF0IHdh
cm5pbmc/Cj4gRG9lcyB0aGlzIGxpbWl0IGFjdHVhbGx5IGFwcGx5IHRvIHRoaXMgZmlsZSwgd2hp
Y2ggY2FsbHMgaW50byB0aGUgaG9zdCBPUz8KPgo+IEhvdyBjb21lIHlvdSBldmVuIHNlZSB0aGlz
IHdhcm5pbmcsIGFzIHdlIGhhdmUKPgo+ICAgICAgQ0ZMQUdTX3NpZ25hbC5vICs9IC1XZnJhbWUt
bGFyZ2VyLXRoYW49NDA5Ngo+Cj4gc2luY2UgY29tbWl0IDUxN2Y2MDIwNmVlNWQ1ZjcgKCJ1bTog
SW5jcmVhc2Ugc3RhY2sgZnJhbWUgc2l6ZSB0aHJlc2hvbGQKPiBmb3Igc2lnbmFsLmMiKSBpbiB2
NS4xMT8KPgo+IEdye29ldGplLGVldGluZ31zLAo+Cj4gICAgICAgICAgICAgICAgICAgICAgICAg
IEdlZXJ0CgpXZSB3ZXJlIHRlc3RpbmcgdGhpcyBvbiA1LjEwIGtlcm5lbC4KCldlIHdpbGwgYmFj
ayBwb3J0IHRoaXMgY2hhbmdlLgoKVGhhbmtzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC11bQo=
