Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C52C7EE33
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 21:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mn0PKfnMP9kUyLtnZlsPABU82XfKW2Qhy6/v7YEtYp8=; b=f577MI8OJshVOKGW1tpS0CQRVv
	jIjIZZhBooe+oGdQP7WQY3QF2Sde8MxMxnw4I/sDNjONH+z/YH46bzqHzcv9gd19n/IbaC7KLp42R
	t0WTZYjHKwBLd1JCDOLp9j7rk/dwIim3XUqjTzVMRzeauhAUfZ/f3TDvnaUE6L3mHQMDlbTAL/u0M
	CHqIn3v48rjCPIAjoRv5ZHWc79SMFAkOamo/0ovmGho6Akaqglm1lE80VGdX1BLC9GEf6pkOrTtNL
	Tnf9FBe1+KbW8s2gBwWqyoIZtmp3CiFUpGA/zA7fq3YVQM+5lOv1bZ99pf8qyAZVFYU6XDvtYGbEp
	N8huA+yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUuBL-0000000CqJc-2eH1;
	Thu, 26 Jun 2025 21:30:55 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUskf-0000000Cfgq-066D
	for linux-um@lists.infradead.org;
	Thu, 26 Jun 2025 19:59:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Mn0PKfnMP9kUyLtnZlsPABU82XfKW2Qhy6/v7YEtYp8=;
	t=1750967956; x=1752177556; b=j5v3nesuGke6H7/HHh76RwLo1YcIHb0RelfN2/uCrEvF7Rs
	HtU/z8+OdUMUVUQDk0ODDKvaPP+OlFTPu1jRszqx3Ih5C+cCbu/OC8GzvuxU5Z0t99mbnKIwGpbzG
	Bnjuyp3czX3vkZE2vS4QTdSARDltIWWNsFvSNsGSjSLksNfe4sMBWKkgeHjeuX/7T8fi4mLg8hJ/4
	pNOveU1of1lhkVvhaVHyOd4pHbnDbAUFmnbDSilCnBEWzNDAAW7sHU8BCluziWoqy4uyjtoPhBN8N
	e4hLw0Pgiyg36+btL7ghPp4Oc2tEMuRvSsHwZb2pTU4LXkb8iDGi4HsekpJCecRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uUskc-0000000C0lZ-1ToV;
	Thu, 26 Jun 2025 21:59:14 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: kunit-dev@googlegroups.com,
	linux-um@lists.infradead.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC 1/2] tools/nolibc: add sigaction()
Date: Thu, 26 Jun 2025 21:57:13 +0200
Message-ID: <20250626195714.2123694-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250626195714.2123694-1-benjamin@sipsolutions.net>
References: <20250626195714.2123694-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_125917_060361_857F4A18 
X-CRM114-Status: UNSURE (   9.92  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

In preparation to add tests that use it.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 tools/include/nolibc/nolibc.h |  3 +++
 tools/include/nolibc/signal.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index c199ade200c2..29e37a755aba 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -92,6 +92,9 @@
 #ifndef _NOLIBC_H
 #define _NOLIBC_H
 
+/* So that we do not get compatibility types/defines */
+#define __KERNEL__
+
 #include "std.h"
 #include "arch.h"
 #include "types.h"
diff --git a/tools/include/nolibc/signal.h b/tools/include/nolibc/signal.h
index ac13e53ac31d..fa52119e577f 100644
--- a/tools/include/nolibc/signal.h
+++ b/tools/include/nolibc/signal.h
@@ -14,6 +14,7 @@
 #include "arch.h"
 #include "types.h"
 #include "sys.h"
+#include <linux/signal.h>
 
 /* This one is not marked static as it's needed by libgcc for divide by zero */
 int raise(int signal);
@@ -23,4 +24,37 @@ int raise(int signal)
 	return sys_kill(sys_getpid(), signal);
 }
 
+/*
+ * sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
+ */
+
+#ifdef SA_RESTORER
+__attribute__((naked))
+static void my_sa_restorer(void)
+{
+	my_syscall0(__NR_rt_sigreturn);
+}
+#endif
+
+static __attribute__((unused))
+int sys_sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
+{
+	struct sigaction real_act = *act;
+#ifdef SA_RESTORER
+	if (!(real_act.sa_flags & SA_RESTORER)) {
+		real_act.sa_flags |= SA_RESTORER;
+		real_act.sa_restorer = my_sa_restorer;
+	}
+#endif
+
+	return my_syscall4(__NR_rt_sigaction, signum, &real_act, oldact,
+			   sizeof(act->sa_mask));
+}
+
+static __attribute__((unused))
+int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
+{
+	return __sysret(sys_sigaction(signum, act, oldact));
+}
+
 #endif /* _NOLIBC_SIGNAL_H */
-- 
2.50.0


