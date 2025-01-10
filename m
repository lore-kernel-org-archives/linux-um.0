Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E0EC02181
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 20:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WaFp0TOYaWSuGPhKgfBnenMecO/UsWYRxmgXZ26ETaU=; b=hOWoyDL6ZtsoTouUGKHOa4pwIA
	eBUjE85CNIv7SNzPGG3CaOgKHLV+YqfFs9g2pJGjufWX16oW2stWPeGc86zxX9oMCDMhaZsDQhpn0
	qeQLKYYkc29OZLLZoJXufSLJK+wI1vrFFOKHNu7WpHCKm4Hu8QOU0MMQk/dLgpfYFTz/KPKIW4m16
	z3YYmqRoELQbDOAGX0SmZNzIvTNCis7Hj1LPnm6AYkYff6cFyo4lZYzVdDixa4xequP63jK66dV0X
	Nn4+kNnug+KoDb5NdWYeWKgfbKJzfxf7sH3xx3bSIQ8n7g2hwArpcaUIJsblVLpHs/uTsqDSKZAXQ
	VL6HMmuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWLZ1-0000000Gt4b-053M;
	Fri, 10 Jan 2025 20:25:03 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwW-0000000GbRg-35Ge
	for linux-um@bombadil.infradead.org;
	Fri, 10 Jan 2025 18:41:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WaFp0TOYaWSuGPhKgfBnenMecO/UsWYRxmgXZ26ETaU=; b=ihB9y3DPVBTVH9wJXl03PtPKt5
	lVZ1qzVBUKYK6dKXSJBqft4/DYQze2K8MiDAYyt8xmNLMeb4xh83WAWyScrGNsB/x2xs78uOvSHxa
	3Jvo/Gw86agqLZZPnVHfGNN5J00GnbhL6JL+Fgsuj9K5+gvxAy0TMj0jXNSeF27TsC6Tb/EYsExHE
	53B2+dmaEop+iBJZB4xUtzq1FGp1INz/SeyUz1K/VbZ1k3wYUlk5FaK6vylUoityUQuWAGUJefEkm
	hcM8N21Dvg1YfjscPk/SuBieS0OC89SnyZ3cerdGWZEu47Xv+3WTMIiAyGT1REMcGwpkWK1Tpdygi
	v3B7DKiA==;
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
	by casper.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwR-0000000EBH6-2Q3S
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 18:41:11 +0000
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-436289a570eso19446305e9.0
        for <linux-um@lists.infradead.org>; Fri, 10 Jan 2025 10:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534466; x=1737139266; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WaFp0TOYaWSuGPhKgfBnenMecO/UsWYRxmgXZ26ETaU=;
        b=VEAQxMPFpxhBEZTqoqlDOf6y8oieYRZ6DfiXEI/4X1AVjiUAscjWIriFM6s9e9EAZJ
         V2OlwEFmOkm9vR0ss42jzqCI0wRVWeN1dDZ7gOJ9sNnHrnRp8+XJ7NFNn5Hw3dZ4XhHh
         Z/UCxx/f3hnRw47al8rIdqbZC5P49kpCFEjB8jOJLOvQ47+ErdoEknTdkw9QvjNh2Cc5
         46pQo7DMl43auDI5yWQpNdtLVG4DCzvyeNzfxdYNZkuU2HBLF+Tu04fujWxk1N+StBNF
         kK4cdATEnHfCGX8mUWSV0Ezd12eS7QZ81nVYZLx+PY+Da4SzMU5FfcuK55O8qwrDZv5G
         2AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534466; x=1737139266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WaFp0TOYaWSuGPhKgfBnenMecO/UsWYRxmgXZ26ETaU=;
        b=lrdjT1gpIhiQgBKO6g5izNoVcyDj+UiwwtpdtZlSOlYJriheqwip0e+EWSyMGRzKq6
         BKbWZ5hF8GeL8ronJf8ra/tq/I0m0Nrr7joDaxdRLITV6QV2uFtfzbign+FcN8C3rh7p
         3dqbY8Bpc1u0uuf8jjhN1uS6NFfSIcdNaJwxpG88/KQ0JtHEYVDgS1TysD6eJplEkbxu
         VTaNZLZyKs4U33ohhYTXhdPokGwX3z9AlKLBsrwaBKE0CTiGiCUyp4MZ/VeBuqOxOlPG
         qdutTUrzHYyQKAyn28MctQf96jzeymlT4DdhZUs5eC2uT41p5ue7eEPHm87Uiazi9AP8
         T+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWdu72WhE/FMO/t1f8mfKYDgb+MQe181ek4xuRka/KBiPQntcHSA9VKo47bAcHtv0HaGPFLMJIsQQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YweoH/6sOzsxzpOaGqpPPA8nKWt9v2d1DDvlkWdu8tKdtFQo/Tz
	qIXyY49Gupu1hx3osK0kVamIPr+fsx3JGKvKboU6nbet/7/2f9L3Mrk5K75PIZ2ETt8+gDPhGAK
	qZ+zhCFu59g==
