Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97143CAC592
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 15:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=783287hlMPYEkv3TvU4cURXyY84uTXEsGGJ8kdsUrw0=; b=lN8T9OLYhAOBplq9Cj8/3uwbO6
	TA95prSqSoRUkDlYLNriRfTYUQF0+6t3u856rpp/409+zRWO71bRMRHicnpPZRYm/aE7VZJExDt5t
	ei0CO5faCZ7MbAlFTLnUpqbgU2hCC5AEtTg95V0KNUx8f4MYF7PSLnY7sQXbBwA0RkX/rfoM8pJZM
	+vA1lY1RrYcDJvoS3DGAkk5v4n3sfl+Y9dDhrQxMfxy6ewOe9lTbOoO+GY9x2ahqtQryeTrOB/Qkl
	Cud7IHFSBYe92FMWW90rbhaJlJ/r03gzwqN8xdx+wILswSccC6E5l20f2IswDSRDneyPu37EayjuI
	kdF5qwhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9n-00000003MQf-1S7V;
	Fri, 19 Sep 2025 15:36:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9k-00000003MMY-10Gp
	for linux-um@bombadil.infradead.org;
	Fri, 19 Sep 2025 15:36:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=783287hlMPYEkv3TvU4cURXyY84uTXEsGGJ8kdsUrw0=; b=Wm9U4tmqzj2rccjlN0DgX8DPHw
	bGuwqJOeJGWEyq2mY3LJIdmlqpFY5j1J+gcjOSFBnH/CwJE/I9moaP0RkrUedZazZWtHWPkQoVVCK
	3Uu+GE4mTZgARemDFQaFUX+TkTxWBA+eiWYVB0CgnjNejTF5SND0Z9hlgbSoFYu/fj0TQoa+CU3h4
	BGNAscOoYfCjwL451D0THhCGNjiog0zFc4CL43NETNFIbVZMj5TbVOqoxm8oTobDHkyjZ3CMhVTwH
	rHe3n9z3zZRLjDOWDgcnngIkvQ57mXqkhzLfyitRu6cz8juuTZaeMXXCVVe5LMy7265UEZ0xxbfEG
	odVLBKsg==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9d-00000007rkp-3WlJ
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 15:36:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=783287hlMPYEkv3TvU4cURXyY84uTXEsGGJ8kdsUrw0=;
	t=1758296168; x=1759505768; b=vvfBWJwWy7bKt8C9rEdGMcGjSeiiqfuUKjJeYE32lXv6s42
	UyzV7uuj8pABtaoQwPsEs+CZcFtfV+r0i5+KUWgsiTdl1/hOcohwJ7d6viYmCXEawMBJNd4TJYptM
	CKZ5Wh3Ri+YnzashvizuFetwOM3Uosm0saBL75XF6mZtnTunOl8pRT3MiFOGMpWQh2WPXlMu5GfWh
	zkik+NFAlIDQVf8MwvY6woeDUSiqCywIU0eIkfpvKVeW3KmlIyzXuLSPOtBejHmuQFvVR2llJAe7/
	MITYQeNM3rKcbVQk1me/Sj+eC7rGPJF8PWOcN8mMyUilMDhBCsrHbsnph4Nx4jkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9a-0000000G6O6-1HuQ;
	Fri, 19 Sep 2025 17:36:06 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 06/11] tools/nolibc: add option to disable runtime
Date: Fri, 19 Sep 2025 17:34:15 +0200
Message-ID: <20250919153420.727385-7-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_163610_156998_A62BDAE5 
X-CRM114-Status: GOOD (  16.87  )
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


