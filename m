Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D23CAC58E
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 07:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LjPzDdYZooghqKYve4BhSZ1GWfFpNxXsDr4oaZkmiCc=; b=zuX9RyrSGWeSa4DgEx6Vb/0oaD
	VZT0FmtvQ/k4JQA+Z/WGAIrCGrG2HlgcdPhsTF54ISN3k84AeeUcBOHFcaD+88/bO52C+NDtgnU4u
	JWjIsleFhDrecVNdCIoadFoIToe1wTGrqBnd+/b9J3YhNQKlgXu0/aljdNUDumkjC5c2iXTdF8J+L
	CJalGK6U/ZDskzs2TuAyXgH90x81Plzm0xlxGKwZvQuiy1LIC+acz4LiaDHYqAfJyjAX2Ft+22Iil
	QRNo9ogTjeyXAbqjeTB1qlz3XitvZem8tHUKZg+2ALWQszB7AfZgOw1a5yRH9BBlfvbbqGSVeg6wO
	KUwbCt7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XQ-000000031qW-2Qka;
	Mon, 15 Sep 2025 07:22:12 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XN-000000031kF-2qvx
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 07:22:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LjPzDdYZooghqKYve4BhSZ1GWfFpNxXsDr4oaZkmiCc=;
	t=1757920929; x=1759130529; b=aCmVLFWEbOnJoYlnd4r7oX7+2SkoYWaQUWmbXu0Uuf7uGnR
	FIysGGV5f0PonQga+L3mEgj53DpUv8DHcnAWC/QtYPHAII27CmbATP1hCvLU4fBicJCTdlkIWHZDE
	/vAxTHv8Mf42irSjfQ2RQ0D7SeAh2n1DSLtTb7PcAW0MFQuXY3D5G4fpgwoBPYcTjD6zmk4PMS1sO
	QTu6pGMrdOUUxoflyWfiz8gFE9aXds7OuOmdHxZo7bq3fbVpS8msr9r2DJyNKaFzRX8qaykFnNyf0
	ZMas+jIRUYP6j20q51FqssPwon2qHYLwOFTYEr4ycI2dtBJTB4UMq54EzO47AdDg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XK-00000005w6o-3DZb;
	Mon, 15 Sep 2025 09:22:07 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 6/9] tools/nolibc: add option to disable startup code
Date: Mon, 15 Sep 2025 09:11:12 +0200
Message-ID: <20250915071115.1429196-7-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915071115.1429196-1-benjamin@sipsolutions.net>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_002209_925089_A3E76BE8 
X-CRM114-Status: GOOD (  16.12  )
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
going to be used. Add the NOLIBC_NO_STARTCODE compile time option to
disable it entirely and also remove anything that depends on it.

Doing this avoids warnings from modpost for UML as the _start_c code
references the main function from the .init.text section while it is not
inside .init itself.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
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
index 1f66e7e5a444..24ad348cc1e8 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -185,6 +185,7 @@
 })
 
 /* startup code */
+#ifndef NOLIBC_NO_STARTCODE
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
@@ -193,5 +194,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_STARTCODE */
 
 #endif /* _NOLIBC_ARCH_ARM_H */
diff --git a/tools/include/nolibc/arch-arm64.h b/tools/include/nolibc/arch-arm64.h
index 02a3f74c8ec8..554ebb51c761 100644
--- a/tools/include/nolibc/arch-arm64.h
+++ b/tools/include/nolibc/arch-arm64.h
@@ -142,6 +142,7 @@
 })
 
 /* startup code */
+#ifndef NOLIBC_NO_STARTCODE
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
@@ -150,4 +151,5 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_STARTCODE */
 #endif /* _NOLIBC_ARCH_ARM64_H */
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index 5511705303ea..cf14f7bf4081 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -143,6 +143,7 @@
 })
 
 /* startup code */
+#ifndef NOLIBC_NO_STARTCODE
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
@@ -151,5 +152,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_STARTCODE */
 
 #endif /* _NOLIBC_ARCH_LOONGARCH_H */
