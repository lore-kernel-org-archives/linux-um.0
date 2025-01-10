Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F3CC02183
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 20:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aGIlyFkOxdGIUAlLSc7B7HeTqLb/6yPSKg6NF5x4oeg=; b=w2mIDQImccwe8susuC1X//CRxL
	T/lbU45opPTgNd0Koy1ymtEo3UR3FV8R5zA0+WJpp/dieVcWude8jI6ZfBUM3xtihECr+mqbkIgMD
	9pf3+ALpg4T9OHq823iuAm8iUQ7j6tK4q38H3IborV9jFXr1/t97VhS2gozxG8JVnPOcHH+6WeUwy
	+ANZdIJxNdYIQ+A7vwfO9B4NjT8bemlRX9mU+J5umTazzA0ib89/hdpb5rxOaGOtQHXUXiLxOj/Ml
	YAMhNRc2VHvIrhLpY00w1DZtnkEFk1AiXyKOC/7hWDU35UOHxC9Lu3duql/VhT5czrYkgqI9xqIRM
	lEZAI1+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWLZE-0000000GtJ6-0itZ;
	Fri, 10 Jan 2025 20:25:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJx0-0000000GbtW-25Gm
	for linux-um@bombadil.infradead.org;
	Fri, 10 Jan 2025 18:41:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aGIlyFkOxdGIUAlLSc7B7HeTqLb/6yPSKg6NF5x4oeg=; b=h8Uw8uALG2eAHZkssRRrNWuT/R
	YiRV0KA1Vpny8TsEn62JE5g6CeyHHxN2FH6X6eAlWLcXGEbZbbfOz6p0Wg5j2DSbyeLRN6Y5q9H8g
	fo2n+NBEOqt9syr2Rz8KW+SC+AlxbrUtUxNUgKjHiAobtF3Qx6N57G3XOSvSEZt3Z7mdHV2y8mJf1
	FFr5+iRs9zNR414yOe1Y0Ym2UL09AijZwa2fRWXU+FIZPDJd2U2E4YeNFBWDsfOIlgmNetVjOEGgQ
	hz51yjDaYHtmMRM7E7qnXLEzcz0yvHdeJtyM0ZZddEThPSKcSuWpsYjYjtbFqRy/vS0+4oiIDp5vN
	d6iiQZCg==;
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
	by casper.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJww-0000000EBTt-4Aav
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 18:41:41 +0000
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-43619b135bcso12093355e9.1
        for <linux-um@lists.infradead.org>; Fri, 10 Jan 2025 10:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534497; x=1737139297; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aGIlyFkOxdGIUAlLSc7B7HeTqLb/6yPSKg6NF5x4oeg=;
        b=JIduXtwxAbfW+uj7qj57ptRN2EBQHb4sS8t9VXBvc36RYueKdmK/my5pOphTyHJ4en
         RaxzTdhRiPHVR1WH40wixXxWQCdF+x9fRgd+TT/PMHPb/V9as2Eu3zRSxUEbPtPX5Drm
         e4tW/RFDrJ38VFOBBcvfr0rNnZq+vd5MoHLgBdQAgF4B72URpt45gdN3ve1iTa6EnYg/
         tHECZSxCh6ouxt4R3JMih23iDeR7wTr/08HA1BEHV9GcVApd8U6Cdcg4V6uB6dB8x1C8
         YAqzYbxwYLOqNuYgPxS2Yw/Bx0Z5Wn3mNQHGqyyqZJIDlqHDb+b5rnKNhVNH/9oTIxQO
         uTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534497; x=1737139297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGIlyFkOxdGIUAlLSc7B7HeTqLb/6yPSKg6NF5x4oeg=;
        b=w0uVoB13N9EX8nHOFCZjD2rbuctiYBlmpS7DiM9BN0/mdH4DgGGwSbc7vVUfvrkWiO
         P3t84oFvojrxt4LJUA/UbB+kLVzlqmyBX9moms5x7DfgkspERrExqGDWPDiZHDr65M1g
         MFARRcOA5Ebl7eOxN4vWGXhm8yQediW/V5R5nSLGkVM7PSNLsTUvLIzhEI08cUf0zC62
         10BaN7UYrf/mpalhOsNUgq4svVXlvd5/MVyeHCivisZbM9r97ZIEuSDuSk9ufDYB/Nt+
         tF318+zUjlXrrvNw5Q7uygU1WcUFTh8LZc5FN5jFQ4zdOQOLDQl3cb5wyZ7zOwlCS6H+
         Y2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8KLbObO09hcGJnV363Qce/Qpl4yZ48vJjw8d4BQbQUs293Dbv5iaA2hVLSxbYZiMH+7mnSwnWgw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy34ymbLLpkOYOlpdv5eGhp5inaYc4qjW6hlDe5xYCNvulUXtSa
	+B947shf3MAYeVPUsIMMju4SSLXmMqCEbjPTY3s7KSGE8NC66De5qMIQkEdpnkFgXCq/V/mXUx0
	y0NyZ8wq6rQ==
