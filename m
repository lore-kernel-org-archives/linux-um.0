Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91566CAC5A5
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wyrt4ywsUa30dSsyTR71hnWg6bMqqctOayCDw74qBv4=; b=bGJ9kercCw/So34MPvFfpShf4M
	0+1axe3ZjCci7BfPsn4n513uuP3drbNvCTotJhFdAFv3HIoC1W0hQJoA/UTpS4P6YY5uFaSIuJMMg
	2rgVizaCetBBX+cZAUqY4hhuNgLY7SWZPLW3YpgcA3OQKi3zJmPkcUfq5p4r4nPv0N01SJuKa7AVf
	rWHqgCTxVriV1NAQsl8ZIvoQXO4pE0TF5RSnVpiYYJiKGh8bophYnzRfqmAl0KNHzK4Ui9wJQIUF8
	bNIhhXdwXlWxZnwTjQ5s8vMNjnpKJirmzmU8UG/83UmQU6+DSczTsWQp5GOcBoOxGwvpDQEmdnseY
	k4ID6T5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNe-00000000ayM-1Pks;
	Wed, 24 Sep 2025 14:22:02 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNa-00000000aoT-2RbQ
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 14:22:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Wyrt4ywsUa30dSsyTR71hnWg6bMqqctOayCDw74qBv4=;
	t=1758723718; x=1759933318; b=XtFL3GzCb4YEPWzxESm6Zbp8uRiq5VLoyxYy3nIhL8aG6uD
	S9BbDy1vrWRHdzW72DjgZtm9XhK4Oxbt/Gu4sydzCuPSAspb5iATy4A3jUOTywYNMD/PwwIbhfJoF
	9O1u5NMh46lqApVoIXEs6IHVaMRXIJ62IwbTZxfhMTVvGo6luqDm/2EOQapLcdPkJyUcPK9H833WC
	lwoAllm7goxBTd8haFltUse+qWSvwrRFlxbSwOVlHD9wRd0qU3eJB2ing3oE9N70FVNNaxGZYgRr3
	OZeuomzwHl3JwWHXU9F2cNN9KF2MCv5yXFhW/VDTlK9KTzP0Ld6/G2WT+ALbLy6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNY-000000090Bz-01ju;
	Wed, 24 Sep 2025 16:21:56 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 07/12] tools/nolibc: add option to disable runtime
Date: Wed, 24 Sep 2025 16:20:54 +0200
Message-ID: <20250924142059.527768-8-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924142059.527768-1-benjamin@sipsolutions.net>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_072158_773120_E7B0EE3A 
X-CRM114-Status: GOOD (  16.90  )
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

In principle, it is possible to use nolibc for only some object files in
a program. In that case, the startup code in _start and _start_c is not
going to be used. Add the NOLIBC_NO_RUNTIME compile time option to
disable it entirely and also remove anything that depends on it.

Doing this avoids warnings from modpost for UML as the _start_c code
references the main function from the .init.text section while it is not
inside .init itself.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Acked-by: Thomas Weißschuh <linux@weissschuh.net>

