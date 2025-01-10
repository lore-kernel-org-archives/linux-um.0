Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FA4E7719E
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 20:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lGjVOQFY6aPZLutIkt8TLO/unqgXoc0/gnPdxCEE5wQ=; b=VNG55ZU+0Z5i/hwQFCSN7rigX+
	Pxmf4ZAZfTkoKQTR1vQ+URPE7KEdjv4qSFMKt3A1U4873q4Yz0EIsOuK2oFjnqDdrRoybW4yCxKfe
	l7g9CnZ+30yMKHpQk57WEc7Oiow76mLabBOxI2ykkJ5nE7B2x2L8IjMw6XVNUErMZci1mZBkKMrEi
	KIukUxzJP2X1Sq5hhkEpsofnqxl3nwLDhYd2/0VG5N1whOzvV6H7DJ7wCx31p8ziVr6hy6n2JUzQq
	Bmr/10G8H6bbdPzr5lozetIpAzl5oFtO/0Rfrsfvhcikl3g7C3/kXgME1GthNfBJkv0mYzAdalSR+
	aFFXNB4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWLZF-0000000GtMB-1eYD;
	Fri, 10 Jan 2025 20:25:17 +0000
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJx2-0000000GbuB-0GMi
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 18:41:45 +0000
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-3862a49fbdaso1017610f8f.1
        for <linux-um@lists.infradead.org>; Fri, 10 Jan 2025 10:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534502; x=1737139302; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lGjVOQFY6aPZLutIkt8TLO/unqgXoc0/gnPdxCEE5wQ=;
        b=zoXRU8UUh1kQFFLiNfZGOwE+smSwVfPKj2TX9nfQTt1rgOfESD4se8Z0rCw0pGgubB
         DBbK+c6QjHUYevfwcweI1Wh/TzC3H7SjHt+ITFHdBF/dxA9ndQhCo2TulsYduguFE/yQ
         yBv3+BtEXbCBowTB6xzoNfs1EDMKibh5Dx21POGn6ieA0OlbT83Az8v/NTZ+rVDhri+I
         2fUCpGP1/9uvdBhH8CR5P/ZtRTfnY/gpiu2a3Ziht/mU/tCr2kuqKKFm+wgr/syxSBFM
         aRCP5xt7Mg7RObi01+gBsNKHsG5nSayix4OK9UCRXd8Gf7NWx67EsJx+CIsqFTTVDAI8
         iSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534502; x=1737139302;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGjVOQFY6aPZLutIkt8TLO/unqgXoc0/gnPdxCEE5wQ=;
        b=if+jMCY59XpyRzi6GOZwyDYTT5+bWt2SEXmubK55x5lFlMmDelnhsaADN+yn+jcblV
         y0ZUAKCkyDd13y5t2WSudYJR4O0JgcxyZIHWaNRW4cD7KbYQQYOH5M6yZRcRF7w5C442
         E8Lcmv5FXP1MmMuz+BDfLH6VydWl3+MJzDBxYQIJRoW8lidZCVKdqU3oRtki5ZrJBLMG
         e7jJ8ExwY5Rk7VM1L6j2JEk3am7nM9J2A1RAIPK2jn2Yv3Pcqp5BBCAy7Xe00SbB8TGd
         LEQIx5VJ//mJHCNk3kOz0nLSgvUBhTL/x6rYf+LTtxSoxzrP/InRK2aP05ifCZTksftb
         RyZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb3XphuX409quVK0JmzXS81rw2Igu+6aZi8w5axq84yUXJ87WN03OK8tTCa1Ui6Qd1fmMteKuhVw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx+ViyM//lM+/JutGozsJ0pMjD6ibUk5BTIxrx90KgOziHpoPTW
	UsqnDDTLrGIZbXiRPQXo8vWSMoAl81ffA96E5FBY7v4JeS5dxqe2JTEY61oneEWzwDQRv4/Ds1K
	VpU4EKMOGrg==
