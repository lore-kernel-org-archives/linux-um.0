Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5300606A886
	for <linux-um@archiver.kernel.org>; Sat, 14 Nov 2026 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jqhfIm/p;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nhG/03Y/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=uQximJwLYj6Lfa3XenE63rosMCyJlomCN9RTOM5F9N0=; b=jqhfIm/pqfZL7O
	9am0eIrlFSy3Osz0aMFCk2mF1B60H84cToHzk8gC6RKl9cmMs9dF5pvwT4XM2+XR/Z71lZJBSFZ3u
	k7/cpvvXvLKYqoJV7hDzC8gDmU6pGiYyoB/dED18oT76LPu9XVyqk2fafUenyhrF14SBsLr7ygRGD
	WKxMdAQG3E3sTFklAgU/SSUuaRyaNkpT7ltqUGGzzNmdbRTApCKqLSeS7reXszOFT4Vc81oTthlIU
	9UEbCRAURoeP6pdatnce1bO/6SOV3euVrVy77ukUiWB+ZKpHtf03vGARtne+Qx30WhmJsVSgWuZ47
	uRXFcwP+ZT+4wP8XRImg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSH3l-0000000GUs9-00Tu;
	Sat, 14 Nov 2026 16:57:01 +0000
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSH3i-0000000GUqf-3nfQ
	for linux-um@lists.infradead.org;
	Sat, 14 Nov 2026 16:57:00 +0000
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-3acc7a0b558so21654721fa.3
        for <linux-um@lists.infradead.org>; Sat, 14 Nov 2026 08:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794675416; x=1795280216; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uQximJwLYj6Lfa3XenE63rosMCyJlomCN9RTOM5F9N0=;
        b=nhG/03Y/yMPiiKD1PB/H07iK/MSrBbYh80Ly9b/M6cFwxkTfm+ai/aJEbeVqrWjrMg
         NEb9DmGRqcha1HsPA7VmXEoQsgi44b2mVcEZ0G4X91i1eM2xBsBTB2/772DhpdAMxb05
         YEPRlkQrh4UrmuS/Gd9uvqL9kF3vppZohDegNMnTXnsGOxC8Hly3qgudi3H9T5migUbK
         8mwLhdLyYcNkRSDqUfz+bjG0Rmju3ilrzt2tiPtVbAnRC+Q0fsd9oAnqPkModAJlOFY+
         P4Jvra24o9n34iHsE00NJSGFxSjhSSjvLkicsWEzC+sg13iOUlxxwbQ9UNFWYe9UU1mx
         Cj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794675416; x=1795280216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uQximJwLYj6Lfa3XenE63rosMCyJlomCN9RTOM5F9N0=;
        b=dUhidbWbBH1zDzlJtXD9qgWp1iPaNQnQ7q1Z84QruZHIBEBPjmxr+Wu5M6BSOcQBdx
         c/+nt4cXCTjxuu9SsJHaLLsnx4FmT7eny5mAIlgv4kQ5n7qG+IbJGgsTnuJaTePcTwJU
         xEcRYoutCj5uT4PBfnKv3zMtUxUyeuSDPNTWW5wXt7nvucPtI4lhMw8c6vOZ6qmQdshh
         U9Bt38wP80i48OOcquOKqRou82Ve8zIG7KqSNqIjSuPVgzHFsnA+MELi1m+4ojJwBDMh
         PzHi2kJfsBDC271P6MuftlnCWRxTVBCihzTjPPql7w4tnBoOOBz/X5zHjvE8k3GPDO37
         0E/g==
X-Forwarded-Encrypted: i=1; AL+hErHczQAGMS8OJEtun/Pb8KdBDlNpbsk4fDY74Phu4uT6Gl4U+n58uaER7f9Yp5mNCii64uNwdxOWaQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z/JpF77gDc5vk48Kln6ioJ1EE93Hy/YNLkD2RhGk7HEtZH1uaRo
	xX6NbYOimJs9bIwbE6/6wTzW3rG3NQBtfQPD+oaT/Vhc41It404ogPrH
