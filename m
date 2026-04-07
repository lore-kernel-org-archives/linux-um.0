Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286B7FF510E
	for <linux-um@archiver.kernel.org>; Tue,  7 Apr 2026 18:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vl0fSOLNOL0VYWbHLlMdkEjeY0mPmotcIP2HiCQA9z8=; b=Id+QnBKyS1XvYebicN3uGznUyf
	Zvx+g6lqG+wtTxWg8BW45jdLRT8HQA0MJGwlxAWOQws7It0FYLn79QE24LGtnLbILJUzbrcwlnWOo
	D7GbDC0sF0hwevdCkv4yRxVaCJsg29ZS38e5n2Iuu8xWb/BFrY76zuCyvmmHFXAwhvPtNBAJBvs1z
	rgdgiWt8fxuD61qgqEuEXalxNJXdoMDnpty4oGMVHkJ6wcQ2EXuLslv6LMRtBC1mtp+yD4u7F+6tD
	UMMocoPzsh2hn4xWl6azg+j3IenjqoI0PVr7o5UI6Eo/NZjcH5mafMAg4IKcugIDmjFWkuWIyC9yD
	J+t3kaoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAAxh-00000006uFV-24r5;
	Tue, 07 Apr 2026 18:15:41 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAAxd-00000006uEe-43Xr
	for linux-um@lists.infradead.org;
	Tue, 07 Apr 2026 18:15:39 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-50b2b289925so47557401cf.2
        for <linux-um@lists.infradead.org>; Tue, 07 Apr 2026 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775585736; x=1776190536; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vl0fSOLNOL0VYWbHLlMdkEjeY0mPmotcIP2HiCQA9z8=;
        b=WzoJCqa6ROHPWvz9cXEN+I5IqLLomS8nFPAstObiKM+sbK2q8x10pbZbqlGBBQP1S9
         C+FT14WCVcCHhy39NZl4nR0OrZ4dRq3sZayRmzYl2XaYyokdRY4S7Ivc//0LwaI3e/SZ
         8QdWGTbXulnUAek1W21iq6Q5YfKSAk2cTFC9k/EaWZFFi6pHMUiM4OuukwAvLj1Wqhuy
         jADm4v4cjAwWszuXZb9tZb90doXJTr0lw346rRa4H+1gZohlnhSnCMO/hGWtQR3p8/Vy
         DsOJqHPFsJxl4CBtCDRu4gyxUZSEhaQf5TLxy83iEwgQzcs+J3Qc1JAkPLGn+V8zul2F
         lpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775585736; x=1776190536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vl0fSOLNOL0VYWbHLlMdkEjeY0mPmotcIP2HiCQA9z8=;
        b=GOj41QZAFkTmgB8xsIre9cX7UjNljqVhsYCCqPBhAyMk3wDc9dc4ygcfd6zr0HHt84
         F8lkhg4c3Ft/DHRD6M95gt8Ijpam3BzS9UdbcBP/IZ6LXOtp9xmyEmnHkvBSyeKzRBo6
         eZs9GAJNb/Zjf0oBUpPeOzou+WnE9usgo2sFaQ3gCUNogJwrtYrLkUVl64XN/aSIa0vH
         MwEREtBBl8kyZpOE8QBJsdzCbxWPCphwNgIOdgbhDYf/Ibp5Tden+NI77v58vGc2/8FQ
         HrMemtXqVqod1urku6bABwMVlFhQ0+QQjAhhCzJkL/XqIyVYwksC2VDTwQ5tUZLdWKPu
         4qDg==
X-Gm-Message-State: AOJu0YwnVsXrAQpVeKHP/IUrqf6BEO+hBNF14c6f5hcaJJkdbUKWr8FX
	5W/FTp7oLNGc5tWKz4fJoKUsjutvi69+IwkUOY3hM6gcy2agRYkg6Vrt
