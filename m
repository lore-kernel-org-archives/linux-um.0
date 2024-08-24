Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4C6C52D6F
	for <linux-um@archiver.kernel.org>; Sat, 24 Aug 2024 23:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eplaYsiiWgCTy5PRkFB4ff2nqvq9q3OfHUIofrtUZ0k=; b=Qh8tl7gJ6fFHu+L8Taa0GjAY5q
	VftTLdZCYnV7bPw8vBxZx0wyOm/YN7VxDgKr0xIZhG0o5C8GrOdRq00teWwZ1ysCkZ2IzW7oc2+kw
	QUfdrIqr5i2opl+hFKr41Xe1fgQTHZFK1nFmS3C26lxFJmDU1vcs2OeWHL1E4PSq+HA1WKrJbfoK2
	cQTgHHwJXiDtEriK6gBddq0HmJ7+KiUqFFAOu6N8z+9+zLMQsGJAsX6/2r5iFjb/8j5dhE07BdoRw
	p276I9LLZ/0XkNCb3HqmUq8bI6+GXqIrQW11uMtvzkwa4juY76jy4blV1Lin3DXlSbzAHRVyD6Bd/
	QXn0XOfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shzqt-000000034ON-49gw;
	Sat, 24 Aug 2024 23:07:24 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shzqr-000000034N1-1IzV
	for linux-um@lists.infradead.org;
	Sat, 24 Aug 2024 23:07:22 +0000
Received: by mail-io1-xd42.google.com with SMTP id ca18e2360f4ac-824ee14f7bfso121552139f.1
        for <linux-um@lists.infradead.org>; Sat, 24 Aug 2024 16:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1724540840; x=1725145640; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eplaYsiiWgCTy5PRkFB4ff2nqvq9q3OfHUIofrtUZ0k=;
        b=0O6211Y3eynwHeDeRNa7dzsjhpDNxiDYv7CEeyBUSKXN0EAAzRdHNuXBNprRIF6dff
         kgvnypTSTDK7EtkqGy9NrnFlgdV0USsX3S/DKGOs/p+kSC2Gyvcbuf7UhVBWmZM1dh65
         Y/r8GtDvgawra8pXuieFlZkeoR3a5grj3gmPWXKDq7z49pJvE5/uLYSt5HweSNPreM4m
         Gwg9WJxkNSwTSJb1AtGVkPMFlHebdKCcf5K5v6ZU5CJ3hVQiqaS4jFzlg1Ozp0Du2mWh
         Lyl1mMf0cA24bmxA0gpuRCiC9v0Q4QLGxaszgTeuPUuF+4JOUrWN4Yo6+NzgWicMFaNf
         Fe2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724540840; x=1725145640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eplaYsiiWgCTy5PRkFB4ff2nqvq9q3OfHUIofrtUZ0k=;
        b=eUMuBm4mG90e0dIlcRV6N94ANYVjApczQyrteypjdJm9Zj7VjzGooixY7ZroKhMClS
         7jCeIFdhoJQ0FogmgWzSFT820o9+C1OihEasSRbgrDRQE0rf4MUkUwDEpoTyabqZyfR/
         DSw9mhzTndjO3cVkCF7oLQBPoMlCyEGSxeZ30zXaZyKCw1vRs3Zg7AAuq+hQz6ZYvXqo
         T1Jv9+suGZl68XRHejMKxK3hs+RPHR7UymAIqH5AQV/8LV8J9movWwky7kULkzSe3v10
         WRc9jnHpYU5LF7fVMY9PWVCu9Lkvg8Zq5C5s1sI1ItH0xT1r5LaocdygwvqdwEmaf5tP
         Tx9w==
X-Forwarded-Encrypted: i=1; AJvYcCVK7Mz8Y5QgPi5tVoExWnXOmDBUDCl/ISZqPpkWdVUCJUvuGNeC89DR0jceo1Eh0M2AcY58tKMdkw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxCaUPrkbtcr0Dc1IZPQf2TiZt68JIPXpjFFaIuyH5vTvvtOXBO
	2klH7t19PkOq13FqMJ2Q0blqIlV26cV7RjOkYfn9Ac5YO5Dk2JmdWyTA455V5g==
X-Google-Smtp-Source: AGHT+IGMHgrjxuTK1IXh9WwnvBXGAgm3x0MPaDSYXa/O8CNdJcXDMS3NKmaFRHTenHG7ThmwiB9kVg==
X-Received: by 2002:a05:6602:6b87:b0:804:2b28:75db with SMTP id ca18e2360f4ac-82787329bbemr590220339f.10.1724540840544;
        Sat, 24 Aug 2024 16:07:20 -0700 (PDT)
