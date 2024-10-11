Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6E0D0D794
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 14:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QR96X5me7JPEdxmex0+cq4Kl2Zr+RXQlVgevmpU+1i0=; b=0e1oVeDRVlwr8g4ENB/it0SR2b
	/4OzWCvKmGg35bDrlTWtXMwhFSLCUTRCDWkRkzu2xB777Mrnzawh7+pwDsow513EX6jHOtDRhDPtK
	tzUVjcQTqwrQSGbhhWQVytDDKreLC0vyUnp3ohL1Kh1zYWpLT2Ob5Gl7eG7I3bm7ztMdt+KazAvmx
	D/sep1QGCPEAiWSOvoHtIXHMaXZelB0bfqXH6GESbftD+zyaYJ77GmWzornnhDZ4e6CaIXy+N3eV5
	zFGAX/8piUVniYYG1qZy8qIBtZqV+hYyEzG1+Ijf2dVHj9ZZQMxK9fqS/PwDH3oe+JgRx4JGH7Gho
	ueXamKtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szGRY-0000000GZXr-0Opf;
	Fri, 11 Oct 2024 14:16:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szFHN-0000000GNqw-3qPJ;
	Fri, 11 Oct 2024 13:02:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QR96X5me7JPEdxmex0+cq4Kl2Zr+RXQlVgevmpU+1i0=; b=p4AI8/kKqv+9NZrBGdYQ3bOLHr
	Pw0sCZdj8l0CW/QpRr44+ZlTSUh0Cr0fdSsAbdT5VXvi4LRLx+8M/qWdEw+s0rC4xzZ/yEmS4gzFp
	h0KK+vTMDM43S6qkJkaeayH/5j0g8flyL2rowaUcRvABzPIZP5oCBMkS+lifzJlfORP0OVA/RPMij
	hqVsrK5k9iZ5aFc87uGnYKsjSzqI1WmiHehOp3XA3kvRyTEKc5H/qRBy/7DrEREjYuI4qh8K+A3cJ
	PaG4QAzECdYF8HcgKBkP9BuMSxgrF6EeXn6UvHbZDIk626ZPLgGNZW3eNmovJBbKvBjInYnlnUJ/c
	Tz9WH4UA==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szFHK-00000005tKM-2GhP;
	Fri, 11 Oct 2024 13:02:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5723D5C5D87;
	Fri, 11 Oct 2024 13:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABE8C4CECC;
	Fri, 11 Oct 2024 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728651714;
	bh=j6FIkJsgrJb7Fy59tSRAkzfdThNSkDRiwl7mc5Gyfrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oaq6u26xuDAEns7R2BMHzk4mIfr5FvGiVAeZZthgyUlPcz06DFRl95J0wmkdOT54S
	 YxSAeidiUzjAm9FHVkdDWMVY0Rbrih0bi/ggL0JYHKzOopKm6PqY7SOiicdRP66yLH
	 5VGXr5I3OyVhwrNf1s3DsezlYqKELPmsDJA9V5PkevyRbR9c/cPzuOfoCS+m2Co7l0
	 +b6MYlu7b05Tu5XRA7HGcdEBXgbkMUXnasokDLcI2U83NwvkTB9/gQY3jZ2G5u5tvh
	 AFQJNhIyJak3q6KuqIiMeMoh+g8h6wyqQ854Avo5pBLLyOPI6RqZBJ4HC26lw54SRH
	 zUMItw7kbSuLg==
Date: Fri, 11 Oct 2024 15:58:04 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 6/8] x86/module: perpare module loading for ROX
 allocations of text
Message-ID: <Zwkg3LwlNJOwNWZh@kernel.org>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-7-rppt@kernel.org>
 <20241010225411.GA922684@thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010225411.GA922684@thelio-3990X>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_140158_970445_D8D8C15C 
X-CRM114-Status: GOOD (  24.71  )
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

