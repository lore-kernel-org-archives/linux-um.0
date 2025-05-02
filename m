Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB244C3ABAA
	for <linux-um@archiver.kernel.org>; Fri,  2 May 2025 22:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WuuHrObSToYmmq5bi30yOyMaR0MYnSQn63tQZA6LxII=; b=wlINN0hMMn+24e3be6KtyUXC5Y
	hT6IC4MCEvJFA3DGQI+ElSX/FJSAoiObCwI8ikwourgfsniYFh7RKcaFbUtgq8/9LBRcyZ6CrTW+z
	mus0Pg3HYEiGdEIpL1vEqeZ1YToBSSSQEv9AMvAkOeZbEOuRBbPzp2Uv85KrKRumR9c2JroAhfn7N
	MMvV7BmC73riaT11zSz27KaHfFmWszntCk/YeoXnIIAQFe7UJs2hhciRju8AGs0eAhOHeFhm6AmEQ
	A0xhmAzcLKj0Zj0U4OEUNkB9O8re46pARkiE6YZrKlqmfYuG0L/cP6aMpaiK+rLj/4dYDNGtmaRwZ
	J29fqo2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAzGx-00000003C8p-1PNF;
	Fri, 02 May 2025 22:54:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAzGv-00000003C7J-01Pg
	for linux-um@lists.infradead.org;
	Fri, 02 May 2025 22:54:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0431B5C5C63;
	Fri,  2 May 2025 22:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C102AC4CEED;
	Fri,  2 May 2025 22:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746226459;
	bh=xF83aDmqFbvCUaXo7mxg1j7TWAuDRl3V3C44XfenCBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xw/kqnMW6X6itgZQY+XZPyclDOFFHHd8zTcRSpSXNYBwrE9OZ2KcpgeEfhKZl8tOo
	 FYKUq+zupdEyqBix8779gWxG4RAbnlavrlqvDUPUGKM00xhBFQIBW+xCmYpzL+W9U3
	 9CaqJKqoDlE+Cn54ROrdFpjPGzxKRKgFqNqDlE8ca0WobLkdrMzm2oSh1wDhcVzf1B
	 tt6IzOSg/sc1HqEb2M5+E5q6eqnGT4h19iwKAkicM4le5S+cg0KbPO16J9WBCWFqAa
	 CP4scwfEGTvyjdR1OJVN+T3ceAYiKZpQ7ZHShrouGxIbZmOov/r3W9SVSrdB/GvLn7
	 nqnlCB9Oq2/Vw==
From: Kees Cook <kees@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	linux-kbuild@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH v2 3/3] integer-wrap: Force full rebuild when .scl file changes
Date: Fri,  2 May 2025 15:54:15 -0700
Message-Id: <20250502225416.708936-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502224512.it.706-kees@kernel.org>
References: <20250502224512.it.706-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2695; i=kees@kernel.org; h=from:subject; bh=xF83aDmqFbvCUaXo7mxg1j7TWAuDRl3V3C44XfenCBQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmivuI85U7N/WzzlN9cqLGqVdC53L/oHwfbLf9DF++mi ConLW/pKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmMj1P4wMPZc1RZaLnRXVX3on RnbKtpciUZ2agRuunHxVXLxk+rfnpxkZXieL9fE5qE4+yfT1wdwJO8OkNG0SBQw4Ojzm3NpT65j BCQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_155421_161225_235E49D9 
X-CRM114-Status: GOOD (  12.38  )
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

Since the integer wrapping sanitizer's behavior depends on its
associated .scl file, we must force a full rebuild if the file changes.
Universally include a synthetic header file that is rebuilt when the
.scl file changes, via compiler-version.h, since using "-include ..." is
not possible in the case of having compiler flags removed via
"filter-out" (which would remove all instances of "-include").

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas.schier@linux.dev>
Cc: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: <linux-kbuild@vger.kernel.org>
Cc: <kasan-dev@googlegroups.com>
Cc: <linux-hardening@vger.kernel.org>
---
 include/linux/compiler-version.h | 3 +++
 scripts/Makefile.ubsan           | 1 +
 scripts/basic/Makefile           | 9 +++++++++
 3 files changed, 13 insertions(+)

diff --git a/include/linux/compiler-version.h b/include/linux/compiler-version.h
index 05d555320a0f..9d6b1890ffc7 100644
--- a/include/linux/compiler-version.h
+++ b/include/linux/compiler-version.h
@@ -19,3 +19,6 @@
 #ifdef RANDSTRUCT
 #include "randstruct_hash.h"
 #endif
+#ifdef INTEGER_WRAP
+#include "integer-wrap.h"
+#endif
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 9e35198edbf0..653f7117819c 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -15,6 +15,7 @@ ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= $(call cc-option,-fsanitize-trap=undefined
 export CFLAGS_UBSAN := $(ubsan-cflags-y)
 
 ubsan-integer-wrap-cflags-$(CONFIG_UBSAN_INTEGER_WRAP)     +=	\
+	-DINTEGER_WRAP						\
 	-fsanitize-undefined-ignore-overflow-pattern=all	\
 	-fsanitize=signed-integer-overflow			\
 	-fsanitize=unsigned-integer-overflow			\
diff --git a/scripts/basic/Makefile b/scripts/basic/Makefile
index 31637ce4dc5c..04f5620a3f8b 100644
--- a/scripts/basic/Makefile
+++ b/scripts/basic/Makefile
@@ -15,3 +15,12 @@ $(obj)/randstruct_hash.h $(obj)/randstruct.seed: $(gen-randstruct-seed) FORCE
 	$(call if_changed,create_randstruct_seed)
 
 always-$(CONFIG_RANDSTRUCT) += randstruct.seed randstruct_hash.h
+
+# integer-wrap: if the .scl file changes, we need to do a full rebuild.
+quiet_cmd_integer_wrap_updated = UPDATE  $@
+      cmd_integer_wrap_updated = echo '/* $^ */' > $(obj)/integer-wrap.h
+
+$(obj)/integer-wrap.h: $(srctree)/scripts/integer-wrap-ignore.scl FORCE
+	$(call if_changed,integer_wrap_updated)
+
+always-$(CONFIG_UBSAN_INTEGER_WRAP) += integer-wrap.h
-- 
2.34.1


