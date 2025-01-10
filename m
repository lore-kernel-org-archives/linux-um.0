Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC98C02183
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 20:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ffc/jeUEwcE9NsWtGdDMnxjVfG4g8pYiskW7P1F5M34=; b=M623wC8GHCW1Cbadij+ak+f4KX
	NJl3t5rnm0kXaT8dFI3IiqnETRVciqhj3GEXLkRz44I7P6XNh+whVLEtwvwOgBJq4fQhcP8wpMn28
	kHdmDcrPbkS/3rhBBGXYnIe8m3+6m1HXQaiPXUJ1P2hrpc4/+0LZSWrojwEW+Im3186bRHKvxjhnS
	xD0FoLi+0+Ym389R4Uo6497wjqV1kqRwJhuNlEvKX+168Af4/UN59gRUSRCfAckPPgs8t0NDqGFd6
	B24tEjgYDbADp6LR8sUnQZCZb+ezoK7g+RUCGUIXa1rUsynP9Fup1bLcthyTKhrL57fUtEMnVb7Xv
	UOLrdxEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWLZ1-0000000Gt5N-1byy;
	Fri, 10 Jan 2025 20:25:03 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwY-0000000GbTg-1t4M
	for linux-um@bombadil.infradead.org;
	Fri, 10 Jan 2025 18:41:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ffc/jeUEwcE9NsWtGdDMnxjVfG4g8pYiskW7P1F5M34=; b=JL2I89ip58w1FPxUu73U9BxLnR
	JN4jyi0cec2JdwWhBM/bV+rVlpzzoofEyCP6icWRw794cZuYAWdE6DoCXlpSeCjFVXEjkPx9D4c3V
	KseHvVYtxEBU1SgXLRyviFDEs8D3Dj71WKifKzmFdtxsPkbUhJQOKpnbgPSwHGFJI4yBUTfje/7YY
	0yjQp51EezfgvjzbYRfwGLIxBgnSEcDrgomLyGhuEVeGjEp8Z5E54dtB1WdVvn3JOdsv4rSrlGir3
	7VtwgcHU+u5DlFiI1Oo6kEZHagbrAVWHS7yFXw+n6+qQTn9FjyPOgI1RwnVoSecUa1fFrl0zn61Fa
	+gukLZDA==;
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwT-00000009sSh-3wvJ
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 18:41:13 +0000
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-4361ac607b6so19207765e9.0
        for <linux-um@lists.infradead.org>; Fri, 10 Jan 2025 10:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534468; x=1737139268; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffc/jeUEwcE9NsWtGdDMnxjVfG4g8pYiskW7P1F5M34=;
        b=fPJB+yvqOmDp+s29h8r1voz2/l2ryGHDAVhu8Wy7Jl1VHmbG5JF1UAV7IKii8kTP6k
         X43l/zy3+bm7ZoVkUnapHTfI+BjrBqWZnApZ8GDzYbscrz4+jJjdRbVUgy2dmMird903
         rAE7uSBhXEapvI3iYPhIDUcIVuyY+cKr4lf3UBhwejJUwJ96xX4xd8VZd+BXS5TsStsx
         Mpa7hTPwp6tVIFKYk9Hqgv6MnTtZ2dyvFQCbaHMKI1mVN8ZxQW8ckBDBkDi1GzeVEl/P
         2QXEfGclw4UxIqJ9bnglFQIb8N1H/Ju+Z4bkreUhLgQTSMR+iRmxYpLkM3CWKwRy+WTa
         0WFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534468; x=1737139268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffc/jeUEwcE9NsWtGdDMnxjVfG4g8pYiskW7P1F5M34=;
        b=H0okl2tlppxqxyBwkYxBSWB/+wRUzOL2vUVHVMHoI+0loTgQ4kvFukGULYYjdf20Mf
         QJsFPfISYuEf8arH8MuUzglFxefMZVNecmqVbJe9HtHKikYkhXFT0mg2M4noMTZrLjfz
         PqHojPeeC0MGNbdIS4le/eFCgp7TJjAF2aVLyJyx5VtuIHyWcxFJsQ3A1Ur0hrtXksDh
         VP2zNr66vANPfM2/pj1M0krj+LQTmbqKQ7FVcTfk2eX/adZFXl1xZ8X+07+5QdzmekbR
         knACjmNEJC0mltZ3UQ1IuCxu7CVinTA3U1Ss/iq0HAQYNDcq1CbWdRXBu54yGRC969dR
         asZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUAfdBjJjZF2RwySOEaghv/VX3dlNINZYmbqhIISt0WoN2K5Dfeyp5QJ5A99aWl7Bju+prHPQ0Xw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxZikrEAFjr/zceBiFvL9fXrtQUuAY+qbVlJ8gODMZn3FT/61+t
	J16h+a/ddeVenrnzuUATjLe4Jiev4RXHS1K/xSw2/OK+kZysWSZPFle6c9iBfOdD6gT8cX7wbIl
	oUaXyBQqagA==