diff --git a/tools/include/nolibc/arch-m68k.h b/tools/include/nolibc/arch-m68k.h
index 6dac1845f298..dc0d48a10c14 100644
--- a/tools/include/nolibc/arch-m68k.h
+++ b/tools/include/nolibc/arch-m68k.h
@@ -128,6 +128,7 @@
 	_num;                                                                 \
 })
 
+#ifndef NOLIBC_NO_STARTCODE
 void _start(void);
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
@@ -137,5 +138,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_STARTCODE */
 
 #endif /* _NOLIBC_ARCH_M68K_H */
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 0cbac63b249a..6c6a65a99029 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -246,6 +246,7 @@
 #endif /* _ABIO32 */
 
 /* startup code, note that it's called __start on MIPS */
+#ifndef NOLIBC_NO_STARTCODE
 void __start(void);
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector __start(void)
 {
@@ -266,5 +267,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector __
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_STARTCODE */
 
 #endif /* _NOLIBC_ARCH_MIPS_H */
diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
index 204564bbcd32..7a01278e569c 100644
--- a/tools/include/nolibc/arch-powerpc.h
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -184,6 +184,7 @@
 #endif /* !__powerpc64__ */
 
 /* startup code */
+#ifndef NOLIBC_NO_STARTCODE
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
 #ifdef __powerpc64__
@@ -215,5 +216,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 #endif
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_STARTCODE */
 
 #endif /* _NOLIBC_ARCH_POWERPC_H */
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 885383a86c38..12ca37b8d964 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -140,6 +140,7 @@
 })
 
 /* startup code */
+#ifndef NOLIBC_NO_STARTCODE
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
@@ -152,5 +153,6 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_STARTCODE */
 
 #endif /* _NOLIBC_ARCH_RISCV_H */
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index df4c3cc713ac..fb0d312847b8 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -140,6 +140,7 @@
 })
 
 /* startup code */
+#ifndef NOLIBC_NO_STARTCODE
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
@@ -155,6 +156,7 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_STARTCODE */
 
 struct s390_mmap_arg_struct {
 	unsigned long addr;
diff --git a/tools/include/nolibc/arch-sh.h b/tools/include/nolibc/arch-sh.h
index a96b8914607e..038bf364aa27 100644
--- a/tools/include/nolibc/arch-sh.h
+++ b/tools/include/nolibc/arch-sh.h
@@ -141,6 +141,7 @@
 })
 
 /* startup code */
+#ifndef NOLIBC_NO_STARTCODE
 void _start_wrapper(void);
 void __attribute__((weak,noreturn)) __nolibc_entrypoint __no_stack_protector _start_wrapper(void)
 {
@@ -158,5 +159,6 @@ void __attribute__((weak,noreturn)) __nolibc_entrypoint __no_stack_protector _st
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_STARTCODE */
 
 #endif /* _NOLIBC_ARCH_SH_H */
diff --git a/tools/include/nolibc/arch-sparc.h b/tools/include/nolibc/arch-sparc.h
index ca420d843e25..062eae1fa92d 100644
--- a/tools/include/nolibc/arch-sparc.h
+++ b/tools/include/nolibc/arch-sparc.h
@@ -153,6 +153,7 @@
 })
 
 /* startup code */
+#ifndef NOLIBC_NO_STARTCODE
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
@@ -169,6 +170,7 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_STARTCODE */
 
 static pid_t getpid(void);
 
diff --git a/tools/include/nolibc/arch-x86.h b/tools/include/nolibc/arch-x86.h
index d3efc0c3b8ad..b4981e99f0a0 100644
--- a/tools/include/nolibc/arch-x86.h
+++ b/tools/include/nolibc/arch-x86.h
@@ -164,6 +164,7 @@
  * 2) The deepest stack frame should be set to zero
  *
  */
