Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1306360A2618
	for <linux-um@archiver.kernel.org>; Fri, 13 Nov 2026 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BqzGcvTs;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OGkFXR0+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Hw8SAjAXtby0kF3LHANcoNGHydVlujl/8fA/+KaplxI=; b=BqzGcvTsLhzJJo
	0IQ9i8RtAD3z8JETG62996ZFDGYhOsWIZOiSVj6IIM4nk3wVn3bb96ZL8BdP/Fa+QkVzwyTR5LOYE
	GJhkLx/eJx8cTkXBihTiVWmUjJqq++YbXotdk01fiCkFac8v36N/rC9cSuddcSfHeGGPWUXzaPSr/
	e6oUVN+4E7ZOcfSf+V5pTp8hEptj3R4yIEpqFFTgTT/n18Jsz8FszlJa6H743xf6eVM3x4ysxZQ0b
	PXPb3CiIyQDwFA17xC6ClDcTeWpYK0303Jq9m+3/pcQosK9S3E0B84C9APJfzFrpSnAPzRrhl5Bt9
	udk0lBdIIVJUjSCdh3fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRex1-0000000BIBE-0Fp7;
	Fri, 13 Nov 2026 00:15:31 +0000
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRewy-0000000BIAC-1Ipt
	for linux-um@lists.infradead.org;
	Fri, 13 Nov 2026 00:15:29 +0000
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5be3cff0f6cso349468e87.0
        for <linux-um@lists.infradead.org>; Thu, 12 Nov 2026 16:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794528926; x=1795133726; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hw8SAjAXtby0kF3LHANcoNGHydVlujl/8fA/+KaplxI=;
        b=OGkFXR0+lrtzgG7fmA9ZdwWLszth9MaKwIfHAcdJ5Zls35ba2CEaOsXWdPf3+dKWkb
         B5dDPAsQ7iCMqT5dQb7esf7E4LRdcU1l5EUtvv3OrUUZ0IzgjXPCLs7QbomvCYlj4UPp
         +PdY+354sXXKjUrcY7F03q+VGQp5OecU1IfRJSoKGH5QbS0bz3R4RY4n1ctQAPp1kIlN
         cO9kGvdfAcYJ+ytlIugzi6sj72jLXnquiIKYecII6UkZ0K1ndrv7Ev2hs3Jjrk+u2gUi
         lezL63jmBUJMqURnFexcVxQipmMWt4whi17txu5Kw1BEO3yQLKrahqDYi5WJiMx/ct0i
         0edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794528926; x=1795133726;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hw8SAjAXtby0kF3LHANcoNGHydVlujl/8fA/+KaplxI=;
        b=RFbpAT3ylKm0zRSO+qLt1oWXGu8g9TfUMsDq31m43BZa/SZDjT7gv6kJvQ5qVhj0Fp
         hCZA878jtrjtdYANJCKAMhT8h9ZO7VYmUkhtj+EzjLWFJcz2H5G+wz35JLZIzX+63w8E
         W1nWevpcohMYWY95fnL8YjZLgEXi4TOX8Yc+4ECmbzjebQfUvpqkaLH/fX/Y2eUNdQrK
         6qFKnjAyurnXNE+E0AcyyFNLLQ6i6YiYE+OvZa/PSKLKx+uhgQ34RYMNmSe/un7d/ufn
         s6igKDUI5EWq2SWQtqPAPVFIgFQfjT4/iUS2dZEqreWAxWjL4IsViVgZvd16gNCap8pS
         o0zw==
X-Forwarded-Encrypted: i=1; AL+hErG9+CyebQ6Rooqn0ac35E+kIh6Q0inrTbZNe5qNImlqxNXN7FRZPYNLiHPI80YNR3Xc5qSWH85rCQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z/xPXORkweIIknmowNHjfXzyualpgUyMoe1D2vm/QdUQ6INg1w+
	j8j9++jxthFJ3XWwObRi1+vOT/4rBKCmmuXi/ayJ9xW0LEkxivgNsvZC
X-Gm-Gg: AYBFou3RHMVuYUAjfGM1blu3nPxRBf+Ua9BOVzB48OCwOQierg1OuhpvoVj1drXQgqG
	Cv5X62c4YQjLmvN8yi1HthHCqnRiTzEU6wNrzldqGPnByNT2ha5l1sJ757fxLwYZdohTOSxCk5r
	s0PwQRAzexAq/2Ti+Ve4VUpa7ILvf9qOZJVzKogx8OicMafz3wT+VXdG/bvtCNSW9I100NxCPe8
	QCNdFpzYXjWqPjzQ4rsZ2lF0V/tosYk8cuhyYnPgQUKp5U29fH6+M2stO0Q6ZNSwtPbXYKih+8f
	NYsstChYWlOF3PW3QbO4xab28At/nZfnoeaZ+kpORI7dosXgCK/SE8WpfhFHR8nIiresO6n9+PM
	ddCK/Jz5xG75Obt4MIjm3k4oKeI0rCiqLGrOX5oe7PNIm1jqU9rtyN98xymiQ1Md4GskkuFcF04
	COQmnR9drtjj8aOjtr8InVMSrdrC6bz9VaCQAcm+QUy8V99hLOmB+I09HbH7qyw2N8pi4OK0z8D
	RHue9CnYsTxOz+GjHBDsIU2hqRdGckcyiL+yCAMrc/d8BVbYbr4P4BXPMZAHc/NLXyn6IvaD5qz
	L7ZuzZy3+7FkH/PMsP/JtOsRSRBDw49wAivvOzvHO+wUJHcK3UkC3y+dcWLjVALyvzzAC6YjdVM
	GEEBdvfzjdw==
X-Received: by 2002:a05:6512:b06:b0:5c1:4a42:fb08 with SMTP id 2adb3069b0e04-5c1709cef9fmr362467e87.34.1794528925964;
        Thu, 12 Nov 2026 16:15:25 -0800 (PST)
Received: from SafoStation ([31.40.65.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17133ca01sm200968e87.36.2026.11.12.16.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:15:25 -0800 (PST)
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
Subject: [PATCH 07/10] x86: fix duplicate extern declarations
Date: Fri, 13 Nov 2026 04:14:13 +0400
Message-ID: <20261113001432.128201-8-safocl88@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113001432.128201-1-safocl88@gmail.com>
References: <20261113001432.128201-1-safocl88@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_161528_392132_54BB27CA 
X-CRM114-Status: GOOD (  12.86  )
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

Compiling a kernel module with a C++ compiler results in a duplicate
echo ‘extern’ specifier error.
This occurs because the code contains , and
expands to  when processed by a C++ compiler.
The  specifier must be removed.
https://bugzilla.kernel.org/show_bug.cgi?id=222257

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