X-Google-Smtp-Source: AGHT+IF/q1QCp5xw/vI+ho6WzVZa4JA3GTBWKWx8cvSyaKNRoxJopmgrWWLxru20teHN6JHe+1fTI5ygNpFhkw==
X-Received: from wmso37.prod.google.com ([2002:a05:600c:5125:b0:434:a98d:6a1c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:524f:b0:435:d22:9c9e with SMTP id 5b1f17b1804b1-436e26d0cf9mr103592725e9.19.1736534468098;
 Fri, 10 Jan 2025 10:41:08 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:36 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-10-8419288bc805@google.com>
Subject: [PATCH RFC v2 10/29] mm: asi: asi_exit() on PF, skip handling if
 address is accessible
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
	Brendan Jackman <jackmanb@google.com>, Ofir Weisse <oweisse@google.com>
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_184110_097204_19F3F4DB 
X-CRM114-Status: GOOD (  35.60  )
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

From: Ofir Weisse <oweisse@google.com>

On a page-fault - do asi_exit(). Then check if now after the exit the
address is accessible. We do this by refactoring spurious_kernel_fault()
into two parts:

1. Verify that the error code value is something that could arise from a
lazy TLB update.
2. Walk the page table and verify permissions, which is now called
is_address_accessible(). We also define PTE_PRESENT() and PMD_PRESENT()
which are suitable for checking userspace pages. For the sake of
spurious faults,  pte_present() and pmd_present() are only good for
kernelspace pages. This is because these macros might return true even
if the present bit is 0 (only relevant for userspace).

checkpatch.pl VSPRINTF_SPECIFIER_PX - it's in a WARN that only fires in
a debug build of the kernel when we hit a disastrous bug, seems OK to
leak addresses.

RFC note: A separate refactoring/prep commit should be split out of this
patch.

Checkpatch-args: --ignore=VSPRINTF_SPECIFIER_PX
Signed-off-by: Ofir Weisse <oweisse@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/fault.c | 118 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e6c469b323ccb748de22adc7d9f0a16dd195edad..ee8f5417174e2956391d538f41e2475553ca4972 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -948,7 +948,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 }
 
-static int spurious_kernel_fault_check(unsigned long error_code, pte_t *pte)
+static __always_inline int kernel_protection_ok(unsigned long error_code, pte_t *pte)
 {
 	if ((error_code & X86_PF_WRITE) && !pte_write(*pte))
 		return 0;
@@ -959,6 +959,8 @@ static int spurious_kernel_fault_check(unsigned long error_code, pte_t *pte)
 	return 1;
 }
 
+static int kernel_access_ok(unsigned long error_code, unsigned long address, pgd_t *pgd);
+
 /*
  * Handle a spurious fault caused by a stale TLB entry.
  *
@@ -984,11 +986,6 @@ static noinline int
 spurious_kernel_fault(unsigned long error_code, unsigned long address)
 {
 	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	int ret;
 
 	/*
 	 * Only writes to RO or instruction fetches from NX may cause
@@ -1004,6 +1001,50 @@ spurious_kernel_fault(unsigned long error_code, unsigned long address)
 		return 0;
 
 	pgd = init_mm.pgd + pgd_index(address);
+	return kernel_access_ok(error_code, address, pgd);
+}
+NOKPROBE_SYMBOL(spurious_kernel_fault);
+
+/*
+ * For kernel addresses, pte_present and pmd_present are sufficient for
+ * is_address_accessible. For user addresses these functions will return true
+ * even though the pte is not actually accessible by hardware (i.e _PAGE_PRESENT
+ * is not set). This happens in cases where the pages are physically present in
+ * memory, but they are not made accessible to hardware as they need software
+ * handling first:
+ *
+ * - ptes/pmds with _PAGE_PROTNONE need autonuma balancing (see pte_protnone(),
+ *   change_prot_numa(), and do_numa_page()).
+ *
+ * - pmds with _PAGE_PSE & !_PAGE_PRESENT are undergoing splitting (see
+ *   split_huge_page()).
+ *
+ * Here, we care about whether the hardware can actually access the page right
+ * now.
+ *
+ * These issues aren't currently present for PUD but we also have a custom
+ * PUD_PRESENT for a layer of future-proofing.
+ */
+#define PUD_PRESENT(pud) (pud_flags(pud) & _PAGE_PRESENT)
+#define PMD_PRESENT(pmd) (pmd_flags(pmd) & _PAGE_PRESENT)
+#define PTE_PRESENT(pte) (pte_flags(pte) & _PAGE_PRESENT)
+
+/*
+ * Check if an access by the kernel would cause a page fault. The access is
+ * described by a page fault error code (whether it was a write/instruction
+ * fetch) and address. This doesn't check for types of faults that are not
+ * expected to affect the kernel, e.g. PKU. The address can be user or kernel
+ * space, if user then we assume the access would happen via the uaccess API.
+ */
+static noinstr int
+kernel_access_ok(unsigned long error_code, unsigned long address, pgd_t *pgd)
+{
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	int ret;
+
 	if (!pgd_present(*pgd))
 		return 0;
 
@@ -1012,27 +1053,27 @@ spurious_kernel_fault(unsigned long error_code, unsigned long address)
 		return 0;
 
 	if (p4d_leaf(*p4d))
-		return spurious_kernel_fault_check(error_code, (pte_t *) p4d);
+		return kernel_protection_ok(error_code, (pte_t *) p4d);
 
 	pud = pud_offset(p4d, address);
-	if (!pud_present(*pud))
+	if (!PUD_PRESENT(*pud))
 		return 0;
 
 	if (pud_leaf(*pud))
-		return spurious_kernel_fault_check(error_code, (pte_t *) pud);
+		return kernel_protection_ok(error_code, (pte_t *) pud);
 
 	pmd = pmd_offset(pud, address);
-	if (!pmd_present(*pmd))
+	if (!PMD_PRESENT(*pmd))
 		return 0;
 
 	if (pmd_leaf(*pmd))
-		return spurious_kernel_fault_check(error_code, (pte_t *) pmd);
+		return kernel_protection_ok(error_code, (pte_t *) pmd);
 
 	pte = pte_offset_kernel(pmd, address);
-	if (!pte_present(*pte))
+	if (!PTE_PRESENT(*pte))
 		return 0;
 
-	ret = spurious_kernel_fault_check(error_code, pte);
+	ret = kernel_protection_ok(error_code, pte);
 	if (!ret)
 		return 0;
 
@@ -1040,12 +1081,11 @@ spurious_kernel_fault(unsigned long error_code, unsigned long address)
 	 * Make sure we have permissions in PMD.
 	 * If not, then there's a bug in the page tables:
 	 */
-	ret = spurious_kernel_fault_check(error_code, (pte_t *) pmd);
+	ret = kernel_protection_ok(error_code, (pte_t *) pmd);
 	WARN_ONCE(!ret, "PMD has incorrect permission bits\n");
 
 	return ret;
 }
-NOKPROBE_SYMBOL(spurious_kernel_fault);
 
 int show_unhandled_signals = 1;
 
@@ -1490,6 +1530,29 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 	}
 }
 