X-Google-Smtp-Source: AGHT+IFRy9/+C5CnBm/ma6a3ETfEwH3prKyhyhclEMfLJAYKbacCY4ZfacRZW3At4TIIMxUaqY38zEy/zVSAnQ==
X-Received: from wmdn10.prod.google.com ([2002:a05:600c:294a:b0:436:d819:e4eb])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5848:b0:436:f3f6:9582 with SMTP id 5b1f17b1804b1-436f3f695dfmr6272215e9.8.1736534497408;
 Fri, 10 Jan 2025 10:41:37 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:49 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-23-8419288bc805@google.com>
Subject: [PATCH RFC v2 23/29] mm: asi: exit ASI before suspend-like operations
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
	Brendan Jackman <jackmanb@google.com>, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_184139_078115_2DC08DF0 
X-CRM114-Status: GOOD (  21.15  )
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

From: Yosry Ahmed <yosryahmed@google.com>

During suspend-like operations (suspend, hibernate, kexec w/
preserve_context), the processor state (including CR3) is usually saved
and restored later.

In the kexec case, this only happens when KEXEC_PRESERVE_CONTEXT is
used to jump back to the original kernel. In relocate_kernel(), some
registers including CR3 are stored in VA_CONTROL_PAGE. If
preserve_context is set (passed into relocate_kernel() in RCX), after
running the new kernel the code under 'virtual_mapped' restores these
registers. This is similar to what happens in suspend and hibernate.

Note that even when KEXEC_PRESERVE_CONTEXT is not set, relocate_kernel()
still accesses CR3. It mainly reads and writes it to flush the TLB. This
could be problematic and cause improper ASI enters (see below), but it
is assumed to be safe because the kernel will essentially reboot in this
case anyway.

Saving and restoring CR3 in this fashion can cause a problem if the
suspend/hibernate/kexec is performed within an ASI domain. A restricted
CR3 will be saved, and later restored after ASI had potentially already
exited (e.g. from an NMI after CR3 is stored). This will cause an
_improper_ ASI enter, where code starts executing in a restricted
address space, yet ASI metadata (especially curr_asi) says otherwise.

Exit ASI early in all these paths by registering a syscore_suspend()
callback. syscore_suspend() is called in all the above paths (for kexec,
only with KEXEC_PRESERVE_CONTEXT) after IRQs are finally disabled before
the operation. This is not currently strictly required but is convenient
because when ASI gains the ability to persist across context switching,
there will be additional synchronization requirements simplified by
this.

Note: If the CR3 accesses in relocate_kernel() when
KEXEC_PRESERVE_CONTEXT is not set are concerning, they could be handled
by registering a syscore_shutdown() callback to exit ASI.
syscore_shutdown() is called in the kexec path where
KEXEC_PRESERVE_CONTEXT is not set starting commit 7bb943806ff6 ("kexec:
do syscore_shutdown() in kernel_kexec").

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/asi.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index a9f9bfbf85eb47d16ef8d0bfbc7713f07052d3ed..c5073af1a82ded1c6fc467cd7a5d29a39d676bb4 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -6,6 +6,7 @@
 
 #include <linux/init.h>
 #include <linux/pgtable.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/cmdline.h>
 #include <asm/cpufeature.h>
@@ -243,6 +244,32 @@ static int asi_map_percpu(struct asi *asi, void *percpu_addr, size_t len)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int asi_suspend(void)
+{
+	/*
+	 * Must be called after IRQs are disabled and rescheduling is no longer
+	 * possible (so that we cannot re-enter ASI before suspending.
+	 */
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Suspend operations sometimes save CR3 as part of the saved state,
+	 * which is restored later (e.g. do_suspend_lowlevel() in the suspend
+	 * path, swsusp_arch_suspend() in the hibernate path, relocate_kernel()
+	 * in the kexec path). Saving a restricted CR3 and restoring it later
+	 * could leave to improperly entering ASI. Exit ASI before such
+	 * operations.
+	 */
+	asi_exit();
+	return 0;
+}
+
+static struct syscore_ops asi_syscore_ops = {
+	.suspend = asi_suspend,
+};
+#endif /* CONFIG_PM_SLEEP */
+
 static int __init asi_global_init(void)
 {
 	int err;
@@ -306,6 +333,10 @@ static int __init asi_global_init(void)
 	asi_clone_pgd(asi_global_nonsensitive_pgd, init_mm.pgd,
 		      VMEMMAP_START + (1UL << PGDIR_SHIFT));
 
+#ifdef CONFIG_PM_SLEEP
+	register_syscore_ops(&asi_syscore_ops);
+#endif
+
 	return 0;
 }
 subsys_initcall(asi_global_init)

-- 
2.47.1.613.gc27f4b7a9f-goog


