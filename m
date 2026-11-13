Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5BC60A2611
	for <linux-um@archiver.kernel.org>; Fri, 13 Nov 2026 01:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nUawD959;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ufA04P4O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=c/cWqKIWduZoLOjk/RHPTZ+tnDRCPdJt/8RzdamyTqU=; b=nUawD959XcWA7V
	L1b6UTrTbjo3V/2Ld5JlpCgCJ0K8u7f6SAKuHm5kbwVP/cq9j//W6OkYf4M9QXPnLzBoExlX/qQTx
	mLjyYdhJRkU1XYUEWoNoQsPBBTi5pn6V6sVXfn5Q6ABd5vtb2RHI5z+xpmcK6aM9d6OwMjQuf/D9Q
	JT30wk5Q415CJa4ofPvuCq9GyZ8AbraaDH3YSlq3FwP++sEJhydlS0QY289DfKD39U/qm/wfFheZS
	36/ACrf4oUc+9rcFq67Ps+uf5pzemwqq5RAQ3DBF+VnXe0IsUpPngyqY4dwKgUwodaTIb+eJsn8tV
	/DRmnR0xtAUi8KdGn7nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRflE-0000000BPPp-1u92;
	Fri, 13 Nov 2026 01:07:24 +0000
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRflB-0000000BPP0-1DBY
	for linux-um@lists.infradead.org;
	Fri, 13 Nov 2026 01:07:22 +0000
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-3acc7a0b558so4371251fa.3
        for <linux-um@lists.infradead.org>; Thu, 12 Nov 2026 17:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794532039; x=1795136839; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/cWqKIWduZoLOjk/RHPTZ+tnDRCPdJt/8RzdamyTqU=;
        b=ufA04P4Op3GUNfbvI0MirlhXAzR9qsyKnrGiPa1XZEJGcVkDFxr0i9oejKMf+RzHWV
         QPpFULbD9EddrLTa//hjVa/pPvjILlPqpXbHBiySwaaW8aXQC1xikZc/3FKT0N0B0pnf
         EoA69l78kE3kCxoZXg69T9QrwTIjyu0LD7ZVv14WtBfgTFeD6G1WDQf2MQIddSiEn9bi
         AFrKYLCrqP2ML5e0nOOg4TPHEV77pQKSYIRfiY7HJefUazZHhimpbGCn8OTfFUSMW6yG
         Msf5mWHuY0VmaDNSBUXxcmzIJNnOhcBo5uB9fuPgO8jukm5IotYOzMKWDhEmRTJhkg43
         0/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794532039; x=1795136839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c/cWqKIWduZoLOjk/RHPTZ+tnDRCPdJt/8RzdamyTqU=;
        b=1lU9Vwpq+IdrlUdgSuRf1KvBJte9m+K3uP88LOTLxvCthclovWwG1OxYv5EljQ2TL5
         bO1MdPXFQBg5J67OhwpHIEHqHt+Qh/MVo+dWmaKbzvqaWHnbdbCc8cxMySgUtkl5nhr3
         261hchbgDvMThFCNApUO1slzFzYnj4+qOboX+Inet2bZbsZYa/hw5py8weYaq/ZJEqJ1
         VZ/68ij3cK8U5dKwi7d3IGVBk2hYX6bC5TPHEhLj0nGQ6wye7vcpBCBpev8G6Vs2Spcw
         ahg+MHaT8NFS/cZ9JamwGKogOMO2uQuhGGSpcELNOG7jU8OPiAtD9f5ZNN9kjjUuktB/
         livg==
X-Forwarded-Encrypted: i=1; AL+hErEJVMNcnODjLJ+NUa5H1QtMBnRc0TUTZiA4nP/vgpEwP4Y54f8R5/Pg5f4oa7qnYgOmGmJ0u8XLCA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/T4PNYlwasA/81fhUNUtgesCsH10zcILoaQqiISGkDB9WDyluQ
	l61XJFC5KhxPN4DkfhgHuhZ+GWsQpAYo25OifRDEAfd3T0k0Hyrl8dTl
X-Gm-Gg: AYBFou1p0YV3jljWSZZ96XyKyLZCja/0mneVnn07FHrERcJkAD3qMb6AGNxEb3i9Zql
	m+zSTZYoRabqQDRwTH55xbAJTrAwb5hH7FRa54Ftk7DzAqg/5hUpAJ1aWDGpYiT41JQ9DzuHv8z
	fI2NoE+ShNOgThAExNFaHzKNYj1ItKLVTmO7ABnCzgKFvJCnm7RQjEE6oUYlX9VuA2c06Jux8y9
	QkJqcgrzOvbOQTRVm6IVTr3CGxoAg5fVlCU9vDIivdcMP5bsCVeKzyqVT/tfs4xQqpeepglel12
	tlslIbpqsP4lm4n48O5RZ86M9o6PKX5yEoWgsd2ISB3gaTK07JF7Pfef3pkusV0J3o6AwVzx255
	ytK5u0StIvnBQcby3ZS47CN/Ea+92IKy84XIfglHJtExkZxAdTga6qRZcNv4KEt5q8wB4CPbxb0
	oRPzhjSH25Q8cSUQV0qvhBsq/39V0MAmgQaYaPqQI3VgXZuYHJBLteLeH4naXrpbTOgQ73N1Ubn
	pBndhEAym4sVt40I2a3xMdatAX/HFE5C/M4Q++rVKCmOWCH/PUtTJVtpPSLUw3mzodG8UY8t0Ly
	5MYAyRKwlNbiltmlLzshSzgHAHUHwFFWugul6poWeR+L4Lxhd/pIBUu5j3dmrsn3QpabCC7+9We
	f7ne8NcnvxQ==
X-Received: by 2002:a05:651c:a348:b0:3ac:dda0:efdc with SMTP id 38308e7fff4ca-3ae2b5074cbmr3651751fa.16.1794532039095;
        Thu, 12 Nov 2026 17:07:19 -0800 (PST)
Received: from SafoStation ([31.40.65.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae2b7d183bsm3133941fa.31.2026.11.12.17.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 17:07:16 -0800 (PST)
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
Subject: [PATCH v2 07/10] x86: fix duplicate extern declarations
Date: Fri, 13 Nov 2026 05:06:12 +0400
Message-ID: <20261113010631.139191-8-safocl88@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113010631.139191-1-safocl88@gmail.com>
References: <20261113010631.139191-1-safocl88@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_170721_371814_968083AE 
X-CRM114-Status: GOOD (  13.32  )
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