Received: from shizuku.. (mobile-130-126-255-62.near.illinois.edu. [130.126.255.62])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f85671sm1563938173.80.2024.08.24.16.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 16:07:20 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	x86@kernel.org
Cc: wentaoz5@illinois.edu,
	marinov@illinois.edu,
	tyxu@illinois.edu,
	jinghao7@illinois.edu,
	tingxur@illinois.edu,
	steven.h.vanderleest@boeing.com,
	chuck.wolber@boeing.com,
	matthew.l.weber3@boeing.com,
	Matt.Kelly2@boeing.com,
	andrew.j.oppelt@boeing.com,
	samuel.sarkisian@boeing.com,
	morbo@google.com,
	samitolvanen@google.com,
	masahiroy@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	ardb@kernel.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	arnd@arndb.de,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	oberpar@linux.ibm.com,
	akpm@linux-foundation.org,
	paulmck@kernel.org,
	bhelgaas@google.com,
	kees@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	kent.overstreet@linux.dev,
	nathan@kernel.org,
	hpa@zytor.com,
	mathieu.desnoyers@efficios.com,
	ndesaulniers@google.com,
	justinstitt@google.com,
	maskray@google.com,
	dvyukov@google.com
Subject: [RFC PATCH 2/3] kbuild, llvm-cov: disable instrumentation in odd or sensitive code
Date: Sat, 24 Aug 2024 18:06:40 -0500
Message-Id: <20240824230641.385839-3-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824230641.385839-1-wentaoz5@illinois.edu>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240824_160721_380931_0AF43632 
X-CRM114-Status: UNSURE (   9.96  )
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

Disable instrumentation in the same areas that were disabled for
kernel/gcov/

Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Signed-off-by: Chuck Wolber <chuck.wolber@boeing.com>
---
 arch/x86/boot/Makefile                | 1 +
 arch/x86/boot/compressed/Makefile     | 1 +
 arch/x86/entry/vdso/Makefile          | 1 +
 arch/x86/platform/efi/Makefile        | 1 +
 arch/x86/purgatory/Makefile           | 1 +
 arch/x86/realmode/rm/Makefile         | 1 +
 arch/x86/um/vdso/Makefile             | 1 +
 drivers/firmware/efi/libstub/Makefile | 2 ++
 kernel/trace/Makefile                 | 1 +
 scripts/Makefile.modfinal             | 1 +
 10 files changed, 11 insertions(+)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 9cc0ff6e9067..2cc2c55af305 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -57,6 +57,7 @@ KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
+LLVM_COV_PROFILE := n
 
 $(obj)/bzImage: asflags-y  := $(SVGA_MODE)
 
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f2051644de94..86c79c36db2e 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -43,6 +43,7 @@ KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 # Disable relocation relaxation in case the link is not PIE.
 KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
+LLVM_COV_PROFILE := n
 
 # sev.c indirectly includes inat-table.h which is generated during
 # compilation and stored in $(objtree). Add the directory to the includes so
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index c9216ac4fb1e..d9587b3b6bf2 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -156,6 +156,7 @@ quiet_cmd_vdso = VDSO    $@
 
 VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 \
 	$(call ld-option, --eh-frame-hdr) -Bsymbolic -z noexecstack
+LLVM_COV_PROFILE := n
 
 quiet_cmd_vdso_and_check = VDSO    $@
       cmd_vdso_and_check = $(cmd_vdso); $(cmd_vdso_check)
diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index 500cab4a7f7c..a07852e8f3ae 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 KASAN_SANITIZE := n
 GCOV_PROFILE := n
+LLVM_COV_PROFILE := n
 
 obj-$(CONFIG_EFI) 		+= memmap.o quirks.o efi.o efi_$(BITS).o \
 				   efi_stub_$(BITS).o
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index ebdfd7b84feb..b4e619114898 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -28,6 +28,7 @@ PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
 LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
 LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
 targets += purgatory.ro purgatory.chk
+LLVM_COV_PROFILE := n
 
 # These are adjustments to the compiler flags used for objects that
 # make up the standalone purgatory.ro
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index a0fb39abc5c8..d36338bfa2ce 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -67,3 +67,4 @@ KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
 		   -I$(srctree)/arch/x86/boot
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
+LLVM_COV_PROFILE := n
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 6a77ea6434ff..3ea2f5d123fe 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -60,3 +60,4 @@ quiet_cmd_vdso = VDSO    $@
 		 sh $(src)/checkundef.sh '$(NM)' '$@'
 
 VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv -z noexecstack
+LLVM_COV_PROFILE := n
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index ed4e8ddbe76a..b8224ff291d9 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -62,6 +62,8 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 # `-fdata-sections` flag from KBUILD_CFLAGS_KERNEL
 KBUILD_CFLAGS_KERNEL := $(filter-out -fdata-sections, $(KBUILD_CFLAGS_KERNEL))
 
+LLVM_COV_PROFILE := n
+
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 057cd975d014..0293acc50afa 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -30,6 +30,7 @@ endif
 ifdef CONFIG_GCOV_PROFILE_FTRACE
 GCOV_PROFILE := y
 endif
+LLVM_COV_PROFILE := n
 
 # Functions in this file could be invoked from early interrupt
 # code and produce random code coverage.
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 1fa98b5e952b..4fc791fff26c 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -22,6 +22,7 @@ __modfinal: $(modules:%.o=%.ko)
 modname = $(notdir $(@:.mod.o=))
 part-of-module = y
 GCOV_PROFILE := n
+LLVM_COV_PROFILE := n
 KCSAN_SANITIZE := n
 
 quiet_cmd_cc_o_c = CC [M]  $@
-- 
2.45.2


