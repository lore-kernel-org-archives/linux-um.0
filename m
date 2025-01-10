Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19441E7719F
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 20:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z5b6fu2IPJ4vMWdeJyvKaXZwCsIFdjwPZGonrVH8VuY=; b=F21Qf3Uvn2wn3zFoGtQPnfLXN5
	yA939ZfpGiKZyAJOBOI/0gXPRAOqutz6M6NO5APKZxDepPLnjgz7wVTQcqVRlH7ODTVOdTLe02BRu
	cbGeA8khZWgxO2wX2v5to7jHoJpLiubzIZZ7TiVJglvLHCmKlgOb/9qoOZHwzB3rCl7X1sq9AiD8+
	JdtkxRgSxNGol6y/G+QAemQD49ise2wz6LIUVYGs4d0lEk9aKNRSV6pT/rWOZimG77D1XSAau5L5M
	3vsSGByJD2h879QzERd351Cbdf+WhzSe2UvYPMnxHGdCK1dniPwvqVDtb4M4t7mfQFjB6J7K2MTPN
	ippufQGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWLZC-0000000GtHK-3ZNb;
	Fri, 10 Jan 2025 20:25:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwt-0000000GbmF-1MsA
	for linux-um@bombadil.infradead.org;
	Fri, 10 Jan 2025 18:41:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z5b6fu2IPJ4vMWdeJyvKaXZwCsIFdjwPZGonrVH8VuY=; b=L9qB7j/GXMrZVQRy0mtOltmBC+
	vKQTBqfUOknEsIsLokT+NzNB1Rw4xdlcARcgtSOpiPPxzhI6KIdNDkZeLcPXsgN0/z/BnYLDlhrHr
	EvM+plN2X0YfwrJZeSIlJ7Jvlbm/3YyiYgp+9epujynbTPEq47NhdWT/otGRfpWW3oyuQTf0OfBCO
	bR9AchQwtvEf9K4rs70mJRYOtOxiYC6cdvZoDvbDCtHV3xxpLeIjIhEnYq8WyWI0nEmmcigz600o7
	IT1GQ3Yy7pAzDRX+H7H66GwjhHjVEkT9Y5VRLCCJTvYyAzIspLb9mHIoGeAN+YgUAOOPthFixhY2D
	Wxl0rRIQ==;
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
	by casper.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwq-0000000EBRh-1cWx
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 18:41:34 +0000
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-385d7611ad3so1372996f8f.2
        for <linux-um@lists.infradead.org>; Fri, 10 Jan 2025 10:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534491; x=1737139291; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5b6fu2IPJ4vMWdeJyvKaXZwCsIFdjwPZGonrVH8VuY=;
        b=ZN72pOmq+KvqGOJhTcKfI5pjf3mieqcwagJZT5fndr69QSc+dVM39+0K0lrhFrc04g
         CzsSJ6Ns7fQNFHQ8GCAYDpXMwIMF3D2AhsI67rzHv2Vh/rR5NwXpZ6ESwkrSwSHnebLy
         p6TieOue9f1d0XuUSRXQWTYbTJ6jklvEvFbhXfljrIlWSwyOy4K/vUsBDwzAZdQ3kqDi
         dfNpOg39gu6ke8pCfd5PIe4yEMtp5fK7JZuEX/+67FNI8VslGyuPvHVWpmarafj2m85I
         uqYCKfPm9Yhcxx1BVkLIIzYVnbUZ7dDCTxDKN4pq+xTqhg1gOoOenoHRsj+LFrVrR9kC
         2X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534491; x=1737139291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5b6fu2IPJ4vMWdeJyvKaXZwCsIFdjwPZGonrVH8VuY=;
        b=SWStMurxFN/C2u7rXIq6FkV5KdXsCpDPOh9Ova8LUfvaAaVc22EcD+1KTxKpSZrhSF
         7/z8JBOvBQEGboUrlRbLWgVJFiMdPtC5fBRKDLgn4VS6LSXyWNWBam5ZEqvzQH/ftMk/
         dTStUSumc8w1AQTzIa4Jkk8oxcDJVEZBgf1mZ8f3SeRa2BKBXzVzPIJf2HN4GOffquNN
         o1UXDV68JxTC1OTWEETRMTS2SdiHh7/rrtDy5nRqgfTqoki7Tplf/CHZy++xtsRHj350
         u5JQDrJ99yEGtwxqpOFL8V1JjFSplCYMVhkDXd5t0Jb+ocBbSgsEaC3ITBVvnTno0rjX
         x7jA==
X-Forwarded-Encrypted: i=1; AJvYcCXMl1gK2TCh2Nb3PJTdzY7qeATCiE69iBCNx/NbI1TsKfOyr0Ceayvh5Y3wRiG2TZvp3Qrfr9ekzw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxlwjJBi7EW/cQW6wLU6in+mfjcChpObv250uXe+wPRKmGyPzun
	yr7WhWT2Hqc5ByRd7l96thgFFI4jn94TobI5dsPXWFwe6G5ZD8VsR5hCdF2HfYhvPUu39la/ePq
	2KHCQOBo/0g==
