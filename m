Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7AACD1292
	for <linux-um@archiver.kernel.org>; Wed,  3 Apr 2024 12:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3DCW58lhecvc9h39XcdmzUDvmZO0DYlk0Q396n3JT88=; b=bfiAG5CbqX3HEAitNiyyqTKbpA
	NHuqu692eRVmnYq2lwEj9ho2anWhzA532UIV3uSJ5xkiFBOLSeWU4aYpqsTGb/dF53Ldk7g0PTcDN
	zH6oj4xLR6zB7CWZBzJNd6S6rjfrw7uASdLlg3ElUE4H/mY0H9DDc3NNvz/sTYOiruzU3tb7zWwwY
	A1e9zlrKS5ZWNKLSIHQFcGnQsUWXIYnas9ZcbnOvJ0GmfqDISMeHvR6f8dp+dNpwMciV9uF2Ciiyu
	gshFhRiqVCLbyGNXnv3pcJcDPXqwgRzEYbKFuCYQnp2+gnX7CXXKqPrdFjU+/KHd63o/G9nDBUJOa
	JK77NbrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrzxd-0000000FzIJ-3cer;
	Wed, 03 Apr 2024 12:43:25 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrzxZ-0000000FzFg-0jst
	for linux-um@lists.infradead.org;
	Wed, 03 Apr 2024 12:43:23 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433BmCXf024743;
	Wed, 3 Apr 2024 12:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3DCW58lhecvc9h39XcdmzUDvmZO0DYlk0Q396n3JT88=;
 b=mo1At7HiA/m2VtIXEPmdRksxyyhjZ+35eSSqIxVJdkYYORQhisCTtqpnyBo+9otDcShI
 VCkdqNKG00mSBJD9TRozRfBCS2NVd05egyN+id761oPb2XNKRYs3FDfBuO/vYed4w5qf
 PHa1xv6hmnxCdJ8H+pgR9Guu0dvlqdpas3cZjglmyIjdbfUnWLGfMeKR3I0hVZaESNGO
 Zj1au0fR6706SVRe+t5ug8Jqumrd2fXnO9GfJw3kFjyt2nCBukplzWe4if2DhedXOrSw
 tU8GM1A6v/2xyAX9KEXmFxUrlNqe+CW+AMiBOjS4NvB2w3kbeCWt6D9A0KDAtz/w05HY mw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x96j2g48f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 12:43:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 433CN5EC002189;
	Wed, 3 Apr 2024 12:43:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6xjmn4bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 12:43:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433Ch2tW27984544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 12:43:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C7432004D;
	Wed,  3 Apr 2024 12:43:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 422462004F;
	Wed,  3 Apr 2024 12:43:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 12:43:02 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 1/1] um: Select HAS_IOREMAP for UML_IOMEM_EMULATION
Date: Wed,  3 Apr 2024 14:43:00 +0200
Message-Id: <20240403124300.65379-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240403124300.65379-1-schnelle@linux.ibm.com>
References: <20240403124300.65379-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6PYNeKu-ZMc15mWQZHr-qmzJtAUx0Eki
X-Proofpoint-ORIG-GUID: 6PYNeKu-ZMc15mWQZHr-qmzJtAUx0Eki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_10,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=796 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_054321_642753_BB4212D6 
X-CRM114-Status: GOOD (  14.97  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
compile time. UML supports these via its UML_IOMEM_EMULATION so let that
select HAS_IOPORT and also reflect this in NO_IOPORT_MAP.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/um/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 93a5a8999b07..758016731156 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -48,12 +48,13 @@ config NO_IOMEM
 config UML_IOMEM_EMULATION
 	bool
 	select INDIRECT_IOMEM
+	select HAS_IOPORT
 	select GENERIC_PCI_IOMAP
 	select GENERIC_IOMAP
 	select NO_GENERIC_PCI_IOPORT_MAP
 
 config NO_IOPORT_MAP
-	def_bool y
+	def_bool !UML_IOMEM_EMULATION
 
 config ISA
 	bool
-- 
2.40.1