X-Gm-Gg: AeBDies6/J98i+qji3xlXrwDARXXVmK9onhevfvR7mQaR03KGQviEwpNxK8nI6iwfzz
	ajDhc7E0Ja6PGki1tKF2qb8lFpqedtV4qbonKYLVvAfr21QlKOjJKRhYKXrjyjBp8QlP0HkPPc9
	s2H8vtb5ltbRJoiu73BIvW2e9eMfD0w3+4uJfHRz74+SixR9A4YxUiLUtcMJttvg5jcL7iNVSkc
	lR8AsGgiE0NEGAW5ZNwdATZMymOmsR+jknDRH37RdpwWphTKLtkSGfUt0TWIk8rC+o9GeuF6ZRY
	fF98VRFX8e5KPLlvOCraLdStnmbuf1UM0r6JJbp00i7IrIxDghfRgCkB8JFiS5V+hEnWjCGhO1R
	H9lBnKeBUaHbFx2jV3Weg+qczy7enxWNPbDcF5A+KkWj1bBiyqPwwKkoFa0CYxu8lEoKBmIx2Rm
	+J1YdtMqyrL0pYUF5PD/CKcL1eMjkwDjI2xpbQnRTiL3A8/9Nn0Vy73vLpVX2WgvZvL4djFtDrF
	rSPEqlqUSvkEQLdF00isYLJ0GhRy/DQghA8rw==
X-Received: by 2002:a05:622a:8d06:b0:509:15aa:cf01 with SMTP id d75a77b69052e-50d62b57d4cmr246252501cf.61.1775585736146;
        Tue, 07 Apr 2026 11:15:36 -0700 (PDT)
Received: from workstation1 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593908b47sm186312926d6.11.2026.04.07.11.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:15:35 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] um: drivers: call kernel_strrchr() explicitly in cow_user.c
Date: Tue,  7 Apr 2026 14:15:28 -0400
Message-ID: <20260407181528.879358-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407164435.726012-1-michael.bommarito@gmail.com>
References: <20260407164435.726012-1-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_111538_024127_A07003C9 
X-CRM114-Status: GOOD (  19.06  )
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

Building ARCH=um on a host with glibc >= 2.43 fails:

  arch/um/drivers/cow_user.c:156:17: error: implicit declaration of
  function 'strrchr' [-Wimplicit-function-declaration]

cow_user.o is a host-side helper (compiled with -D__UM_HOST__) that
calls strrchr().  It inherits the global -Dstrrchr=kernel_strrchr
remap from arch/um/Makefile, which is intentionally kept in
USER_CFLAGS to prevent libc/kernel symbol clashes.