X-Google-Smtp-Source: AGHT+IEWN36a0RhRoQNfORq+2yO51X6txHS1Rw2POezO/cSMdMR6AN2SOjOPPnxrT0b5W7xr5QSy1CVP6p9cPA==
X-Received: from wmqa1.prod.google.com ([2002:a05:600c:3481:b0:436:1995:1888])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:588b:0:b0:385:df84:8496 with SMTP id ffacd0b85a97d-38a872c9432mr10863969f8f.3.1736534502226;
 Fri, 10 Jan 2025 10:41:42 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:51 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-25-8419288bc805@google.com>
Subject: [PATCH RFC v2 25/29] mm: asi: Restricted execution fore bare-metal processes
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mike Rapoport <rppt@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_104144_107975_3C4C4D4E 
X-CRM114-Status: GOOD (  31.29  )
X-Mailman-Approved-At: Fri, 10 Jan 2025 12:24:52 -0800
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

Now userspace gets a restricted address space too. The critical section
begins on exit to userspace and ends when it makes a system call.
Other entries from userspace just interrupt the critical section via
asi_intr_enter().

The reason why system calls have to actually asi_relax() (i.e. fully
terminate the critical section instead of just interrupting it) is that
system calls are the type of kernel entry that can lead to transition
into a _different_ ASI domain, namely the KVM one: it is not supported
to transition into a different domain while a critical section exists
(i.e. while asi_state.target is not NULL), even if it has been paused by
asi_intr_enter() (i.e. even if asi_state.intr_nest_depth is nonzero) -
there must be an asi_relax() between any two asi_enter()s.

The restricted address space for bare-metal tasks naturally contains the
entire userspace address region, although the task's own memory is still
missing from the direct map.

This implementation creates new userspace-specific APIs for asi_init(),
asi_destroy() and asi_enter(), which seems a little ugly, maybe this
suggest a general rework of these APIs given that the "generic" version
only has one caller. For RFC code this seems good enough though.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/asi.h   |  8 ++++++--
 arch/x86/mm/asi.c            | 49 ++++++++++++++++++++++++++++++++++++++++----
 include/asm-generic/asi.h    |  9 +++++++-
 include/linux/entry-common.h | 11 ++++++++++
 init/main.c                  |  2 ++
 kernel/entry/common.c        |  1 +
 kernel/fork.c                |  4 +++-
 7 files changed, 76 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index e925d7d2cfc85bca8480c837548654e7a5a7009e..c3c1a57f0147ae9bd11d89c8bf7c8a4477728f51 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -140,19 +140,23 @@ DECLARE_PER_CPU_ALIGNED(struct asi *, curr_asi);
 
 void asi_check_boottime_disable(void);
 
-void asi_init_mm_state(struct mm_struct *mm);
+int asi_init_mm_state(struct mm_struct *mm);
 
 int asi_init_class(enum asi_class_id class_id, struct asi_taint_policy *taint_policy);
+void asi_init_userspace_class(void);
 void asi_uninit_class(enum asi_class_id class_id);
 const char *asi_class_name(enum asi_class_id class_id);
 
 int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_asi);
 void asi_destroy(struct asi *asi);
+void asi_destroy_userspace(struct mm_struct *mm);
 void asi_clone_user_pgtbl(struct mm_struct *mm, pgd_t *pgdp);
 
 /* Enter an ASI domain (restricted address space) and begin the critical section. */
 void asi_enter(struct asi *asi);
 
+void asi_enter_userspace(void);
+
 /*
  * Leave the "tense" state if we are in it, i.e. end the critical section. We
  * will stay relaxed until the next asi_enter.
@@ -294,7 +298,7 @@ void asi_handle_switch_mm(void);
  */
 static inline bool asi_maps_user_addr(enum asi_class_id class_id)
 {
-	return false;
+	return class_id == ASI_CLASS_USERSPACE;
 }
 
 #endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index 093103c1bc2677c81d68008aca064fab53b73a62..1e9dc568e79e8686a4dbf47f765f2c2535d025ec 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -25,6 +25,7 @@ const char *asi_class_names[] = {
 #if IS_ENABLED(CONFIG_KVM)
 	[ASI_CLASS_KVM] = "KVM",
 #endif
+	[ASI_CLASS_USERSPACE] = "userspace",
 };
 
 DEFINE_PER_CPU_ALIGNED(struct asi *, curr_asi);
