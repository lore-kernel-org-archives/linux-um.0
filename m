Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D82DC05027
	for <linux-um@archiver.kernel.org>; Fri, 10 Feb 2023 21:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B9zh7RVr3NpyVVHFTcoG/OIkA6JKulilae6C0CEpVq8=; b=3dlEG4qnbDyey1
	Fopy/6EX4cACpeeLcFRJmTOs6NnYbFNdThDnKvjIJK5JbeaQbdvOCu+rPGslVjT9elEzGOTrJn3we
	oqr3HM58G6KZoSyCQyrAiVGAFVijfjOc3qgV7n7AYEvWDsw6wedxwQY16K2ZwbSjbaSS5+xkRNlUS
	yGPYcfFM/dJuxyXVKbeP/q5MX5H68wYIUNf5tQnAJzuxgtXg4CH/3i1TMwROmktE9JRe5jZPi+egr
	fzzXGMRRW9ufBaB0qZapqdLfyU9lFfd1GteF5GO/jKAlRaJFwS8Bru6HDfFwQW1Igm8XKdiGROD18
	X/RsU4Mb9URZBdf9hpyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQagm-007apN-CE; Fri, 10 Feb 2023 21:12:12 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQaaG-007YSw-Ct
	for linux-um@lists.infradead.org; Fri, 10 Feb 2023 21:05:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=STNu0HhnzhDq2ob/APtksD8hbvn6DtxeF969E7u2EEo=;
	t=1676063126; x=1677272726; b=KufYpMNPXnFdznZ5w4440+LaZL97Ho4yX2q0mBi3g424Fcg
	4Jo96ZdNEW4SS6/m3uKfzZreNij1VO4Syff/FRIQo7mIFov6xRH8OexuL70KOM8Tjdt9l93mfnVyJ
	6PRTbfmPBdJgjBTibIZ0CFZTn301RuR0sea1oUfNS7JN7r4tKsuuNHYyhufKxwdYMWPr0EPrY1wgw
	NraBAvN2JjFQox+Jy43t8uCdF+WWZ5mlqTuLDSQ501men1/IUuAhLA8TInb5Q4TuCNdyGFwuHp01R
	VrfR3OKY7mkjbNMaMQiM9jaZRLhBsNWVXeJpJNGtJMLrxAN9J/X6szPHqhTqBuTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pQaa9-008R0g-0k;
	Fri, 10 Feb 2023 22:05:21 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/4] um: further clean up user_syms
Date: Fri, 10 Feb 2023 22:05:10 +0100
Message-Id: <20230210220511.c0db9fbccbd4.I0ad65912ca32fcb2bd76cfb1e7e423e3ffba352c@changeid>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210220511.fe9e2c4d805b.I2c7f7e32c861bfb10ff13860e80ef7daf4f60df9@changeid>
References: <20230210220511.fe9e2c4d805b.I2c7f7e32c861bfb10ff13860e80ef7daf4f60df9@changeid>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_130529_214139_DD0D4443 
X-CRM114-Status: GOOD (  14.69  )
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

From: Johannes Berg <johannes.berg@intel.com>

Make some cleanups, add and fix some comments and document
here that we shouldn't export (libc) symbols for "_user.c"
code, rather such should work like hostfs does now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/os-Linux/user_syms.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 1e9e92740b32..9b62a9d352b3 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -3,35 +3,36 @@
 #include <linux/types.h>
 #include <linux/module.h>
 
-/* Some of this are builtin function (some are not but could in the future),
- * so I *must* declare good prototypes for them and then EXPORT them.
- * The kernel code uses the macro defined by include/linux/string.h,
- * so I undef macros; the userspace code does not include that and I
- * add an EXPORT for the glibc one.
+/*
+ * This file exports some critical string functions and compiler
+ * built-in functions (where calls are emitted by the compiler
+ * itself that we cannot avoid even in kernel code) to modules.
+ *
+ * "_user.c" code that previously used exports here such as hostfs
+ * really should be considered part of the 'hypervisor' and define
+ * its own API boundary like hostfs does now; don't add exports to
+ * this file for such cases.
  */
 
-#undef strlen
-#undef strstr
-#undef memcpy
-#undef memset
-
-extern size_t strlen(const char *);
-extern void *memmove(void *, const void *, size_t);
-extern void *memset(void *, int, size_t);
-
 /* If it's not defined, the export is included in lib/string.c.*/
 #ifdef __HAVE_ARCH_STRSTR
+#undef strstr
 EXPORT_SYMBOL(strstr);
 #endif
 
 #ifndef __x86_64__
+#undef memcpy
 extern void *memcpy(void *, const void *, size_t);
 EXPORT_SYMBOL(memcpy);
+extern void *memmove(void *, const void *, size_t);
 EXPORT_SYMBOL(memmove);
+#undef memset
+extern void *memset(void *, int, size_t);
 EXPORT_SYMBOL(memset);
 #endif
 
 #ifdef CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA
+/* needed for __access_ok() */
 EXPORT_SYMBOL(vsyscall_ehdr);
 EXPORT_SYMBOL(vsyscall_end);
 #endif
@@ -44,6 +45,6 @@ extern long __guard __attribute__((weak));
 EXPORT_SYMBOL(__guard);
 
 #ifdef _FORTIFY_SOURCE
-extern int __sprintf_chk(char *str, int flag, size_t strlen, const char *format);
+extern int __sprintf_chk(char *str, int flag, size_t len, const char *format);
 EXPORT_SYMBOL(__sprintf_chk);
 #endif
-- 
2.39.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