X-Google-Smtp-Source: AGHT+IEE4az+Oz6XpM1h3immNPii0BZQy1AjHZ6Oe5B/in2qx8QsaCvn5PLTDmCUbo/W1PshFIv+Soo2Sqz9XA==
X-Received: from wmrn35.prod.google.com ([2002:a05:600c:5023:b0:434:f2eb:aa72])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ca4:b0:434:a26c:8291 with SMTP id 5b1f17b1804b1-436e26e203emr101768035e9.24.1736534465947;
 Fri, 10 Jan 2025 10:41:05 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:35 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-9-8419288bc805@google.com>
Subject: [PATCH RFC v2 09/29] mm: asi: ASI page table allocation functions
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
	Brendan Jackman <jackmanb@google.com>, Junaid Shahid <junaids@google.com>
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_184107_646791_5BD78771 
X-CRM114-Status: GOOD (  17.22  )
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

From: Junaid Shahid <junaids@google.com>

This adds custom allocation and free functions for ASI page tables.

The alloc functions support allocating memory using different GFP
reclaim flags, in order to be able to support non-sensitive allocations
from both standard and atomic contexts. They also install the page
tables locklessly, which makes it slightly simpler to handle
non-sensitive allocations from interrupts/exceptions.

checkpatch.pl MACRO_ARG_UNUSED,SPACING is false positive. COMPLEX_MACRO - I
dunno, suggestions welcome.

Checkpatch-args: --ignore=MACRO_ARG_UNUSED,SPACING,COMPLEX_MACRO
Signed-off-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/asi.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index 8d060c633be68b508847e2c1c111761df1da92af..b15d043acedc9f459f17e86564a15061650afc3a 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -73,6 +73,65 @@ const char *asi_class_name(enum asi_class_id class_id)
 	return asi_class_names[class_id];
 }
 
+#ifndef mm_inc_nr_p4ds
+#define mm_inc_nr_p4ds(mm)	do {} while (false)
+#endif
+
+#ifndef mm_dec_nr_p4ds
+#define mm_dec_nr_p4ds(mm)	do {} while (false)
+#endif
+
+#define pte_offset		pte_offset_kernel
+
+/*
+ * asi_p4d_alloc, asi_pud_alloc, asi_pmd_alloc, asi_pte_alloc.
+ *
+ * These are like the normal xxx_alloc functions, but:
+ *
+ *  - They use atomic operations instead of taking a spinlock; this allows them
+ *    to be used from interrupts. This is necessary because we use the page
+ *    allocator from interrupts and the page allocator ultimately calls this
+ *    code.
+ *  - They support customizing the allocation flags.
+ *
+ * On the other hand, they do not use the normal page allocation infrastructure,
+ * that means that PTE pages do not have the PageTable type nor the PagePgtable
+ * flag and we don't increment the meminfo stat (NR_PAGETABLE) as they do.
+ */
+static_assert(!IS_ENABLED(CONFIG_PARAVIRT));
+#define DEFINE_ASI_PGTBL_ALLOC(base, level)				\
+__maybe_unused								\
+static level##_t * asi_##level##_alloc(struct asi *asi,			\
+				       base##_t *base, ulong addr,	\
+				       gfp_t flags)			\
+{									\
+	if (unlikely(base##_none(*base))) {				\
+		ulong pgtbl = get_zeroed_page(flags);			\
+		phys_addr_t pgtbl_pa;					\
+									\
+		if (!pgtbl)						\
+			return NULL;					\
+									\
+		pgtbl_pa = __pa(pgtbl);					\
+									\
+		if (cmpxchg((ulong *)base, 0,				\
+			    pgtbl_pa | _PAGE_TABLE) != 0) {		\
+			free_page(pgtbl);				\
+			goto out;					\
+		}							\
+									\
+		mm_inc_nr_##level##s(asi->mm);				\
+	}								\
+out:									\
+	VM_BUG_ON(base##_leaf(*base));					\
+	return level##_offset(base, addr);				\
+}
+
+DEFINE_ASI_PGTBL_ALLOC(pgd, p4d)
+DEFINE_ASI_PGTBL_ALLOC(p4d, pud)
+DEFINE_ASI_PGTBL_ALLOC(pud, pmd)
+DEFINE_ASI_PGTBL_ALLOC(pmd, pte)
+
 void __init asi_check_boottime_disable(void)
 {
 	bool enabled = IS_ENABLED(CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION_DEFAULT_ON);

-- 
2.47.1.613.gc27f4b7a9f-goog