+#ifndef NOLIBC_NO_STARTCODE
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
@@ -176,6 +177,7 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_STARTCODE */
 
 #else /* !defined(__x86_64__) */
 
@@ -330,6 +332,7 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
  * 2) The deepest stack frame should be zero (the %rbp).
  *
  */
+#ifndef NOLIBC_NO_STARTCODE
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
@@ -340,6 +343,7 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _s
 	);
 	__nolibc_entrypoint_epilogue();
 }
+#endif /* NOLIBC_NO_STARTCODE */
 
 #define NOLIBC_ARCH_HAS_MEMMOVE
 void *memmove(void *dst, const void *src, size_t len);
diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index 961cfe777c35..d72e616eeec9 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -7,6 +7,8 @@
 #ifndef _NOLIBC_CRT_H
 #define _NOLIBC_CRT_H
 
+#ifndef NOLIBC_NO_STARTCODE
+
 #include "compiler.h"
 
 char **environ __attribute__((weak));
@@ -88,4 +90,5 @@ void _start_c(long *sp)
 	exit(exitcode);
 }
 
+#endif /* NOLIBC_NO_STARTCODE */
 #endif /* _NOLIBC_CRT_H */
diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
index c71a2c257177..3dd4d3e53ca6 100644
--- a/tools/include/nolibc/stackprotector.h
+++ b/tools/include/nolibc/stackprotector.h
@@ -9,6 +9,7 @@
 
 #include "compiler.h"
 
+#ifndef NOLIBC_NO_STARTCODE
 #if defined(_NOLIBC_STACKPROTECTOR)
 
 #include "sys.h"
@@ -49,5 +50,6 @@ static __no_stack_protector void __stack_chk_init(void)
 #else /* !defined(_NOLIBC_STACKPROTECTOR) */
 static void __stack_chk_init(void) {}
 #endif /* defined(_NOLIBC_STACKPROTECTOR) */
+#endif /* NOLIBC_NO_STARTCODE */
 
 #endif /* _NOLIBC_STACKPROTECTOR_H */
diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 5fd99a480f82..ed12c9119aab 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -107,6 +107,7 @@ void free(void *ptr)
  * environment variable exists its value is returned otherwise NULL is
  * returned.
  */
+#ifndef NOLIBC_NO_STARTCODE
 static __attribute__((unused))
 char *getenv(const char *name)
 {
@@ -122,6 +123,7 @@ char *getenv(const char *name)
 	}
 	return NULL;
 }
+#endif /* NOLIBC_NO_STARTCODE */
 
 static __attribute__((unused))
 void *malloc(size_t len)
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 295e71d34aba..c518a1b4af97 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -509,6 +509,7 @@ pid_t gettid(void)
 	return sys_gettid();
 }
 
+#ifndef NOLIBC_NO_STARTCODE
 static unsigned long getauxval(unsigned long key);
 
 /*
@@ -520,7 +521,7 @@ int getpagesize(void)
 {
 	return __sysret((int)getauxval(AT_PAGESZ) ?: -ENOENT);
 }
-
+#endif /* NOLIBC_NO_STARTCODE */
 
 /*
  * uid_t getuid(void);
diff --git a/tools/include/nolibc/sys/auxv.h b/tools/include/nolibc/sys/auxv.h
index c52463d6c18d..35d339146463 100644
--- a/tools/include/nolibc/sys/auxv.h
+++ b/tools/include/nolibc/sys/auxv.h
@@ -10,6 +10,8 @@
 #ifndef _NOLIBC_SYS_AUXV_H
 #define _NOLIBC_SYS_AUXV_H
 
+#ifndef NOLIBC_NO_STARTCODE
+
 #include "../crt.h"
 
 static __attribute__((unused))
@@ -38,4 +40,5 @@ unsigned long getauxval(unsigned long type)
 	return ret;
 }
 
+#endif /* NOLIBC_NO_STARTCODE */
 #endif /* _NOLIBC_SYS_AUXV_H */
-- 
2.51.0


