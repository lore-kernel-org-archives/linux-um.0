Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7949C7EE2C
	for <linux-um@archiver.kernel.org>; Thu, 24 Aug 2023 17:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KIWLg4N8k2TNjiWOoMDhILThGLpuhFgW4Ekx3KpToF0=; b=mcKk7eua0FqQOE
	5PfZOwn+rONSZwCSArfVIqOm19Ob1FIbmbVUhrBs2sd9/cgUeZasmjNM+y+ihnpkOBUOsVfLFcaJi
	jyZXVt8HRtzCtUk/QVMvCqXSZ97VqzeD/1G6ga6IarA3/B7VMLfUwmvULjQfLNlfiaQWVDBaYP0Zt
	n0Ah6mxDLrvVx+ZV7uWhbi0foWMYRLNKK69C8pJ1J9Sg+opGAb2AKj11SKTPg4P/lW+9MV+8aXJOU
	CTZcKmzwWUfGf0q9MGy433tbDGL0HFz3flYWCEUlLfEaaMsaa3yiR4+TnoqoqIxTCpHo8p0MF3g/V
	W0qnKbbkrt46MBgz2+Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZDxY-003WKp-23;
	Thu, 24 Aug 2023 17:17:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZDxV-003WJj-0B
	for linux-um@lists.infradead.org;
	Thu, 24 Aug 2023 17:17:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8AF5C63C3A;
	Thu, 24 Aug 2023 17:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFCCC433C9;
	Thu, 24 Aug 2023 17:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1692897444;
	bh=aYOpe/rPHGFBvBbxio/7eNWaSCQhMdQh1IoB4k7V+bE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FdaIFgql4dxGb5eNZ9N92iIzPCUIgB5C1rpXzUVm3pWZ5d6qHzS4gLs37+Jb+mBDP
	 AnNE2GOT9QnbZEXUyJoRfqar9lSsgfeqXguJHbMZEUcCH8p4MIegoa69RHkFACefFf
	 zBN+E0HMOvOVhkd5rzuYQFVVQk9Y780e/a8sJW8c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 041/135] IMA: allow/fix UML builds
Date: Thu, 24 Aug 2023 19:08:33 +0200
Message-ID: <20230824170618.923723875@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_101725_154411_6E79D79A 
X-CRM114-Status: GOOD (  13.59  )
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 755af0b29e755..0a5ae1e8da47a 100644
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
-- 
2.40.1




_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
