Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3423C02183
	for <linux-um@archiver.kernel.org>; Mon, 13 Jan 2025 16:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HFXNeldDkGWtQVQ/tfJq9J/93pUAthD1bKWnJqq0KuA=; b=OYpLC+thD/TNFnEjqvGd84pMNf
	nsIFeJL27cQXyzYJ/3HU65CsW0fXQiVy6naAP55/e89C3VMJOdbL1uOhlVLqjXOpXqRDyruM3IX77
	muR5/CREEnFoBqrDfW6+2qoX941/te//8/PZvaf2d08aZFO2Vs/Uk6J/mxMW/aa6+y9pnMvNUOnAJ
	8tEJSQQPgq5xIzSpT9CQ0TB+1/CHXX41QGzHF5oqub6Ktjr5fNR32tDq2hFA+tkFgdcRkChGrVkSd
	jLbDlpVEkAghW4+r0bj7Se1xEcP+rE70/vtCfubl8kpEKM2zjp5GLK5uLSHd6REYpzrLQtEXcsEDA
	sHK2o43g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXMwK-00000005mV0-1B7n;
	Mon, 13 Jan 2025 16:05:20 +0000
Received: from out0-220.mail.aliyun.com ([140.205.0.220])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXMQh-00000005en9-0WMO
	for linux-um@lists.infradead.org;
	Mon, 13 Jan 2025 15:32:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1736782352; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=HFXNeldDkGWtQVQ/tfJq9J/93pUAthD1bKWnJqq0KuA=;
	b=AeKEt4634ygECqnKoE2r8Pbs4an58/JfYFdrMhlYNjkO5vNBYqnlrOwzoLqS+s/FRaJRY9khrpR1qI5AQfcKd+SP6cMQEs1HKP6EFN1KNpeP3Vlw75TLfJPqDTNBV0S/Cb4tDjkeHHLbejy9I0q1iVMk0HMUaszsLkHekEQHw2M=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.b1pVbjq_1736782350 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 13 Jan 2025 23:32:30 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>,
  "kernel test robot" <lkp@intel.com>
Subject: [PATCH 1/2] um: Include missing headers in asm/pgtable.h
Date: Mon, 13 Jan 2025 23:32:17 +0800
Message-Id: <20250113153218.3331321-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113153218.3331321-1-tiwei.btw@antgroup.com>
References: <20250113153218.3331321-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_073239_689604_55EFD9B4 
X-CRM114-Status: UNSURE (   5.31  )
X-CRM114-Notice: Please train this message.
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

Formerly, asm/pgtable.h relied on the implicit inclusion of asm/page.h
and linux/mm_types.h via asm/fixmap.h. With the removal of asm/fixmap.h,
these headers need to be included explicitly in asm/pgtable.h now.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501131814.E6CxjulL-lkp@intel.com/
Fixes: 5bfc4a3a0af3 ("um: Remove obsolete fixmap support")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/pgtable.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 9be6daca95be..5601ca98e8a6 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -8,6 +8,9 @@
 #ifndef __UM_PGTABLE_H
 #define __UM_PGTABLE_H
 
+#include <asm/page.h>
+#include <linux/mm_types.h>
+
 #define _PAGE_PRESENT	0x001
 #define _PAGE_NEEDSYNC	0x002
 #define _PAGE_RW	0x020
-- 
2.34.1