On Thu, Oct 10, 2024 at 03:54:11PM -0700, Nathan Chancellor wrote:
> Hi Mike,
> 
> On Wed, Oct 09, 2024 at 09:08:14PM +0300, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > When module text memory will be allocated with ROX permissions, the
> > memory at the actual address where the module will live will contain
> > invalid instructions and there will be a writable copy that contains the
> > actual module code.
> > 
> > Update relocations and alternatives patching to deal with it.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> I bisected a boot failure that I see with CONFIG_CFI_CLANG enabled to
> this change as commit be712757cabd ("x86/module: perpare module loading
> for ROX allocations of text") in -next.
 
>   [    0.000000] Linux version 6.12.0-rc2-00140-gbe712757cabd (nathan@n3-xlarge-x86) (ClangBuiltLinux clang version 19.1.0 (https://github.com/llvm/llvm-project.git a4bf6cd7cfb1a1421ba92bca9d017b49936c55e4), ClangBuiltLinux LLD 19.1.0 (https://github.com/llvm/llvm-project.git a4bf6cd7cfb1a1421ba92bca9d017b49936c55e4)) #1 SMP PREEMPT_DYNAMIC Thu Oct 10 22:42:57 UTC 2024
>   ...
>   [    0.092204] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
>   [    0.093207] TAA: Mitigation: TSX disabled
>   [    0.093711] MMIO Stale Data: Mitigation: Clear CPU buffers
>   [    0.094228] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
>   [    0.095203] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
>   [    0.096203] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
>   [    0.097203] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
>   [    0.098003] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
>   [    0.098203] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
>   [    0.099203] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
>   [    0.100204] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
>   [    0.101204] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
>   [    0.102203] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
>   [    0.103204] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
>   [    0.104051] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
>   [    0.104204] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
> 
> then nothing after that. Boot is successful if CFI is not enabled (the
> initrd will just shutdown the machine after printing the version string).
> 
> If there is any further information I can provide or patches I can test,
> I am more than happy to do so.

I overlooked how cfi_*_callers routines update addr.
This patch should fix it:

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 3b3fa93af3b1..cf782f431110 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1148,11 +1148,13 @@ static int cfi_disable_callers(s32 *start, s32 *end, struct module *mod)
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
-		void *wr_addr = module_writable_address(mod, addr);
+		void *wr_addr;
 		u32 hash;
 
 		addr -= fineibt_caller_size;
-		hash = decode_caller_hash(addr);
+		wr_addr = module_writable_address(mod, addr);
+		hash = decode_caller_hash(wr_addr);
+
 		if (!hash) /* nocfi callers */
 			continue;
 
@@ -1172,11 +1174,12 @@ static int cfi_enable_callers(s32 *start, s32 *end, struct module *mod)
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
-		void *wr_addr = module_writable_address(mod, addr);
+		void *wr_addr;
 		u32 hash;
 
 		addr -= fineibt_caller_size;
-		hash = decode_caller_hash(addr);
+		wr_addr = module_writable_address(mod, addr);
+		hash = decode_caller_hash(wr_addr);
 		if (!hash) /* nocfi callers */
 			continue;
 
@@ -1249,11 +1252,12 @@ static int cfi_rand_callers(s32 *start, s32 *end, struct module *mod)
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
-		void *wr_addr = module_writable_address(mod, addr);
+		void *wr_addr;
 		u32 hash;
 
 		addr -= fineibt_caller_size;
-		hash = decode_caller_hash(addr);
+		wr_addr = module_writable_address(mod, addr);
+		hash = decode_caller_hash(wr_addr);
 		if (hash) {
 			hash = -cfi_rehash(hash);
 			text_poke_early(wr_addr + 2, &hash, 4);
@@ -1269,14 +1273,15 @@ static int cfi_rewrite_callers(s32 *start, s32 *end, struct module *mod)
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
-		void *wr_addr = module_writable_address(mod, addr);
+		void *wr_addr;
 		u32 hash;
 
 		addr -= fineibt_caller_size;
-		hash = decode_caller_hash(addr);
+		wr_addr = module_writable_address(mod, addr);
+		hash = decode_caller_hash(wr_addr);
 		if (hash) {
 			text_poke_early(wr_addr, fineibt_caller_start, fineibt_caller_size);
-			WARN_ON(*(u32 *)(addr + fineibt_caller_hash) != 0x12345678);
+			WARN_ON(*(u32 *)(wr_addr + fineibt_caller_hash) != 0x12345678);
 			text_poke_early(wr_addr + fineibt_caller_hash, &hash, 4);
 		}
 		/* rely on apply_retpolines() */
 
> Cheers,
> Nathan

-- 
Sincerely yours,
Mike.

