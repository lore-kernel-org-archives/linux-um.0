Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F42C4345F
	for <linux-um@archiver.kernel.org>; Mon, 15 Apr 2024 13:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IgtY6P0/VUZ5ybOHoy7cdx/X8BD2OKG8M8Nz4l3BUUA=; b=uAGGUbNpgjkwbNHCFaV+j/UGvb
	WnPXyyXdmZwSHCC6YZr+VCrSRSSt4eNjGucbiU7cmKXBRsz6C6YVI8DYxctFVCA1YQux8Ek4PWdQK
	o4eHheBdduUdgMNWUp6JVxej6AtR3vaGfUsSWrhGd93UNs98Gs1oucGXvg5fkDsNjD0P0WKWr5BIb
	eS54EHO4Zyzliyuci7XucC1bmU+/Cm/w9/ll7Aji6ZbCJMJpJEH8lVj7pFFHfkvut7AKS9wVKuDga
	QBoz68T6oGmgjIMwQ4k7Rg+0WtCL2/uPejowJQhubQoynFxdR3KriSWVKjuLD8vY6C0dPfJykXIKf
	A551w3rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwMXT-00000008W7V-3tzh;
	Mon, 15 Apr 2024 13:38:27 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwMXN-00000008W4y-2IQU
	for linux-um@lists.infradead.org;
	Mon, 15 Apr 2024 13:38:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D0A4FCE0BA1;
	Mon, 15 Apr 2024 13:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFA3C113CC;
	Mon, 15 Apr 2024 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188299;
	bh=lvCjzgnykqyNnw5Vrwmo08lX30HbVWMQg86MwppAylM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvkwA1bE2x3jDXNNfuCGOPl1XXKgZjFhv6cJH8W3E7tVXbCbjKi3OZubmi9p3JECP
	 wfzEWQmTrerZN5uaXNmVypXHHhyrDoqU0HBK4BwApcDtRKFkvyX70EJn51hsMUCafv
	 dRPzByQW0/OaTYPnEyx96F949lJ024eL20D1b48HXiOKSN/daNrgXFx0pgZH9LfKPB
	 +2o3FLYJJb4BlpYFwgDwxUlZLAuQrP3UF723Rh3NoO8kTJB2aDP348v4aepH3/FCo/
	 N4/U/VuHVPvzR+tZCOQZAi0N2rnm+EWmvyiuIZYd2I/uWn5J2FXp8GwjUebv2u/bLy
	 pUjGAkHM+z7Jg==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Stable <stable@vger.kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 007/190] IMA: allow/fix UML builds
Date: Mon, 15 Apr 2024 06:48:57 -0400
Message-ID: <20240415105208.3137874-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_063821_789663_83A22941 
X-CRM114-Status: GOOD (  10.87  )
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

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 644f17412f5acf01a19af9d04a921937a2bc86c6 ]

UML supports HAS_IOMEM since 0bbadafdc49d (um: allow disabling
NO_IOMEM).

Current IMA build on UML fails on allmodconfig (with TCG_TPM=m):

ld: security/integrity/ima/ima_queue.o: in function `ima_add_template_entry':
ima_queue.c:(.text+0x2d9): undefined reference to `tpm_pcr_extend'
ld: security/integrity/ima/ima_init.o: in function `ima_init':
ima_init.c:(.init.text+0x43f): undefined reference to `tpm_default_chip'
ld: security/integrity/ima/ima_crypto.o: in function `ima_calc_boot_aggregate_tfm':
ima_crypto.c:(.text+0x1044): undefined reference to `tpm_pcr_read'
ld: ima_crypto.c:(.text+0x10d8): undefined reference to `tpm_pcr_read'

Modify the IMA Kconfig entry so that it selects TCG_TPM if HAS_IOMEM
is set, regardless of the UML Kconfig setting.
This updates TCG_TPM from =m to =y and fixes the linker errors.

Fixes: f4a0391dfa91 ("ima: fix Kconfig dependencies")
Cc: Stable <stable@vger.kernel.org> # v5.14+
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 6a8f67714c831..a8bf67557eb54 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -8,7 +8,7 @@ config IMA
 	select CRYPTO_MD5
 	select CRYPTO_SHA1
 	select CRYPTO_HASH_INFO
-	select TCG_TPM if HAS_IOMEM && !UML
+	select TCG_TPM if HAS_IOMEM
 	select TCG_TIS if TCG_TPM && X86
 	select TCG_CRB if TCG_TPM && ACPI
 	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
-- 
2.43.0


