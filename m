Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E31C5DF94
	for <linux-um@archiver.kernel.org>; Fri, 21 Aug 2026 22:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PoawpruQ26UxgXhGoUDM/P7VzQ79Tma0wyLntYv3M/I=; b=UtZa8bgZO2WQNyS/OZM/BOaJ5i
	sqpbUndg7cpeyBHqwfwzfIaD9IJTpuT5yhWhUghcy3c6119TaBs0QnNFF1BycRA3lPS1kSPmAuweF
	KDJHo2AWAgjFOyhjwA/HVhpH+vyKYvoQH3BKo8e6d/VIexN3JZu4grNH23rjIH/KrnWCRuM+j6doT
	lH1vRkKvj652S6tuyT8CxZcMx1U1M+qT8q4n7PlgIX+SGykIQaiKLuv9WxwIZ1ccelQsA+86QsFrz
	1DPmWqyIR/IAmzizZwdITQKGqTH06jSK4+mKt7rUj5EvpI2hVae4jnOtEw3oE/4LEXmDG1QpJoqmM
	FuZVLtpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxXzx-0000000E7Mh-3vhu;
	Fri, 21 Aug 2026 22:46:05 +0000
Received: from mail-pj1-x1047.google.com ([2607:f8b0:4864:20::1047])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxXzu-0000000E7M8-3HtI
	for linux-um@lists.infradead.org;
	Fri, 21 Aug 2026 22:46:04 +0000
Received: by mail-pj1-x1047.google.com with SMTP id 98e67ed59e1d1-38e7b87ce77so3356881a91.0
        for <linux-um@lists.infradead.org>; Fri, 21 Aug 2026 15:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787352361; x=1787957161; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PoawpruQ26UxgXhGoUDM/P7VzQ79Tma0wyLntYv3M/I=;
        b=TAqesbfH3azzmaiqEX+9iHbkME3Yh5xB8uJyjWLRebUWKuuOwCAnFK1WoNWAnz7r6M
         f8Yo0+giKJ7XhxuPsSitrDbxumMF4y8J/gEvmgm4LrSgYMd36hOZ7H/bPZpAonLDukmm
         mEgBizhxof4H/uHeA+F5Y7aaC5vZsAtzNxL5RyXLCYRE+rRmQ1uUE+sDg3ZnbQQ2ROYX
         518j3TsNNgLUd7Fj3JMQ3dqw4WqRSBCSHLuUDzheTwTfy/DAejGhqvhW7+sGAOw+0w3a
         +NrS0DjPrc6sZrvdryJy5W/LtYEWAM7uesAQOVhCP8ZdfF5fcr0WHD+djWlnsbyGbQn+
         IXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787352361; x=1787957161;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PoawpruQ26UxgXhGoUDM/P7VzQ79Tma0wyLntYv3M/I=;
        b=aU+WbbaHTXNK59X2zh7ZV1B1WAznuPkiKzAqWf5MHez1fo1GWFDUOIqFv4npRHs71y
         y77y3d2uN5tjmM9bWteSyWJANMl2pHh/aftWTK0xA67oyz3d/MUn1/Sn6ZQOg0y5fEYQ
         RUDb1eGzOYhu8GbAG1e667q+pwgYWeZ8sB8W1pX3AOBeOzmmA3ojE/r7VmcClaWZq3v7
         hAD8TeWInjRh4/4h4xWSCDUfgZYF5UjqnFU6tuaUirUNX9naUP6Cz0OrZZTZmN/iVGYe
         locLLENjf7uZ+Iuxxb5m1U0AtXmpf+ezZp0hcROsH5UFEXVNFJ9KsgKboW9DzQGbiwCz
         l8Lw==
X-Forwarded-Encrypted: i=1; AHgh+Rpfma1S4c8jAHlxOC4gNYqMr1rMje5XJEBcd4vPUuYvvJ20rpjkT78xKz6ZTVqRt3kUjwlGisBD8Q==@lists.infradead.org
X-Gm-Message-State: AFuF++kWObnREP7udwcHBrd0lZIUm+r2ztCp8IzCQMWUF8jH67B+TmfH
	EPztauI4PEXegoof2QFjCikJ49vKHAwe2Zwduu5E5frAyQerz2uhWx1TPCWzGFYD22PfyAz0UQP
	rBRuP/T0hYjNVdYrjiUP0sNUZj8NmRg==
