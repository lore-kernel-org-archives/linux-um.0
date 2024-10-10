Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12D5D2444F
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 22:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CtnQW9M1qfhCyoSIRxyhjm78v3iEbXx5vUa6szTpCQ0=; b=Vcz/4Ph/widGG7l3kEmIjxbhFd
	mvCE//3ELeM+Z6TFecQ/lJ7nucnam5SvRJLFaNzG+VmZb2SebtFGoxi6yU5JG+YNhzYAtn3HRHfqh
	u9AbXG94DTcocygiFcQIj/Zgm5poMOzrkQ2DHSj6gjaMpwHolv18MgVnBBJjWzyDXkxzONPsSGlP/
	oedeQHCJGR5UyNV0E6RKiQaYC1fxI80F+nE4fQi+qd1HM35QgD+WXmfqWI2KyXZNvsq6SjVEDaGx3
	HM/XFxDQNPT75X6P8/yiydre6Igtj/Y4/d8YGSFb9zQWrda3Sr/l23H70+OevXXiym5MOjMrmZ4hO
	qiLI9Mvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sz24K-0000000EbUS-1R9t;
	Thu, 10 Oct 2024 22:55:40 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz238-0000000EbFO-08JX;
	Thu, 10 Oct 2024 22:54:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CtnQW9M1qfhCyoSIRxyhjm78v3iEbXx5vUa6szTpCQ0=; b=hO6tn1H2MKq5a/Uq7qZ7Rq8cCq
	SyqGCObhSEsyT7YHwFswLUWCnKdTVPDvZmPEoJYWd5ecyZ/rEpR64YacDNoeHobW1c+PpS7DJrnfI
	B/vzsp1V9aOI8vH9ntB0doGnx5fT83/uVBjr4F/YJQrvAz9p31Ee5xXBH7stc80N9vKqt4xOsaSRa
	Q7yUH4jFlTb9B7k1D5DWKGGFRZ8HHe6Bq6vtaz4g6EpE6AY7LmbJVS9u69274orwA57FqyaBRNI6I
	Ipb697OicfbtOj+t1lKjCz+3GpWgBuhlbhqQdAGo/+6xHpjfu4jzIbVxsREFOLtKk7YLNNhQmWPh+
	ycXI/Qzw==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz233-00000005ihC-0k2T;
	Thu, 10 Oct 2024 22:54:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 072705C5FDE;
	Thu, 10 Oct 2024 22:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7BFC4CEC5;
	Thu, 10 Oct 2024 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728600856;
	bh=dRFHj5mtH0xn8PBj2ZbOuI6o6u0ly0QH1iws5fctk8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiUIOLSBcasoVYYND8KdWz7eQh/+0boOgNRGeOQlhf5jvA1/EBnMYKjn5VICJ3eAY
	 cnnu9shlCLMfTHHTHra7MnZ0rLJlXd0Hph0c0PBZ21X9KTVg4eVdzFCTR7+dIRdltD
	 hxCWp0qmt+fIbgTEcIZSFHp2Q6iE2wK9yyyZ4vyAJOkCE63MHkbL8C+vAlgxvUIB86
	 jOXbNmyf7S3aQkYS+MyXLrzvy5GjYypHqnc1WER+qWs986tCcEJrL1436xfNVNVaY8
	 SuEhjakzc9ZUyRU5YtUSasIp4EiqD3HrJhbPDpQFeVHrdwLEF3yFgOYnlD+BEfVYYI
	 t/83JFWrskzLQ==
Date: Thu, 10 Oct 2024 15:54:11 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
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
Message-ID: <20241010225411.GA922684@thelio-3990X>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-7-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009180816.83591-7-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_235422_013925_67909470 
X-CRM114-Status: GOOD (  15.82  )
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

Hi Mike,

On Wed, Oct 09, 2024 at 09:08:14PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> When module text memory will be allocated with ROX permissions, the
> memory at the actual address where the module will live will contain
> invalid instructions and there will be a writable copy that contains the
> actual module code.
> 
> Update relocations and alternatives patching to deal with it.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

I bisected a boot failure that I see with CONFIG_CFI_CLANG enabled to
this change as commit be712757cabd ("x86/module: perpare module loading
for ROX allocations of text") in -next.

  $ echo CONFIG_CFI_CLANG=y >arch/x86/configs/cfi.config

  $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 mrproper defconfig cfi.config bzImage

  $ curl -LSs https://github.com/ClangBuiltLinux/boot-utils/releases/download/20230707-182910/x86_64-rootfs.cpio.zst | zstd -d >rootfs.cpio

  $ qemu-system-x86_64 \
      -display none \
      -nodefaults \
      -M q35 \
      -d unimp,guest_errors \
      -append 'console=ttyS0 earlycon=uart8250,io,0x3f8' \
      -kernel arch/x86/boot/bzImage \
      -initrd rootfs.cpio \
      -cpu host \
      -enable-kvm \
      -m 512m \
      -smp 8 \
      -serial mon:stdio
  [    0.000000] Linux version 6.12.0-rc2-00140-gbe712757cabd (nathan@n3-xlarge-x86) (ClangBuiltLinux clang version 19.1.0 (https://github.com/llvm/llvm-project.git a4bf6cd7cfb1a1421ba92bca9d017b49936c55e4), ClangBuiltLinux LLD 19.1.0 (https://github.com/llvm/llvm-project.git a4bf6cd7cfb1a1421ba92bca9d017b49936c55e4)) #1 SMP PREEMPT_DYNAMIC Thu Oct 10 22:42:57 UTC 2024
  ...
  [    0.092204] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
  [    0.093207] TAA: Mitigation: TSX disabled
  [    0.093711] MMIO Stale Data: Mitigation: Clear CPU buffers
  [    0.094228] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
  [    0.095203] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
  [    0.096203] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
  [    0.097203] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
  [    0.098003] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
  [    0.098203] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
  [    0.099203] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
  [    0.100204] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
  [    0.101204] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
  [    0.102203] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
  [    0.103204] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
  [    0.104051] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
  [    0.104204] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.

then nothing after that. Boot is successful if CFI is not enabled (the
initrd will just shutdown the machine after printing the version string).

If there is any further information I can provide or patches I can test,
I am more than happy to do so.

Cheers,
Nathan

