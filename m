Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FFBFF5125
	for <linux-um@archiver.kernel.org>; Tue,  7 Apr 2026 16:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EVD3gsLs5pyKc/GN8/ouN0bgbaQzwLmJCimCeB/EV+Q=; b=N2JTyKpbekwTOh+n0j6bOyjm8v
	MOmgyKjKwLm13p5EZJ6dkI4rsUbEKIabgfqkqBbXh65+w2w95RjHlxA+elai/1ABqj30FUzWlkL3B
	mcpGb09yCP8DsMbrgboYJOCNHt8jIY6vVFC1qSzaxKNdMAB/CMUCEZ/0PchuEbYqXlVKGvxtYVVuu
	4vG4QwIZw8I/w0c55rpfDbxtbJWg8sFCj4/T8w9PAHuhDRAGUqvErh8wUUECXNkX/otgf8tL5RSgi
	+mZxJ0zCRjQ1f3OKjrS5myrVNGQnGigl0xkp5oWKrpah8AuPUZw1cOwUf0lcyuHkMrvxbGaKmVYm7
	AVgc64wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA9YV-00000006oV3-0Bse;
	Tue, 07 Apr 2026 16:45:35 +0000
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA9YQ-00000006oTy-27MR
	for linux-um@lists.infradead.org;
	Tue, 07 Apr 2026 16:45:33 +0000
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-8a56ca653ceso56344106d6.2
        for <linux-um@lists.infradead.org>; Tue, 07 Apr 2026 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775580329; x=1776185129; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVD3gsLs5pyKc/GN8/ouN0bgbaQzwLmJCimCeB/EV+Q=;
        b=kiEeVjll+18/bB7xM92qK1BvgK6mJVs98D3CYoZSFElnJZvCOcc0/BMn/8JK7jHjCB
         RbkzIz8yfD2Zl9Kayv4HtIabDA+1++myAVckJ2BMSjaNZee+h/A0aIRd+mvU07fQN6jN
         Nkefnukn6qMSF0Asl7LqpCWB+NvsNFoXG9MjbxTHKwK5/uFKIaL/vBsqJ+4jQTFA+jR+
         FjVxAq3e9Yxeqt4dKHtgXGPgB2zCboTFUdnq7sYgyg9XQU/GPkCTarXd03pjx9YIOp2s
         oQOolsleerNtPo8Hpu81Fleg+5mgNcGD+OzHeXjcVpQ4RmHT77J46s5zPGwvtgAYK9Vj
         RQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775580329; x=1776185129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EVD3gsLs5pyKc/GN8/ouN0bgbaQzwLmJCimCeB/EV+Q=;
        b=TEJRbOyhL+cFIMdnjtn0r7Hu2E1GyY0AM7fQMegUppzlJJbbodB6g8vyvcZTh36GxR
         53qtxdqDO+zt+osP2iHtabp5Z/GOASsfI9toRf/+/d7rR3vn44uFQFSHqj4eHEf4LWGH
         ZrJsUhS1B2AY1e76qyQCz7Z+g5Fh3OWWIbjNwsxcL/HOXB2PpELDZzzifqIgYGP7MBTj
         us0Pyuh0PVHh9MSt4s3RGd1fw4GFXDw15pe2ng4XdVjLyBg11N4oJTMpNWbZV6fT5cn0
         4T7/P2xuQkz+gjRwoq5DOkNJX/7WNnlxLLckTuBBEJ/010xsQ5RwfRiQsFcCEb+Zhw8e
         YaoQ==
X-Gm-Message-State: AOJu0YwBC9foSTLM3KGJP0z4NvohLGnybmJCRSi4/MFHytpU6/K3JODJ
	srCe5Z/AfjtSTDw9lCjvugM1IU9phv3VCq6VCcQWzrILv78rxVv4+OjU
X-Gm-Gg: AeBDievxCO6seQmlGr76ou1PT1wBFJorCUGLF3ep9axxdJ0MxqqjrC4T7/YRAYXjMon
	G0Zh9HuWa3TkanyC/fCtLIWPC0NY6kxQvNUNEQ3gCmHfnP0LwdUJ5V4erf8myjSaS0iCYMTN4KI
	6EBayqIR+Kpyf/2AtSZeqbpuFrkuNBhimbjmVSYwWriG7friSnWV2LwOe8nSmbJl6GBU5l7xbkW
	SN11GGCZICGs7/L1njd8+222g7ZginUyuyRxSiaRlDZBZDW5HdzFec7FN7Ex7j8/HNCBexVjQ55
	DXLpwmWHFbUjTr+2hVFEVGoP8bBsaYVYv/z0BVvA3CsLKHdksBITyuhavblbTJH2yhZ51oR+POY
	5jUmCykti2aGGeDDuJuKX/XeJyV4GJ/RKHCRdVxgxCnqYF4Y3HORxjZbxQvfKEf9Tim0QNFVN3D
	HkgOCwH9Mjei6MOpkFtxtt5A4AfE10IPNiSv6TRoP0ZSwCM2gcZPf0rEbxFj1/h5lx4m4isE31m
	LLQfTjLYWPSi1WtsM33GJWsYD0=