---
v2:
- Renamed from NOLIBC_NO_STARTCODE to NOLIBC_NO_RUNTIME
- Put the #ifdef around relevant comments
---
 tools/include/nolibc/arch-arm.h       | 2 ++
 tools/include/nolibc/arch-arm64.h     | 2 ++
 tools/include/nolibc/arch-loongarch.h | 2 ++
 tools/include/nolibc/arch-m68k.h      | 2 ++
 tools/include/nolibc/arch-mips.h      | 2 ++
 tools/include/nolibc/arch-powerpc.h   | 2 ++
 tools/include/nolibc/arch-riscv.h     | 2 ++
 tools/include/nolibc/arch-s390.h      | 2 ++
 tools/include/nolibc/arch-sh.h        | 2 ++
 tools/include/nolibc/arch-sparc.h     | 2 ++
 tools/include/nolibc/arch-x86.h       | 4 ++++
 tools/include/nolibc/crt.h            | 3 +++
 tools/include/nolibc/stackprotector.h | 2 ++
 tools/include/nolibc/stdlib.h         | 2 ++
 tools/include/nolibc/sys.h            | 3 ++-
 tools/include/nolibc/sys/auxv.h       | 3 +++
 16 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 1f66e7e5a444..251c42579028 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -184,6 +184,7 @@
 	_arg1;                                                                \
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -193,5 +194,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #endif /* _NOLIBC_ARCH_ARM_H */
diff --git a/tools/include/nolibc/arch-arm64.h b/tools/include/nolibc/arch-arm64.h
index 02a3f74c8ec8..080a55a7144e 100644
--- a/tools/include/nolibc/arch-arm64.h
+++ b/tools/include/nolibc/arch-arm64.h
@@ -141,6 +141,7 @@
 	_arg1;                                                                \
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -150,4 +151,5 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 #endif /* _NOLIBC_ARCH_ARM64_H */
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index 5511705303ea..c894176c3f89 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -142,6 +142,7 @@
 	_arg1;                                                                \
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -151,5 +152,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #endif /* _NOLIBC_ARCH_LOONGARCH_H */
diff --git a/tools/include/nolibc/arch-m68k.h b/tools/include/nolibc/arch-m68k.h
index 6dac1845f298..2a4fbada5e79 100644
--- a/tools/include/nolibc/arch-m68k.h
+++ b/tools/include/nolibc/arch-m68k.h
@@ -128,6 +128,7 @@
 	_num;                                                                 \
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 void _start(void);
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -137,5 +138,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #endif /* _NOLIBC_ARCH_M68K_H */
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 0cbac63b249a..a72506ceec6b 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -245,6 +245,7 @@
 
 #endif /* _ABIO32 */
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code, note that it's called __start on MIPS */
 void __start(void);
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector __start(void)
@@ -266,5 +267,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector __
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #endif /* _NOLIBC_ARCH_MIPS_H */
diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
index 204564bbcd32..e0c7e0b81f7c 100644
--- a/tools/include/nolibc/arch-powerpc.h
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -183,6 +183,7 @@
 #endif
 #endif /* !__powerpc64__ */
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -215,5 +216,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 #endif
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #endif /* _NOLIBC_ARCH_POWERPC_H */
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 885383a86c38..1c00cacf57e1 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -139,6 +139,7 @@
 	_arg1;                                                                \
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -152,5 +153,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #endif /* _NOLIBC_ARCH_RISCV_H */
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index df4c3cc713ac..6237211385c0 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -139,6 +139,7 @@
 	_arg1;								\
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -155,6 +156,7 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 struct s390_mmap_arg_struct {
 	unsigned long addr;
diff --git a/tools/include/nolibc/arch-sh.h b/tools/include/nolibc/arch-sh.h
index a96b8914607e..7a421197d104 100644
--- a/tools/include/nolibc/arch-sh.h
+++ b/tools/include/nolibc/arch-sh.h
@@ -140,6 +140,7 @@
 	_ret;                                                                 \
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 void _start_wrapper(void);
 void __attribute__((weak,noreturn)) __nolibc_entrypoint __no_stack_protector _start_wrapper(void)
@@ -158,5 +159,6 @@ void __attribute__((weak,noreturn)) __nolibc_entrypoint __no_stack_protector _st
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #endif /* _NOLIBC_ARCH_SH_H */
diff --git a/tools/include/nolibc/arch-sparc.h b/tools/include/nolibc/arch-sparc.h
index ca420d843e25..2ebb5686e105 100644
--- a/tools/include/nolibc/arch-sparc.h
+++ b/tools/include/nolibc/arch-sparc.h
@@ -152,6 +152,7 @@
 	_arg1;                                                                \
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -169,6 +170,7 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 static pid_t getpid(void);
 
diff --git a/tools/include/nolibc/arch-x86.h b/tools/include/nolibc/arch-x86.h
index d3efc0c3b8ad..11abb8bd7eec 100644
--- a/tools/include/nolibc/arch-x86.h
+++ b/tools/include/nolibc/arch-x86.h
@@ -157,6 +157,7 @@
 	_eax;							\
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 /*
  * i386 System V ABI mandates:
@@ -176,6 +177,7 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #else /* !defined(__x86_64__) */
 
@@ -323,6 +325,7 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	_ret;                                                                 \
 })
 