X-Gm-Gg: AYBFou3kI0Y7Yy6PDwhwUGdaNXLzhxiBJ5m+ahfbFHFPfUPmcDzOAGAcz1uvZOBUsCP
	oYjSs/5Oy1xqHu3bKO2mowiJgNhfGweRJHtY11dANcVJ/0OBg40oQwmPDWGdFr0u2lh9PzX3Bnd
	ZoIB8goZzC1+Jz8OQF++oJzStEFyobfTICqwmm2QnIhnkGRzjzr1dvHKwow/fKWN80cuPKWepaT
	Is7/4EcCRyXxsPTaLFKKmJIFJvW0ogvv6uOL+RZ/NL6IsJRubIxMJ8MUzHAkHxpAoZcs9GWXjvq
	IByDET2/AKzA0Ragyf+cfh9Ech9N5HwgFGyY4oABGelak1FsyWaDOtVR5FxkrJ2w/CQLqN2OVTx
	9fUGqtlLSoFRcnWA4uONDN/JeUPNFQxP+EyXL4fw2XuJyjaV8oLa/ljvUCRQ5k6zHBc6BJOIKSr
	+tt/BCYPTS21JydezEnicVToo8vbOtwuwGUkPrneVLIg5/I29X0wKIimCvOosXfLUcoNA0DVITy
	OmaUF9VR+z6AOW9E6UiI1S3msBtAMrLvYGuA466pErkWaP/1/zeJKmXF+AFmd4v/6Hx4J4EyAM3
	3E6oJ7MxWLE2QS6pqFQ5ONzJPKFijJg16Dz2Nk5Tq2B39SCG5PJlIyxkFwLYcC+D82Fv+XLiKDf
	ZKzdNwjCdhQ==
X-Received: by 2002:a05:651c:b22:b0:3a6:95a:52a6 with SMTP id 38308e7fff4ca-3ae2b51fa1bmr19487401fa.20.1794675416400;
        Sat, 14 Nov 2026 08:56:56 -0800 (PST)
