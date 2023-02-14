Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DB7C05027
	for <linux-um@archiver.kernel.org>; Tue, 14 Feb 2023 21:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HWZgj903x/vN171Y4ezzG1IrTcRu7h8XP7yadKHnkB8=; b=3DBfic8tI8qq5M
	BPx3krqUOcjh6xhOKtxwl8Hmoi90WvlDilL6M+Gbf64nIIBOE5wVXCEK5dG+GBvaFi72JRYe2eUpg
	gn7BcAKfAzVJ9mMCnUhZ8rLjbPanyibMMEynTWZciXx9Czajt0k9ZzX7YjENlOnnF8F+JwXIDwL4C
	Wi2650lHI5jS9MtQ8ntvl+nxYW5ACNtBBBrCp7USLZhK/t0FS0+x2fVq0MOdJ+Rsm7LiDYzrcNOZE
	MpLyR4cUdr4LFxq1AajdCfmyMgrlsyvs4QRox2iHPgsl5Vh64cJ/fdFN7vHljhMAEthMU2csqJsoY
	8w46B5hJMnxp64WcP8+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS32v-003d50-Jr; Tue, 14 Feb 2023 21:41:05 +0000
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS2tn-003ZNK-36
	for linux-um@lists.infradead.org; Tue, 14 Feb 2023 21:31:44 +0000
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EHLlIk027227;
	Tue, 14 Feb 2023 21:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=jdadcMHUEHEz3wESNyYCqEqZE1xiSFm7gjLwEXCHUq4=;
 b=onAw/Ed1Rds4wArHiFBeJntOEqNg5p3PqBvyUh6+M+MtRv8Jh0kvC6waD+qY2BBAZDjJ
 JfNSKdQQEJjFmMbGFa0EBbVuhLAH0HMdSLl9GyYd3gjazEZ9b78V/qfeoHvNKf2IkN07
 P0eJM9p3sh7SSA9wtmqR0NDpqDxIcv6Xg68ANEzv6ky4vcLjJLNnOQ7r0wjS4OSNO+WT
 SREsyWc3lilplPKQEEe8D+Ncz2Ba4oSoCTTopsz/P47twra/NfFNrKAYMJP9t6FadVId
 hOp5/0eZ3AfjHx+EHRQjszmcLGEQp1bQ1IPlAucGlIrwcIsw0SfcaSTWBLi6U/CvKE4t 3Q== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqyygtu5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Feb 2023 21:31:32 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31ELVRmY013297;
	Tue, 14 Feb 2023 21:31:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3np43kjtbk-1;
	Tue, 14 Feb 2023 21:31:27 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31ELVRKm013292;
	Tue, 14 Feb 2023 21:31:27 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-c-spathi-hyd.qualcomm.com [10.213.108.59])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 31ELVQ2F013291;
	Tue, 14 Feb 2023 21:31:26 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 212714)
	id 1DA434801; Wed, 15 Feb 2023 03:01:26 +0530 (+0530)