@@ -67,6 +68,32 @@ int asi_init_class(enum asi_class_id class_id, struct asi_taint_policy *taint_po
 }
 EXPORT_SYMBOL_GPL(asi_init_class);
 
+void __init asi_init_userspace_class(void)
+{
+	static struct asi_taint_policy policy = {
+		/*
+		 * Prevent going to userspace with sensitive data potentially
+		 * left in sidechannels by code running in the unrestricted
+		 * address space, or another MM. Note we don't check for guest
+		 * data here. This reflects the assumption that the guest trusts
+		 * its VMM (absent fancy HW features, which are orthogonal).
+		 */
+		.protect_data = ASI_TAINT_KERNEL_DATA | ASI_TAINT_OTHER_MM_DATA,
+		/*
+		 * Don't go into userspace with control flow state controlled by
+		 * other processes, or any KVM guest the process is running.
+		 * Note this bit is about protecting userspace from other parts
+		 * of the system, while data_taints is about protecting other
+		 * parts of the system from the guest.
+		 */
+		.prevent_control = ASI_TAINT_GUEST_CONTROL | ASI_TAINT_OTHER_MM_CONTROL,
+		.set = ASI_TAINT_USER_CONTROL | ASI_TAINT_USER_DATA,
+	};
+	int err = asi_init_class(ASI_CLASS_USERSPACE, &policy);
+
+	WARN_ON(err);
+}
+
 void asi_uninit_class(enum asi_class_id class_id)
 {
 	if (!boot_cpu_has(X86_FEATURE_ASI))
@@ -385,7 +412,8 @@ int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_
 	int err = 0;
 	uint i;
 
-	*out_asi = NULL;
+	if (out_asi)
+		*out_asi = NULL;
 
 	if (!boot_cpu_has(X86_FEATURE_ASI))
 		return 0;
@@ -424,7 +452,7 @@ int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_
 exit_unlock:
 	if (err)
 		__asi_destroy(asi);
-	else
+	else if (out_asi)
 		*out_asi = asi;
 
 	__asi_init_user_pgds(mm, asi);
@@ -515,6 +543,12 @@ static __always_inline void maybe_flush_data(struct asi *next_asi)
 	this_cpu_and(asi_taints, ~ASI_TAINTS_DATA_MASK);
 }
 
+void asi_destroy_userspace(struct mm_struct *mm)
+{
+	VM_BUG_ON(!asi_class_initialized(ASI_CLASS_USERSPACE));
+	asi_destroy(&mm->asi[ASI_CLASS_USERSPACE]);
+}
+
 noinstr void __asi_enter(void)
 {
 	u64 asi_cr3;
@@ -584,6 +618,11 @@ noinstr void asi_enter(struct asi *asi)
 }
 EXPORT_SYMBOL_GPL(asi_enter);
 