+#ifndef NOLIBC_NO_RUNTIME
 /* startup code */
 /*
  * x86-64 System V ABI mandates:
@@ -340,6 +343,7 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 #define NOLIBC_ARCH_HAS_MEMMOVE
 void *memmove(void *dst, const void *src, size_t len);
diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index 961cfe777c35..d9262998dae9 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -7,6 +7,8 @@
 #ifndef _NOLIBC_CRT_H
 #define _NOLIBC_CRT_H
 
+#ifndef NOLIBC_NO_RUNTIME
+
 #include "compiler.h"
 
 char **environ __attribute__((weak));
@@ -88,4 +90,5 @@ void _start_c(long *sp)
 	exit(exitcode);
 }
 
+#endif /* NOLIBC_NO_RUNTIME */
 #endif /* _NOLIBC_CRT_H */
diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
index c71a2c257177..7123aa056cb0 100644
--- a/tools/include/nolibc/stackprotector.h
+++ b/tools/include/nolibc/stackprotector.h
@@ -9,6 +9,7 @@
 
 #include "compiler.h"
 
+#ifndef NOLIBC_NO_RUNTIME
 #if defined(_NOLIBC_STACKPROTECTOR)
 
 #include "sys.h"
@@ -49,5 +50,6 @@ static __no_stack_protector void __stack_chk_init(void)
 #else /* !defined(_NOLIBC_STACKPROTECTOR) */
 static void __stack_chk_init(void) {}
 #endif /* defined(_NOLIBC_STACKPROTECTOR) */
+#endif /* NOLIBC_NO_RUNTIME */
 
 #endif /* _NOLIBC_STACKPROTECTOR_H */
diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 5fd99a480f82..f184e108ed0a 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -100,6 +100,7 @@ void free(void *ptr)
 	munmap(heap, heap->len);
 }
 
+#ifndef NOLIBC_NO_RUNTIME
 /* getenv() tries to find the environment variable named <name> in the
  * environment array pointed to by global variable "environ" which must be
  * declared as a char **, and must be terminated by a NULL (it is recommended
@@ -122,6 +123,7 @@ char *getenv(const char *name)
 	}
 	return NULL;
 }
+#endif /* NOLIBC_NO_RUNTIME */
 
 static __attribute__((unused))
 void *malloc(size_t len)
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 295e71d34aba..a48f5117bfce 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -509,6 +509,7 @@ pid_t gettid(void)
 	return sys_gettid();
 }
 
+#ifndef NOLIBC_NO_RUNTIME
 static unsigned long getauxval(unsigned long key);
 
 /*
@@ -520,7 +521,7 @@ int getpagesize(void)
 {
 	return __sysret((int)getauxval(AT_PAGESZ) ?: -ENOENT);
 }
-
+#endif /* NOLIBC_NO_RUNTIME */
 
 /*
  * uid_t getuid(void);
diff --git a/tools/include/nolibc/sys/auxv.h b/tools/include/nolibc/sys/auxv.h
index c52463d6c18d..0e98325e7347 100644
--- a/tools/include/nolibc/sys/auxv.h
+++ b/tools/include/nolibc/sys/auxv.h
@@ -10,6 +10,8 @@
 #ifndef _NOLIBC_SYS_AUXV_H
 #define _NOLIBC_SYS_AUXV_H
 
+#ifndef NOLIBC_NO_RUNTIME
+
 #include "../crt.h"
 
 static __attribute__((unused))
@@ -38,4 +40,5 @@ unsigned long getauxval(unsigned long type)
 	return ret;
 }
 
+#endif /* NOLIBC_NO_RUNTIME */
 #endif /* _NOLIBC_SYS_AUXV_H */
-- 
2.51.0


