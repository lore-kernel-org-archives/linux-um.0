Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5796DE77188
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 20:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lMV7uJ7I18OKYw8GMGFQsmzHxbOybRxQHWQLaqO2yfM=; b=ECBGbSN4M9hBZQKTZErLRyN3J6
	n9p6mgKt6geR1MMfAF+/UsIPs27eUhsmC4KYARPVb3YfOyi0kBntl9tcECpjtiUUgspXLtrlyLQcm
	h64bi09+QLQL1ON+JlkBucc7lzdkrhu8OIMsWezUasofRL508zhHEz/VpDND8BxCB9wXSCb8bv1v8
	IRXr5u0ql5P5Pz733O8go6PURokgv5RHs5rvpxKAQ+sDIzi3jOaFGwdvPyr8jsTNiRH6/e9M505QR
	A1HZEIqU7d6fILTEEu1cdZHC82hRku1Tdcn1u2EiGJhQRzhZYhgUIouYQaVHa5iDXv43JDtpbTD9e
	BKInOzdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWLYt-0000000GsyA-12Kf;
	Fri, 10 Jan 2025 20:24:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwF-0000000GbB5-21nJ
	for linux-um@bombadil.infradead.org;
	Fri, 10 Jan 2025 18:40:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lMV7uJ7I18OKYw8GMGFQsmzHxbOybRxQHWQLaqO2yfM=; b=FGe+SI25defFW6EcNmMwCFS6Jc
	eKE0g/8HKxq0kEBuNsqBoeP9DTuMblnVR9Vayl0+AGDQbFhRCPM4shOnPG7n6Nr7VP77O1mqcj2Bt
	UnGw4PHb+yVQF98SJRx9hGxqzyz2B05BbUa0X+2eYrIwjveoW5VV1b6Bl0vr6gGG/fYMU5HimpwI2
	FuJnbZwYkLrunHp1TxuZ+qdE/JGzPPaQJqD8fiCm7a3BB3ZlmRs3dg9L0sUj6MeARanZp8ayJFlpb
	rZYb5G86zmcxL3frjCXewib/AGAInl9BcLLQ0OGLANO9uHerz4pRN1C7keUEuOP6syuNZqT6H6pll
	ktcgiXmg==;
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwA-00000009sDK-2g4b
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 18:40:54 +0000
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-43621907030so19337355e9.1
        for <linux-um@lists.infradead.org>; Fri, 10 Jan 2025 10:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534448; x=1737139248; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMV7uJ7I18OKYw8GMGFQsmzHxbOybRxQHWQLaqO2yfM=;
        b=AeDmocrQ6kKyHVY0ETjASJms9JGBDnaH1a7CSHBzIlvK9YxiniTrGP+KM3mVM+DhhA
         57nMvQis6dVYBSjOxPjnVf0Axi82dbj3Et4DSbM8NToI+pwmZItibhz3vb7G7No4caYV
         B5pblVuehnd2zr7oWGQo1g+ic1QwhUe0q07PCK9DIeNe6HpJH596+P6LjWg4BQKg6ivP
         wQAv9OJ3Xu0HcMK2jSQ57hwhKI89umdLy56/Mm01CrHuqnRYTGenms25oC0lVbSeT88E
         Ja+fG+Af89pZbB7SwdH3cfde5GlV0LJo42iqtuVriwpmnUVvcj58V+z0aQ89eba6VVVT
         9u1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534448; x=1737139248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMV7uJ7I18OKYw8GMGFQsmzHxbOybRxQHWQLaqO2yfM=;
        b=p/ixHYr7Ew6atiXFePhio7FrRIQNv2ADQZrMELqJEC72XT+hNCYI2ZS5x9s+UGl9wk
         XSI/uAp7h59LWwNUGcpzpPEDjTB/qbQtfScwHOGzgSe/2lvaJeKjbqQEDi4xdnGNxq6I
         XC2aumG+BoSPN20yR9pViUBYCeQ87QZZv2gSN5phLNqrlOEbKwckNkOnsYD6RYwpglqC
         ZRXxYq/dZEvclQHPem+XOab2fpARPH9ivIY2THjXFXOh3D28pBYlkQs6In9SlJSIPZoq
         6POnqdGMCqFfPhqG4pnm3I6veWd34+SB3JiyYitLL5p3SBwf/5FxJg+NJWIBbRA8FOss
         VeHA==
X-Forwarded-Encrypted: i=1; AJvYcCURjqijhlnKYFQJYUWUNf86Ie2ejLUwlxeZhoQAbLL43/mMBd/v/IL9/nqYgY9i+fasblvuKNbI+A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyDB9U4b4hvp8MFNPnqX7p8+awV7serNXvhR2nvImmKsTTw4mxz
	iLWxr4yupxW/bMrnWsoD6XfQ5qpy8avTn/isVUSRqM657PaO8jeH+jgc+7zfQPZhket1A0QmDKy
	fx3mT0vpsEw==