+static __always_inline void warn_if_bad_asi_pf(
+	unsigned long error_code, unsigned long address)
+{
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+	struct asi *target;
+
+	/*
+	 * It's a bug to access sensitive data from the "critical section", i.e.
+	 * on the path between asi_enter and asi_relax, where untrusted code
+	 * gets run. #PF in this state sees asi_intr_nest_depth() as 1 because
+	 * #PF increments it. We can't think of a better way to determine if
+	 * this has happened than to check the ASI pagetables, hence we can't
+	 * really have this check in non-debug builds unfortunately.
+	 */
+	VM_WARN_ONCE(
+		(target = asi_get_target(current)) != NULL &&
+		asi_intr_nest_depth() == 1 &&
+		!kernel_access_ok(error_code, address, asi_pgd(target)),
+		"ASI-sensitive data access from critical section, addr=%px error_code=%lx class=%s",
+		(void *) address, error_code, asi_class_name(target->class_id));
+#endif
+}
+
 DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 {
 	irqentry_state_t state;
@@ -1497,6 +1560,31 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 
 	address = cpu_feature_enabled(X86_FEATURE_FRED) ? fred_event_data(regs) : read_cr2();
 
+	if (static_asi_enabled() && !user_mode(regs)) {
+		pgd_t *pgd;
+
+		/* Can be a NOP even for ASI faults, because of NMIs */
+		asi_exit();
+
+		/*
+		 * handle_page_fault() might oops if we run it for a kernel
+		 * address in kernel mode. This might be the case if we got here
+		 * due to an ASI fault. We avoid this case by checking whether
+		 * the address is now, after asi_exit(), accessible by hardware.
+		 * If it is - there's nothing to do. Note that this is a bit of
+		 * a shotgun; we can also bail early from user-address faults
+		 * here that weren't actually caused by ASI. So we might wanna
+		 * move this logic later in the handler. In particular, we might
+		 * be losing some stats here. However for now this keeps ASI
+		 * page faults nice and fast.
+		 */
+		pgd = (pgd_t *)__va(read_cr3_pa()) + pgd_index(address);
+		if (!user_mode(regs) && kernel_access_ok(error_code, address, pgd)) {
+			warn_if_bad_asi_pf(error_code, address);
+			return;
+		}
+	}
+
 	prefetchw(&current->mm->mmap_lock);
 
 	/*

-- 
2.47.1.613.gc27f4b7a9f-goog