This combination was harmless until glibc 2.43, which added (glibc
commit cd748a63ab1a, "Implement C23 const-preserving standard library
macros"):

  #define strrchr(S,C) __glibc_const_generic(S, const char *, strrchr(S, C))

The glibc function-like macro replaces the -D object-like macro.  The
inner strrchr token in the expansion is protected from recursive
expansion, so it refers to the bare symbol strrchr -- but the header
declaration was already rewritten to kernel_strrchr by the -D.  The
result is an implicit-declaration error.

The global -Dstrrchr=kernel_strrchr remap was originally added in
commit 2c51a4bc0233 ("um: fix strrchr() problems") to resolve a
linker clash when both CONFIG_STATIC_LINK and CONFIG_UML_NET_VDE are
set.  Recently, commit a74b6c0e53a6 ("um: Don't rename vmap to
kernel_vmap") trimmed the now-obsolete vmap remap and updated the
comment in arch/um/Makefile to explicitly call out
-Dstrrchr=kernel_strrchr as one of the remaps that still prevents
libc symbol clashes.  That global remap stays in place.

Rather than exempting cow_user.o from the remap at build time, call
kernel_strrchr() explicitly in the source.  This is slightly more
honest about which strrchr the code wants (the kernel's, as it has
been since 2011), sidesteps the interaction with glibc's C23 macro
entirely, avoids adding a new libc strrchr dependency to the UML
binary, and is robust to future C23 const-preserving macros for
strchr, memchr, strstr, etc.

cow_user.o is built whenever CONFIG_BLK_DEV_UBD=y (the standard UML
block device), so this affects most non-trivial UML configurations.
cow_user.c is the only file under arch/um/ that calls strrchr(), so
no other translation units need changes.

Standalone reproducer (fails on glibc >= 2.43, succeeds on older):

  printf '#include <string.h>\nvoid f(void) { char *p = strrchr("foo", 47); }\n' \
    | gcc -c -Dstrrchr=kernel_strrchr -x c - -o /dev/null

Tested on:
  - Host:   Ubuntu, glibc 2.43-2ubuntu1, gcc 15.2.0
  - Kernel: v7.0-rc6 (3aae9383f42f); verified that neither
            arch/um/drivers/Makefile nor arch/um/drivers/cow_user.c
            changed between rc6 and rc7, so the fix applies and
            behaves identically on both
  - Build:  ARCH=um defconfig + CONFIG_BLK_DEV_UBD=y, clean compile
            with no warnings
  - nm:     cow_user.o references 'U kernel_strrchr' (not libc
            strrchr), and the final linux binary has no
            strrchr@GLIBC_2.2.5 symbol anywhere; kernel_strrchr is
            defined exactly once by lib/string.o and
            EXPORT_SYMBOL'd
  - Boot:   UML boots to Debian bookworm multi-user and graphical
            targets with a COW overlay (ubd0=cow,backing), which
            exercises the patched absolutize() -> kernel_strrchr()
            code path in cow_user.c

AI coding tools (Claude Code with Opus 4.6, and Codex with GPT-5.4)
assisted with debugging, test design, and drafting; the author
manually reviewed every line and executed every build and boot test
on the host.  Full disclosure was posted with v1; a shorter summary
is in the Assisted-by: trailers below.

Fixes: 2c51a4bc0233 ("um: fix strrchr() problems")
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v1:     https://lore.kernel.org/all/20260407164435.726012-2-michael.bommarito@gmail.com/
Review: https://lore.kernel.org/linux-um/1e15d25c23b444eae1dcfc01432e7ec1e19e25a0.camel@sipsolutions.net/

Changes since v1:
 - Per Johannes Berg's review (link above): rather than exempting
   cow_user.o from the global -Dstrrchr=kernel_strrchr remap via
   -Ustrrchr in arch/um/drivers/Makefile, call kernel_strrchr()
   explicitly in cow_user.c.  This keeps the existing semantic that
   cow_user.o uses the kernel's strrchr (no new libc dependency on
   the host side), and the source no longer relies on the build-time
   rewrite at all.
 - Reverted the arch/um/drivers/Makefile CFLAGS change from v1.
 - Verified locally on v7.0-rc6: clean build, cow_user.o references
   'U kernel_strrchr' (no libc strrchr), the final linux binary has
   no strrchr@GLIBC_2.2.5 reference anywhere, and the kernel boots
   to multi-user with a COW overlay that exercises the patched
   code path.  Full boot log captured locally.

 arch/um/drivers/cow_user.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/cow_user.c b/arch/um/drivers/cow_user.c
index 29b46581ddd1..ec8e6121b402 100644
--- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -15,6 +15,12 @@
 #include "cow.h"
 #include "cow_sys.h"

+/*
+ * arch/um/Makefile remaps strrchr to kernel_strrchr; call the kernel
+ * name directly to avoid glibc >= 2.43's C23 strrchr macro.
+ */
+extern char *kernel_strrchr(const char *, int);
+
 #define PATH_LEN_V1 256

 /* unsigned time_t works until year 2106 */
@@ -153,7 +159,7 @@ static int absolutize(char *to, int size, char *from)
 			   errno);
 		return -1;
 	}
-	slash = strrchr(from, '/');
+	slash = kernel_strrchr(from, '/');
 	if (slash != NULL) {
 		*slash = '\0';
 		if (chdir(from)) {
--
2.49.0