X-Google-Smtp-Source: AGHT+IFp39E9krgcILEXjwgS0eG/yaDAJpZCMdfJgN+pTbMyBclx0Pttf9qnW8OHp1hJ5TpOh65GX4riAPR9zA==
X-Received: from wmbbd12.prod.google.com ([2002:a05:600c:1f0c:b0:434:fd41:173c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d03:b0:434:a781:f5d9 with SMTP id 5b1f17b1804b1-436e2697b32mr62972955e9.11.1736534447848;
 Fri, 10 Jan 2025 10:40:47 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:27 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-1-8419288bc805@google.com>
Subject: [PATCH RFC v2 01/29] mm: asi: Make some utility functions noinstr compatible
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
X-CRM114-CacheID: sfid-20250110_184050_755454_2DBD2D0C 
X-CRM114-Status: GOOD (  21.18  )
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

Some existing utility functions would need to be called from a noinstr
context in the later patches. So mark these as either noinstr or
__always_inline.

An earlier version of this by Junaid had a macro that was intended to
tell the compiler "either inline this function, or call it in the
noinstr section", which basically boiled down to:

 #define inline_or_noinstr noinline __section(".noinstr.text")

Unfortunately Thomas pointed out this will prevent the function from
being inlined at call sites in .text.

So far I haven't been able[1] to find a formulation that lets us :
1. avoid calls from .noinstr.text -> .text,
2. while also letting the compiler freely decide what to inline.

1 is a functional requirement so here I'm just giving up on 2. Existing
callsites of this code are just forced inline. For the incoming code
that needs to call it from noinstr, they will be out-of-line calls.

[1] https://lore.kernel.org/lkml/CA+i-1C1z35M8wA_4AwMq7--c1OgjNoLGTkn4+Td5gKg7QQAzWw@mail.gmail.com/

Checkpatch-args: --ignore=COMMIT_LOG_LONG_LINE
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/processor.h     |  2 +-
 arch/x86/include/asm/special_insns.h |  8 ++++----
 arch/x86/include/asm/tlbflush.h      |  3 +++
 arch/x86/mm/tlb.c                    | 13 +++++++++----
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4a686f0e5dbf6d906ed38276148b186e920927b3..1a1b7ea5d7d32a47d783d9d62cd2a53672addd6f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -220,7 +220,7 @@ void print_cpu_msr(struct cpuinfo_x86 *);
 /*
  * Friendlier CR3 helpers.
  */
-static inline unsigned long read_cr3_pa(void)
+static __always_inline unsigned long read_cr3_pa(void)
 {
 	return __read_cr3() & CR3_ADDR_MASK;
 }
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index aec6e2d3aa1d52e5c8f513e188015a45e9eeaeb2..6e103358966f6f1333aa07be97aec5f8af794120 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -42,14 +42,14 @@ static __always_inline void native_write_cr2(unsigned long val)
 	asm volatile("mov %0,%%cr2": : "r" (val) : "memory");
 }
 
-static inline unsigned long __native_read_cr3(void)
+static __always_inline unsigned long __native_read_cr3(void)
 {
 	unsigned long val;
 	asm volatile("mov %%cr3,%0\n\t" : "=r" (val) : __FORCE_ORDER);
 	return val;
 }
 
-static inline void native_write_cr3(unsigned long val)
+static __always_inline void native_write_cr3(unsigned long val)
 {
 	asm volatile("mov %0,%%cr3": : "r" (val) : "memory");
 }
@@ -153,12 +153,12 @@ static __always_inline void write_cr2(unsigned long x)
  * Careful!  CR3 contains more than just an address.  You probably want
  * read_cr3_pa() instead.
  */
-static inline unsigned long __read_cr3(void)
+static __always_inline unsigned long __read_cr3(void)
 {
 	return __native_read_cr3();
 }
 
-static inline void write_cr3(unsigned long x)
+static __always_inline void write_cr3(unsigned long x)
 {
 	native_write_cr3(x);
 }
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 69e79fff41b800a0a138bcbf548dde9d72993105..c884174a44e119a3c027c44ada6c5cdba14d1282 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -423,4 +423,7 @@ static inline void __native_tlb_flush_global(unsigned long cr4)
 	native_write_cr4(cr4 ^ X86_CR4_PGE);
 	native_write_cr4(cr4);
 }
+
+unsigned long build_cr3_noinstr(pgd_t *pgd, u16 asid, unsigned long lam);
+
 #endif /* _ASM_X86_TLBFLUSH_H */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 86593d1b787d8a5b9fa4bd492356898ec8870938..f0428e5e1f1947903ee87c4c6444844ee11b45c3 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -108,7 +108,7 @@
 /*
  * Given @asid, compute kPCID
  */
-static inline u16 kern_pcid(u16 asid)
+static __always_inline u16 kern_pcid(u16 asid)
 {
 	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
 
@@ -153,9 +153,9 @@ static inline u16 user_pcid(u16 asid)
 	return ret;
 }
 
-static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, unsigned long lam)
+static __always_inline unsigned long build_cr3(pgd_t *pgd, u16 asid, unsigned long lam)
 {
-	unsigned long cr3 = __sme_pa(pgd) | lam;
+	unsigned long cr3 = __sme_pa_nodebug(pgd) | lam;
 
 	if (static_cpu_has(X86_FEATURE_PCID)) {
 		cr3 |= kern_pcid(asid);
@@ -166,6 +166,11 @@ static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, unsigned long lam)
 	return cr3;
 }
 
+noinstr unsigned long build_cr3_noinstr(pgd_t *pgd, u16 asid, unsigned long lam)
+{
+	return build_cr3(pgd, asid, lam);
+}
+
 static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid,
 					      unsigned long lam)
 {
@@ -1084,7 +1089,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
  * It's intended to be used for code like KVM that sneakily changes CR3
  * and needs to restore it.  It needs to be used very carefully.
  */
-unsigned long __get_current_cr3_fast(void)
+noinstr unsigned long __get_current_cr3_fast(void)
 {
 	unsigned long cr3 =
 		build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,

-- 
2.47.1.613.gc27f4b7a9f-goog