X-Google-Smtp-Source: AGHT+IEE74PFwgraC6zRNOcME3rOW4swKtJd/bKE4AIl8MRowFtdpWNq19ZBTTKPz5sLGPxmEc1GHABVlwipiQ==
X-Received: from wmjv9.prod.google.com ([2002:a7b:cb49:0:b0:434:f173:a51])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1a85:b0:38a:4184:1520 with SMTP id ffacd0b85a97d-38a872eb1eamr9947778f8f.27.1736534490587;
 Fri, 10 Jan 2025 10:41:30 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:46 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-20-8419288bc805@google.com>
Subject: [PATCH RFC v2 20/29] mm: asi: Make TLB flushing correct under ASI
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
X-CRM114-CacheID: sfid-20250110_184132_482114_C43A2987 
X-CRM114-Status: GOOD (  23.56  )
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

This is the absolute minimum change for TLB flushing to be correct under
ASI. There are two arguably orthogonal changes in here but they feel
small enough for a single commit.

.:: CR3 stabilization

As noted in the comment ASI can destabilize CR3, but we can stabilize it
again by calling asi_exit, this makes it safe to read CR3 and write it
back.

This is enough to be correct - we don't have to worry about invalidating
the other ASI address space (i.e. we don't need to invalidate the
restricted address space if we are currently unrestricted / vice versa)
because we currently never set the noflush bit in CR3 for ASI
transitions.

Even without using CR3's noflush bit there are trivial optimizations
still on the table here: on where invpcid_flush_single_context is
available (i.e. with the INVPCID_SINGLE feature) we can use that in lieu
of the CR3 read/write, and avoid the extremely costly asi_exit.

.:: Invalidating kernel mappings

Before ASI, with KPTI off we always either disable PCID or use global
mappings for kernel memory. However ASI disables global kernel mappings
regardless of factors. So we need to invalidate other address spaces to
trigger a flush when we switch into them.

Note that there is currently a pointless write of
cpu_tlbstate.invalidate_other in the case of KPTI and !PCID. We've added
another case of that (ASI, !KPTI and !PCID). I think that's preferable
to expanding the conditional in flush_tlb_one_kernel.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/tlb.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index ce5598f96ea7a84dc0e8623022ab5bfbba401b48..07b1657bee8e4cf17452ea57c838823e76f482c0 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -231,7 +231,7 @@ static void clear_asid_other(void)
 	 * This is only expected to be set if we have disabled
 	 * kernel _PAGE_GLOBAL pages.
 	 */
-	if (!static_cpu_has(X86_FEATURE_PTI)) {
+	if (!static_cpu_has(X86_FEATURE_PTI) && !static_asi_enabled()) {
 		WARN_ON_ONCE(1);
 		return;
 	}
@@ -1040,7 +1040,6 @@ static void put_flush_tlb_info(void)
 noinstr u16 asi_pcid(struct asi *asi, u16 asid)
 {
 	return kern_pcid(asid) | ((asi->class_id + 1) << X86_CR3_ASI_PCID_BITS_SHIFT);
-	// return kern_pcid(asid) | ((asi->index + 1) << X86_CR3_ASI_PCID_BITS_SHIFT);
 }
 
 void asi_flush_tlb_range(struct asi *asi, void *addr, size_t len)
@@ -1192,15 +1191,19 @@ void flush_tlb_one_kernel(unsigned long addr)
 	 * use PCID if we also use global PTEs for the kernel mapping, and
 	 * INVLPG flushes global translations across all address spaces.
 	 *
-	 * If PTI is on, then the kernel is mapped with non-global PTEs, and
-	 * __flush_tlb_one_user() will flush the given address for the current
-	 * kernel address space and for its usermode counterpart, but it does
-	 * not flush it for other address spaces.
+	 * If PTI or ASI is on, then the kernel is mapped with non-global PTEs,
+	 * and __flush_tlb_one_user() will flush the given address for the
+	 * current kernel address space and, if PTI is on, for its usermode
+	 * counterpart, but it does not flush it for other address spaces.
 	 */
 	flush_tlb_one_user(addr);
 
-	if (!static_cpu_has(X86_FEATURE_PTI))
+	/* Nothing more to do if PTI and ASI are completely off. */
+	if (!static_cpu_has(X86_FEATURE_PTI) && !static_asi_enabled()) {
+		VM_WARN_ON_ONCE(static_cpu_has(X86_FEATURE_PCID) &&
+				!(__default_kernel_pte_mask & _PAGE_GLOBAL));
 		return;
+	}
 
 	/*
 	 * See above.  We need to propagate the flush to all other address
@@ -1289,6 +1292,16 @@ STATIC_NOPV void native_flush_tlb_local(void)
 
 	invalidate_user_asid(this_cpu_read(cpu_tlbstate.loaded_mm_asid));
 
+	/*
+	 * Restricted ASI CR3 is unstable outside of critical section, so we
+	 * couldn't flush via a CR3 read/write. asi_exit() stabilizes it.
+	 * We don't expect any flushes in a critical section.
+	 */
+	if (WARN_ON(asi_in_critical_section()))
+		native_flush_tlb_global();
+	else
+		asi_exit();
+
 	/* If current->mm == NULL then the read_cr3() "borrows" an mm */
 	native_write_cr3(__native_read_cr3());
 }

-- 
2.47.1.613.gc27f4b7a9f-goog