Received: from SafoStation ([31.40.65.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1712dad26sm1792051e87.8.2026.11.14.08.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:56:56 -0800 (PST)
From: Safocl Stollmannovic <safocl88@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH v3 07/14] x86: fix duplicate extern declarations
Date: Sat, 14 Nov 2026 20:55:47 +0400
Message-ID: <20261114165612.368785-8-safocl88@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114165612.368785-1-safocl88@gmail.com>
References: <20261114165612.368785-1-safocl88@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_085658_990601_1C06375C 
X-CRM114-Status: GOOD (  13.02  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Compiling a kernel module with a C++ compiler results in a "duplicate
extern specifier" error.
This occurs because the code contains `extern asmlinkage`, and `asmlinkage`
expands to `extern C` when processed by a C++ compiler.
Since the code already contains sections that respond to a C++ compiler,
I believe it is a perfectly valid approach to gradually move toward a state
where kernel modules can be compiled by a C++ compiler without any issues.
The `extern` specifier must be removed.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=222257
Signed-off-by: Safocl Stollmannovic <safocl88@gmail.com>
---
 arch/x86/include/asm/efi.h       | 2 +-
 arch/x86/include/asm/gsseg.h     | 2 +-
 arch/x86/include/asm/preempt.h   | 8 ++++----
 arch/x86/include/asm/processor.h | 2 +-
 arch/x86/include/asm/suspend.h   | 2 +-
 arch/x86/um/sys_call_table_32.c  | 4 ++--
 arch/x86/um/sys_call_table_64.c  | 4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index be58b7f5c..f5cb179b8 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -94,7 +94,7 @@ static inline void efi_fpu_end(void)
 #else /* !CONFIG_X86_32 */
 #define EFI_X86_KERNEL_ALLOC_LIMIT		EFI_ALLOC_LIMIT
 
-extern asmlinkage u64 __efi_call(void *fp, ...);
+asmlinkage u64 __efi_call(void *fp, ...);
 
 extern bool efi_disable_ibt_for_runtime;
 
diff --git a/arch/x86/include/asm/gsseg.h b/arch/x86/include/asm/gsseg.h
index ab6a595ce..81ef16081 100644
--- a/arch/x86/include/asm/gsseg.h
+++ b/arch/x86/include/asm/gsseg.h
@@ -12,7 +12,7 @@
 
 #ifdef CONFIG_X86_64
 
-extern asmlinkage void asm_load_gs_index(u16 selector);
+asmlinkage void asm_load_gs_index(u16 selector);
 
 /* Replace with "lkgs %di" once binutils support LKGS instruction */
 #define LKGS_DI _ASM_BYTES(0xf2,0x0f,0x00,0xf7)
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index d16d9c2f7..135695ae3 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -134,11 +134,11 @@ static __always_inline bool should_resched(int preempt_offset)
 
 #ifdef CONFIG_PREEMPTION
 
-extern asmlinkage void preempt_schedule(void);
-extern asmlinkage void preempt_schedule_thunk(void);
+asmlinkage void preempt_schedule(void);
+asmlinkage void preempt_schedule_thunk(void);
 
-extern asmlinkage void preempt_schedule_notrace(void);
-extern asmlinkage void preempt_schedule_notrace_thunk(void);
+asmlinkage void preempt_schedule_notrace(void);
+asmlinkage void preempt_schedule_notrace_thunk(void);
 
 #define __preempt_schedule() \
 	asm volatile ("call preempt_schedule_thunk" : ASM_CALL_CONSTRAINT);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 77488ff5e..68d7292af 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -455,7 +455,7 @@ static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 #endif
 }
 
-extern asmlinkage void entry_SYSCALL32_ignore(void);
+asmlinkage void entry_SYSCALL32_ignore(void);
 
 /* Save actual FS/GS selectors and bases to current->thread */
 void current_save_fsgs(void);
diff --git a/arch/x86/include/asm/suspend.h b/arch/x86/include/asm/suspend.h
index a892494ca..e29c071b9 100644
--- a/arch/x86/include/asm/suspend.h
+++ b/arch/x86/include/asm/suspend.h
@@ -11,4 +11,4 @@ extern unsigned long temp_pgt __visible;
 extern unsigned long relocated_restore_code __visible;
 extern int relocate_restore_code(void);
 /* Defined in hibernate_asm_32/64.S */
-extern asmlinkage __visible int restore_image(void);
+asmlinkage __visible int restore_image(void);
diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index 51655133e..f79c0138e 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -9,7 +9,7 @@
 #include <linux/cache.h>
 #include <asm/syscall.h>
 
-extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long,
+asmlinkage long sys_ni_syscall(unsigned long, unsigned long,
 				      unsigned long, unsigned long,
 				      unsigned long, unsigned long);
 
@@ -28,7 +28,7 @@ extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long,
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
 #define __SYSCALL_NORETURN __SYSCALL
 
-#define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+#define __SYSCALL(nr, sym) asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_32.h>
 #undef  __SYSCALL
 
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index 943d414f2..555e65e66 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -9,7 +9,7 @@
 #include <linux/cache.h>
 #include <asm/syscall.h>
 
-extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long,
+asmlinkage long sys_ni_syscall(unsigned long, unsigned long,
 				      unsigned long, unsigned long,
 				      unsigned long, unsigned long);
 
@@ -24,7 +24,7 @@ extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long,
 
 #define __SYSCALL_NORETURN __SYSCALL
 
-#define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+#define __SYSCALL(nr, sym) asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_64.h>
 #undef  __SYSCALL
 
-- 
2.56.1


