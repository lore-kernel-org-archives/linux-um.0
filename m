Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BCCC5B56A
	for <linux-um@archiver.kernel.org>; Wed, 12 Aug 2026 17:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xF6bTV/wIDnaHEoXIl5UQUpd0b0xt24LfTlBw27N8P4=; b=eTn4g3JWaMls8AIPCLClWO9wsc
	XxhPbPguXR0edvmFvM0LNG9fWNA3B3SyjgrgyNHmo/eoR594UzpfubvCfp791Zba87EQL2R+n8Ha4
	gF/6r24GQv3h1iy7+/W95eyEqfcTbO+8JCgtjjj/c7620NUS1ZhyuVQ1Qczes3lQm5KvWM9XtMe7x
	YnpwJ2NE4FqCPkHNsjRKTPffBnGxRfOT1EklfF4i9R/PLmr6EN6PnlB0EkCyBWEDGYtS9/dWPI/KG
	nQB9GnBlXgLnIR+bBd2SQFI2G+MqIB/PwfrbSAEAqo2rI9P8QYq2MmJsF/kJxJIKSyD8zUUCUu2+d
	m/71/VUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuCp8-0000000Gg8g-3leM;
	Wed, 12 Aug 2026 17:33:06 +0000
Received: from lpdvsmtp11.broadcom.com ([192.19.166.231] helo=relay.smtp-ext.broadcom.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuCp6-0000000Gg7y-1CcV
	for linux-um@lists.infradead.org;
	Wed, 12 Aug 2026 17:33:05 +0000
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 43D33C0000F5;
	Wed, 12 Aug 2026 10:33:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 43D33C0000F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1786555981;
	bh=JuGQlfA3zgIraOxula7WgOztTGsCcKU4o/xpMXTOJCw=;
	h=From:To:Cc:Subject:Date:From;
	b=h0QatlwVObtyISLaxAJLNawU0hCU0iWVSzXbPVXou2iLPICDMZBdoL+Nyh5hOXenS
	 6pSDmDnrPvc82JJA1UoqlrjuA8woDn2yuMPTyO5pY3VvNwgX/CYjSm3wxF4e9WaHsS
	 ly1E+306e/e+uoQRo77+zVSBaFVyZzSO0iCunK+U=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 67A1EAEA2;
	Wed, 12 Aug 2026 13:33:00 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML))
Subject: [PATCH] um: Add definition of __NR_close_range for older host OSs
Date: Wed, 12 Aug 2026 10:32:49 -0700
Message-Id: <20260812173249.98435-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_103304_373679_A2541E4C 
X-CRM114-Status: UNSURE (   9.23  )
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

__NR_close_range was introduced with
278a5fbaed89dacd04e9d052f4594ffd0e0585de ("open: add close_range()")
which is present in Linux >= 5.9. Older hosts running a kernel version
prior to that range currently fail to build due to that missing system
call number definition.

Fixes: f82a9e7b9fa9 ("um: fix execve stub execution on old host OSs")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/um/include/shared/skas/stub-data.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 27db38e95df9..1230a325debc 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -9,11 +9,20 @@
 #define __STUB_DATA_H
 
 #include <linux/compiler_types.h>
+#include <asm/unistd.h>
 #include <as-layout.h>
 #include <sysdep/tls.h>
 #include <sysdep/stub-data.h>
 #include <mm_id.h>
 
+#ifndef __NR_close_range
+# if defined(__alpha__)
+#  define __NR_close_range 546
+# else
+#  define __NR_close_range 436
+# endif
+#endif
+
 #define FUTEX_IN_CHILD 0
 #define FUTEX_IN_KERN 1
 
-- 
2.34.1