X-Received: from dlbcm37.prod.google.com ([2002:a05:7022:68a5:b0:139:d9c7:3cf4])
 (user=ndesaulniers job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3812:b0:380:fead:448d with SMTP id 98e67ed59e1d1-395c3a09bfemr15847665a91.13.1787352360541;
 Fri, 21 Aug 2026 15:46:00 -0700 (PDT)
Date: Fri, 21 Aug 2026 15:45:42 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABXViGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyND3YKSosTk1PjSxIJMXRMzI2NTAwNjs+SkFCWgjoKi1LTMCrBp0bG 1tQCyeUaBXQAAAA==
X-Change-Id: 20260821-ptrace_uapi-462350036cbd
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=O0COsmvrvggwIeEq7bAuRbULbXScoJmbNMYaRi6RFIw=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787352358; l=3055;
 i=ndesaulniers@google.com; s=20260611; h=from:subject:message-id;
 bh=OEJp5z39oCqCpxH9dM2BpNCfiPMMeGugZKo1K/SEU98=; b=nXfOMSQEPii8YVDQy8UrkSfJXgJBGvGNfX6ksH6fZLOSUyCwFn0P3gcNXWaQcup2Iz0vj26Ya
 yMecgjBxvjSACYXvNTyBVGj/Mgas2lC8pRpkXstr0/gtjcTYlKP9EOD
X-Mailer: b4 0.14.3
Message-ID: <20260821-ptrace_uapi-v1-1-3de8638a29f2@google.com>
Subject: [PATCH] x86: uapi: ptrace: guard register offset macros with
 __ASSEMBLER__ or __FRAME_OFFSETS
From: Nick Desaulniers <ndesaulniers@google.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Oleg Nesterov <oleg@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_154602_832361_4192CA84 
X-CRM114-Status: GOOD (  13.25  )
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

The register offset macros in <asm/ptrace-abi.h> are guarded by
`defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)` for 64-bit, but
were left unguarded for 32-bit. This causes havoc for userspace that
happens to use identifiers colliding with these short macro names
(e.g., EBX, ECX, EAX, DS, ES, FS, GS, CS, SS). Without this guard,
userspace is forced to be super extra careful with include ordering to
minimize the chance of collision.

Wrap both the 32-bit and 64-bit register definitions under
`#if defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)`, and ensure
User-Mode Linux (UML) defines `__FRAME_OFFSETS` for 32-bit as well.

Assisted-by: Gemini
Link: https://github.com/llvm/llvm-project/issues/217413
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/uapi/asm/ptrace-abi.h | 4 ++--
 arch/x86/um/asm/ptrace.h               | 4 +---
 arch/x86/um/ptrace_32.c                | 1 +
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/uapi/asm/ptrace-abi.h b/arch/x86/include/uapi/asm/ptrace-abi.h
index 5823584dea13..3656955c6faa 100644
--- a/arch/x86/include/uapi/asm/ptrace-abi.h
+++ b/arch/x86/include/uapi/asm/ptrace-abi.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_PTRACE_ABI_H
 #define _ASM_X86_PTRACE_ABI_H
 
+#if defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)
 #ifdef __i386__
 
 #define EBX 0
@@ -25,7 +26,6 @@
 
 #else /* __i386__ */
 
-#if defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)
 /*
  * C ABI says these regs are callee-preserved. They aren't saved on kernel entry
  * unless syscall needs a complete, fully filled "struct pt_regs".
@@ -57,12 +57,12 @@
 #define EFLAGS 144
 #define RSP 152
 #define SS 160
-#endif /* __ASSEMBLER__ */
 
 /* top of stack page */
 #define FRAME_SIZE 168
 
 #endif /* !__i386__ */
+#endif /* defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS) */
 
 /* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
 #define PTRACE_GETREGS            12
diff --git a/arch/x86/um/asm/ptrace.h b/arch/x86/um/asm/ptrace.h
index 2641d28d115c..439c4151f6b7 100644
--- a/arch/x86/um/asm/ptrace.h
+++ b/arch/x86/um/asm/ptrace.h
@@ -13,9 +13,7 @@ enum {
 };
 
 #include <linux/compiler.h>
-#ifndef CONFIG_X86_32
-#define __FRAME_OFFSETS /* Needed to get the R* macros */
-#endif
+#define __FRAME_OFFSETS /* Needed to get the register macros */
 #include <asm/ptrace-generic.h>
 
 #define user_mode(r) UPT_IS_USER(&(r)->regs)
diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
index 3af3cb821524..9e9155b0e918 100644
--- a/arch/x86/um/ptrace_32.c
+++ b/arch/x86/um/ptrace_32.c
@@ -7,6 +7,7 @@
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 #include <linux/regset.h>
+#define __FRAME_OFFSETS
 #include <asm/ptrace-abi.h>
 #include <registers.h>
 #include <skas.h>

---
base-commit: 26260251022fbc2f248a3d747a9b2b961b18d2d8
change-id: 20260821-ptrace_uapi-462350036cbd

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>


