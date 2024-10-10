Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD713CF11F4
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 13:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cPMXZCtGVsXXTQe/GGlDBbrLC+/ZwOWPH4PT2f+WeoU=; b=Q+rkik2RVYSHh++euRZbznTNql
	M1PdEubVXMpPTn/hHNouq6Th47T8uvyQS7nqvEcCo2pjew6oZvmyRc+E4DP2Nj0XhyTxo5NNdCqlr
	6yu162lItG9sXIvt2A5TUxCnNnPetVu3oRY3Hyc9sNTBvxlszsGDwRnvR9JmAKOPAYl1cU3N69jEp
	EPbIKvCUXRZgEvQcVG8QbpXNAWPT8qLgkGpHieRJsSYoqUu769Xil04b2YP6FtkhaJjKqfpedo4Uj
	HQyL83aBEk7Nb0zziM/9z/thbmpR8gsiFUVnc/oHCsww4ZokYRSQwLqVSMoVjn3lMMnLViIFN0hQH
	f894+8dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syszY-0000000CsFV-0cXO;
	Thu, 10 Oct 2024 13:14:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sysnF-0000000CpdO-0bZv;
	Thu, 10 Oct 2024 13:01:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 645C55C57C3;
	Thu, 10 Oct 2024 13:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F0EC4CEC5;
	Thu, 10 Oct 2024 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728565283;
	bh=0gFND+MAHX6q3fPU9Dm7aa3AX+VkNdk2ZdK9663ePGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i15xpEq/kuFAv6DlXG15A1e80Zkeyfpm7KcH2z/4b7LHy0huNtJIfhTPl8l4m2Thz
	 DrC+EerzAtj77QkSwvdLuoM9HsdVcSXAYblfY52ni7z3rWCwNvYecLnzzamyv05TxQ
	 MvyRQw4iBhqZGVncP0l5I4u44ZK9GkUbVv2NjZJ1KmbX6KkRkPzCVKd/P5aEdD5W04
	 r/juMpxct8TYbYtPQygo8mwFvlF95PkeOYNJV8aiyjpOL0HlbI0t0P6KYVnwxFYXRs
	 bP4FdthxlHe3zfpEHTln3UXCWui5XHPdWaBkcJjwrkqkqBVwNb4EXbX5FI3Wx8W6oT
	 ueyyZehAwF8+A==
Date: Thu, 10 Oct 2024 15:57:33 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v5 7/8] execmem: add support for cache of large ROX pages
Message-ID: <ZwfPPZrxHzQgYfx7@kernel.org>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-8-rppt@kernel.org>
 <Zwd7GRyBtCwiAv1v@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwd7GRyBtCwiAv1v@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_060125_282552_764E61A0 
X-CRM114-Status: GOOD (  14.79  )
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

On Wed, Oct 09, 2024 at 11:58:33PM -0700, Christoph Hellwig wrote:
> On Wed, Oct 09, 2024 at 09:08:15PM +0300, Mike Rapoport wrote:
> >  /**
> >   * struct execmem_info - architecture parameters for code allocations
> > + * @fill_trapping_insns: set memory to contain instructions that will trap
> >   * @ranges: array of parameter sets defining architecture specific
> >   * parameters for executable memory allocations. The ranges that are not
> >   * explicitly initialized by an architecture use parameters defined for
> >   * @EXECMEM_DEFAULT.
> >   */
> >  struct execmem_info {
> > +	void (*fill_trapping_insns)(void *ptr, size_t size, bool writable);
> >  	struct execmem_range	ranges[EXECMEM_TYPE_MAX];
> 
> Why is the filler an indirect function call and not an architecture
> hook?

The idea is to keep everything together and have execmem_info describe all
that architecture needs. 

-- 
Sincerely yours,
Mike.