From: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        quic_c_spathi@quicinc.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V1] um: Fix compilation warnings
Date: Wed, 15 Feb 2023 03:00:43 +0530
Message-Id: <1676410243-10566-1-git-send-email-quic_c_spathi@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: o9J2jh1-t8dYIgz2zYsGdSgbsy5oOMaz
X-Proofpoint-GUID: o9J2jh1-t8dYIgz2zYsGdSgbsy5oOMaz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=360 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140184
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_133139_212956_238122B0 
X-CRM114-Status: GOOD (  16.91  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

VXNlIGR5bmFtaWMgYWxsb2NhdGlvbiBpbiBzaWdfaGFuZGxlcl9jb21tb24oKSBhbmQgaW4KdGlt
ZXJfcmVhbF9hbGFybV9oYW5kbGVyKCkgdG8gZml4IGJlbG93IHdhcm5pbmdzIGFuZCBidWlsZApm
YWlsdXJlcyB3aGVyZSBDT05GSUdfV0VSUk9SIGlzIGVuYWJsZWQuCgphcmNoL3VtL29zLUxpbnV4
L3NpZ25hbC5jOiBJbiBmdW5jdGlvbiDigJhzaWdfaGFuZGxlcl9jb21tb27igJk6CmFyY2gvdW0v
b3MtTGludXgvc2lnbmFsLmM6NTE6MTogZXJyb3I6IHRoZSBmcmFtZSBzaXplIG9mIDI5NjAgYnl0
ZXMgaXMgbGFyZ2VyIHRoYW4gMTAyNCBieXRlcyBbLVdlcnJvcj1mcmFtZS1sYXJnZXItdGhhbj1d
CiB9CiBeCmFyY2gvdW0vb3MtTGludXgvc2lnbmFsLmM6IEluIGZ1bmN0aW9uIOKAmHRpbWVyX3Jl
YWxfYWxhcm1faGFuZGxlcuKAmToKYXJjaC91bS9vcy1MaW51eC9zaWduYWwuYzo5NToxOiBlcnJv
cjogdGhlIGZyYW1lIHNpemUgb2YgMjk2MCBieXRlcyBpcyBsYXJnZXIgdGhhbiAxMDI0IGJ5dGVz
IFstV2Vycm9yPWZyYW1lLWxhcmdlci10aGFuPV0KIH0KClNpZ25lZC1vZmYtYnk6IFNyaW5pdmFz
YXJhbyBQYXRoaXBhdGkgPHF1aWNfY19zcGF0aGlAcXVpY2luYy5jb20+Ci0tLQogYXJjaC91bS9v
cy1MaW51eC9zaWduYWwuYyB8IDIyICsrKysrKysrKysrKystLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCAxMyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gv
dW0vb3MtTGludXgvc2lnbmFsLmMgYi9hcmNoL3VtL29zLUxpbnV4L3NpZ25hbC5jCmluZGV4IDI0
YTQwM2EuLjlkZTg4MjYgMTAwNjQ0Ci0tLSBhL2FyY2gvdW0vb3MtTGludXgvc2lnbmFsLmMKKysr
IGIvYXJjaC91bS9vcy1MaW51eC9zaWduYWwuYwpAQCAtMzIsMjMgKzMyLDI1IEBAIHZvaWQgKCpz
aWdfaW5mb1tOU0lHXSkoaW50LCBzdHJ1Y3Qgc2lnaW5mbyAqLCBzdHJ1Y3QgdW1sX3B0X3JlZ3Mg
KikgPSB7CiAKIHN0YXRpYyB2b2lkIHNpZ19oYW5kbGVyX2NvbW1vbihpbnQgc2lnLCBzdHJ1Y3Qg
c2lnaW5mbyAqc2ksIG1jb250ZXh0X3QgKm1jKQogewotCXN0cnVjdCB1bWxfcHRfcmVncyByOwor
CXN0cnVjdCB1bWxfcHRfcmVncyAqcjsKIAlpbnQgc2F2ZV9lcnJubyA9IGVycm5vOwogCi0Jci5p
c191c2VyID0gMDsKKwlyID0gbWFsbG9jKHNpemVvZihzdHJ1Y3QgdW1sX3B0X3JlZ3MpKTsKKwly
LT5pc191c2VyID0gMDsKIAlpZiAoc2lnID09IFNJR1NFR1YpIHsKIAkJLyogRm9yIHNlZ2ZhdWx0
cywgd2Ugd2FudCB0aGUgZGF0YSBmcm9tIHRoZSBzaWdjb250ZXh0LiAqLwotCQlnZXRfcmVnc19m
cm9tX21jKCZyLCBtYyk7Ci0JCUdFVF9GQVVMVElORk9fRlJPTV9NQyhyLmZhdWx0aW5mbywgbWMp
OworCQlnZXRfcmVnc19mcm9tX21jKHIsIG1jKTsKKwkJR0VUX0ZBVUxUSU5GT19GUk9NX01DKHIt
PmZhdWx0aW5mbywgbWMpOwogCX0KIAogCS8qIGVuYWJsZSBzaWduYWxzIGlmIHNpZyBpc24ndCBJ
UlEgc2lnbmFsICovCiAJaWYgKChzaWcgIT0gU0lHSU8pICYmIChzaWcgIT0gU0lHV0lOQ0gpKQog
CQl1bmJsb2NrX3NpZ25hbHNfdHJhY2UoKTsKIAotCSgqc2lnX2luZm9bc2lnXSkoc2lnLCBzaSwg
JnIpOworCSgqc2lnX2luZm9bc2lnXSkoc2lnLCBzaSwgcik7CiAKIAllcnJubyA9IHNhdmVfZXJy
bm87CisJZnJlZShyKTsKIH0KIAogLyoKQEAgLTk5LDEzICsxMDEsMTUgQEAgdm9pZCBzaWdfaGFu
ZGxlcihpbnQgc2lnLCBzdHJ1Y3Qgc2lnaW5mbyAqc2ksIG1jb250ZXh0X3QgKm1jKQogCiBzdGF0
aWMgdm9pZCB0aW1lcl9yZWFsX2FsYXJtX2hhbmRsZXIobWNvbnRleHRfdCAqbWMpCiB7Ci0Jc3Ry
dWN0IHVtbF9wdF9yZWdzIHJlZ3M7CisJc3RydWN0IHVtbF9wdF9yZWdzICpyZWdzOwogCisJcmVn
cyA9IG1hbGxvYyhzaXplb2Yoc3RydWN0IHVtbF9wdF9yZWdzKSk7CiAJaWYgKG1jICE9IE5VTEwp
Ci0JCWdldF9yZWdzX2Zyb21fbWMoJnJlZ3MsIG1jKTsKKwkJZ2V0X3JlZ3NfZnJvbV9tYyhyZWdz
LCBtYyk7CiAJZWxzZQotCQltZW1zZXQoJnJlZ3MsIDAsIHNpemVvZihyZWdzKSk7Ci0JdGltZXJf
aGFuZGxlcihTSUdBTFJNLCBOVUxMLCAmcmVncyk7CisJCW1lbXNldChyZWdzLCAwLCBzaXplb2Yo
c3RydWN0IHVtbF9wdF9yZWdzKSk7CisJdGltZXJfaGFuZGxlcihTSUdBTFJNLCBOVUxMLCByZWdz
KTsKKwlmcmVlKHJlZ3MpOwogfQogCiB2b2lkIHRpbWVyX2FsYXJtX2hhbmRsZXIoaW50IHNpZywg
c3RydWN0IHNpZ2luZm8gKnVudXNlZF9zaSwgbWNvbnRleHRfdCAqbWMpCi0tIAoyLjcuNAoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1h
aWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
