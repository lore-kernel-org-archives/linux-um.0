Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEDEC61DA4
	for <linux-um@archiver.kernel.org>; Fri, 24 Feb 2023 03:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Hfd8jsXXBv5M/ewLuH7BZ7VpIlK/q52kbohFm0iJnfA=; b=yKtdRKbEg6jMo2
	NtNXEBuz8lPZA/c+pLsiZD2TpHBP/gVmaFKrzL0pyfT9VvKd92aMkrTKM3FUwfzqiIocYS31qoX8x
	9vnov+poIZt/B6eA8zwhmbVaw1ZOqJasUh+R6ZsmBIWFpnW+Ax344+6KvArTlKdnVExSFj+Y9B3a2
	Mt/GK4Eukus82kurYP4dK40cHneUkHIyNv3VL3heC0jSBd1Iz4XJJi9it+bd8DsKyIxThUSxhgD0W
	ZLgilJl32thwDbL7UT6PUlT52AsrQR2g1AkNQdOJSdXD0n53YQ8kHDQmafFaUsSPHt2Byjg+FbwYZ
	TMiOffrE7Y3CxQE7mpQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVOjl-0014Kb-Vp; Fri, 24 Feb 2023 03:27:09 +0000
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVOji-0014K7-Fa; Fri, 24 Feb 2023 03:27:06 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	linux-integrity@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Rajiv Andrade <srajiv@linux.vnet.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH] IMA: allow/fix UML builds
Date: Thu, 23 Feb 2023 19:27:03 -0800
Message-Id: <20230224032703.7789-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

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
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Rajiv Andrade <srajiv@linux.vnet.ibm.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
---
 security/integrity/ima/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -8,7 +8,7 @@ config IMA
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
 	select CRYPTO_HASH_INFO
-	select TCG_TPM if HAS_IOMEM && !UML
+	select TCG_TPM if HAS_IOMEM
 	select TCG_TIS if TCG_TPM && X86
 	select TCG_CRB if TCG_TPM && ACPI
 	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