X-Received: by 2002:a05:6214:258c:b0:89c:d50e:b57 with SMTP id 6a1803df08f44-8a7023c032dmr293344546d6.15.1775580329106;
        Tue, 07 Apr 2026 09:45:29 -0700 (PDT)
Received: from workstation1 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aa70136e87sm62044156d6.22.2026.04.07.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:45:28 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] um: drivers: use libc strrchr() in cow_user.o
Date: Tue,  7 Apr 2026 12:44:35 -0400
Message-ID: <20260407164435.726012-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407164435.726012-1-michael.bommarito@gmail.com>
References: <20260407164435.726012-1-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_094532_198565_AC63B521 
X-CRM114-Status: GOOD (  13.01  )
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
calls libc strrchr().  It inherits the global -Dstrrchr=kernel_strrchr
remap from arch/um/Makefile, which is intentionally kept in USER_CFLAGS
to prevent linker clashes between libc and kernel symbols.

This combination was harmless until glibc 2.43, which added (glibc
commit cd748a63ab1a, "Implement C23 const-preserving standard library
macros"):

  #define strrchr(S,C) __glibc_const_generic(S, const char *, strrchr(S, C))

The glibc function-like macro replaces the -D object-like macro.  The
inner strrchr token in the expansion is protected from recursive
expansion, so it refers to the bare symbol strrchr -- but the header
declaration was already rewritten to kernel_strrchr by the -D.  The
result is an implicit-declaration error.

The remap was originally added in commit 2c51a4bc0233 ("um: fix
strrchr() problems") to resolve a linker clash when both
CONFIG_STATIC_LINK and CONFIG_UML_NET_VDE are set.  Recently, commit
a74b6c0e53a6 ("um: Don't rename vmap to kernel_vmap") trimmed
the now-obsolete vmap remap from arch/um/Makefile and updated the
comment to explicitly call out -Dstrrchr=kernel_strrchr as one of the
remaps that still prevents libc symbol clashes.  That framing is kept
here: the global strrchr remap is still needed for kernel-side
objects, but cow_user.o is host-side and should use libc strrchr
directly.

cow_user.o is built whenever CONFIG_BLK_DEV_UBD=y (the standard UML
block device), so this affects most non-trivial UML configurations.
cow_user.c is the only file under arch/um/ that calls strrchr().

Fix this by undoing the remap for just this translation unit via
per-object CFLAGS.  In UML's Makefile.rules, CFLAGS_$(basetarget).o
is appended after USER_CFLAGS, so -Ustrrchr correctly overrides the
earlier -Dstrrchr=kernel_strrchr.

Standalone reproducer (fails on glibc >= 2.43, succeeds on older):

  printf '#include <string.h>\nvoid f(void) { char *p = strrchr("foo", 47); }\n' \
    | gcc -c -Dstrrchr=kernel_strrchr -x c - -o /dev/null

Tested on:
  - Host: Ubuntu, glibc 2.43-2ubuntu1, gcc 15.2.0
  - Kernel: v7.0.0-rc6 (3aae9383f42f)
  - Build: ARCH=um defconfig + CONFIG_BLK_DEV_UBD=y, clean compile
  - Boot: UML boots to Debian bookworm multi-user target
  - COW: UML boots with COW overlay (ubd0=cow,backing), exercising
    the absolutize() -> strrchr() path in cow_user.c

AI coding tools (Claude Code with Opus 4.6, and Codex with GPT-5.4)
assisted with debugging, test design, and drafting; the author
manually reviewed every line and executed every build and boot test
on the host.  Full disclosure in the cover letter.

Fixes: 2c51a4bc0233 ("um: fix strrchr() problems")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 arch/um/drivers/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 36dc57840..e387ae33f 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -49,6 +49,9 @@ obj-$(CONFIG_UML_PCI_OVER_VFIO) += vfio_uml.o
 # pcap_user.o must be added explicitly.
 USER_OBJS := fd.o null.o pty.o tty.o xterm.o vector_user.o
 CFLAGS_null.o = -DDEV_NULL=$(DEV_NULL_PATH)
+# cow_user.o is a host-side helper that uses libc strrchr(); undo the global
+# UML remap to kernel_strrchr for this translation unit.
+CFLAGS_cow_user.o += -Ustrrchr

 CFLAGS_xterm.o += '-DCONFIG_XTERM_CHAN_DEFAULT_EMULATOR="$(CONFIG_XTERM_CHAN_DEFAULT_EMULATOR)"'

--
2.49.0