+noinstr void asi_enter_userspace(void)
+{
+	asi_enter(&current->mm->asi[ASI_CLASS_USERSPACE]);
+}
+
 noinstr void asi_relax(void)
 {
 	if (static_asi_enabled()) {
@@ -633,13 +672,15 @@ noinstr void asi_exit(void)
 }
 EXPORT_SYMBOL_GPL(asi_exit);
 
-void asi_init_mm_state(struct mm_struct *mm)
+int asi_init_mm_state(struct mm_struct *mm)
 {
 	if (!boot_cpu_has(X86_FEATURE_ASI))
-		return;
+		return 0;
 
 	memset(mm->asi, 0, sizeof(mm->asi));
 	mutex_init(&mm->asi_init_lock);
+
+	return asi_init(mm, ASI_CLASS_USERSPACE, NULL);
 }
 
 void asi_handle_switch_mm(void)
diff --git a/include/asm-generic/asi.h b/include/asm-generic/asi.h
index d103343292fad567dcd73e45e986fb3974e59898..c93f9e779ce1fa61e3df7835f5ab744cce7d667b 100644
--- a/include/asm-generic/asi.h
+++ b/include/asm-generic/asi.h
@@ -15,6 +15,7 @@ enum asi_class_id {
 #if IS_ENABLED(CONFIG_KVM)
 	ASI_CLASS_KVM,
 #endif
+	ASI_CLASS_USERSPACE,
 	ASI_MAX_NUM_CLASSES,
 };
 static_assert(order_base_2(X86_CR3_ASI_PCID_BITS) <= ASI_MAX_NUM_CLASSES);
@@ -37,8 +38,10 @@ int asi_init_class(enum asi_class_id class_id,
 
 static inline void asi_uninit_class(enum asi_class_id class_id) { }
 
+static inline void asi_init_userspace_class(void) { }
+
 struct mm_struct;
-static inline void asi_init_mm_state(struct mm_struct *mm) { }
+static inline int asi_init_mm_state(struct mm_struct *mm) { return 0; }
 
 static inline int asi_init(struct mm_struct *mm, enum asi_class_id class_id,
 			   struct asi **out_asi)
@@ -48,8 +51,12 @@ static inline int asi_init(struct mm_struct *mm, enum asi_class_id class_id,
 
 static inline void asi_destroy(struct asi *asi) { }
 
+static inline void asi_destroy_userspace(struct mm_struct *mm) { }
+
 static inline void asi_enter(struct asi *asi) { }
 
+static inline void asi_enter_userspace(void) { }
+
 static inline void asi_relax(void) { }
 
 static inline bool asi_is_relaxed(void) { return true; }
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 1e50cdb83ae501467ecc30ee52f1379d409f962e..f04c4c038556f84ddf3bc09b6c1dd22a9dbd2f6b 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -191,6 +191,16 @@ static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, l
 {
 	long ret;
 
+	/*
+	 * End the ASI critical section for userspace. Syscalls are the only
+	 * place this happens - all other entry from userspace is handled via
+	 * ASI's interrupt-tracking. The reason syscalls are special is that's
+	 * where it's possible to switch to another ASI domain within the same
+	 * task (i.e. KVM_RUN), an asi_relax() is required here in case of an
+	 * upcoming asi_enter().
+	 */
+	asi_relax();
+
 	enter_from_user_mode(regs);
 
 	instrumentation_begin();
@@ -355,6 +365,7 @@ static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
  */
 static __always_inline void exit_to_user_mode(void)
 {
+
 	instrumentation_begin();
 	trace_hardirqs_on_prepare();
 	lockdep_hardirqs_on_prepare();
diff --git a/init/main.c b/init/main.c
index c4778edae7972f512d5eefe8400075ac35a70d1c..d19e149d385e8321d2f3e7c28aa75802af62d09c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -953,6 +953,8 @@ void start_kernel(void)
 	/* Architectural and non-timekeeping rng init, before allocator init */
 	random_init_early(command_line);
 
+	asi_init_userspace_class();
+
 	/*
 	 * These use large bootmem allocations and must precede
 	 * initalization of page allocator
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 5b6934e23c21d36a3238dc03e391eb9e3beb4cfb..874254ed5958d62eaeaef4fe3e8c02e56deaf5ed 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -218,6 +218,7 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 	__syscall_exit_to_user_mode_work(regs);
 	instrumentation_end();
 	exit_to_user_mode();
+	asi_enter_userspace();
 }
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
diff --git a/kernel/fork.c b/kernel/fork.c
index bb73758790d08112265d398b16902ff9a4c2b8fe..54068d2415939b92409ca8a45111176783c6acbd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -917,6 +917,7 @@ void __mmdrop(struct mm_struct *mm)
 	/* Ensure no CPUs are using this as their lazy tlb mm */
 	cleanup_lazy_tlbs(mm);
 
+	asi_destroy_userspace(mm);
 	WARN_ON_ONCE(mm == current->active_mm);
 	mm_free_pgd(mm);
 	destroy_context(mm);
@@ -1297,7 +1298,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (mm_alloc_pgd(mm))
 		goto fail_nopgd;
 
-	asi_init_mm_state(mm);
+	if (asi_init_mm_state(mm))
+		goto fail_nocontext;
 
 	if (init_new_context(p, mm))
 		goto fail_nocontext;

-- 
2.47.1.613.gc27f4b7a9f-goog


