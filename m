Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D99CED273
	for <linux-um@archiver.kernel.org>; Tue,  8 Oct 2024 06:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ytn5ipKOi2iwHXLlnzsD5i06mmFCc0Gkvx6tbtOc3M=; b=cZ+LDt73sC0VB3v9J6yeGl1Ltq
	Inaio2TLNwcNOFpyNZa/PMNVO7d8F7oHfUztQN6FAcz2p5U8Tr7ly2BWJYZzCe4Op8QzoJaIqtzE1
	OrtDlMt7oAAK5Q98Zg7IxsASg5Yi1jtPL2fbkvorvDE9hXsOUWg3aMOXKmbDrUO3evMMGS8LPOfyj
	iBNediecD8XHP1O/Nl3r1kerNgv1VpBbW8pseQK2TygWWZn2HG42OpMzTxq9OF5zLbdvQ3+JMpaLt
	UfEjK6LRn7qpFso+SlRPjOXUWVWQGIBSnh765/6CLieu1QjFyUB5GfhwhFjOFMVE/yw9bvsUX81k7
	sp/lshIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3dC-00000004djD-0yWi;
	Tue, 08 Oct 2024 06:23:38 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3cc-00000004dYy-3nWm;
	Tue, 08 Oct 2024 06:23:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id F05D1A43229;
	Tue,  8 Oct 2024 06:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C076C4CEC7;
	Tue,  8 Oct 2024 06:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728368581;
	bh=7+OOlYDwjjrmYkugp0zG3rCIOBJXVhabkZlBvijiN0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLZ7O/HpKqwZhtBX1cNCiAk8EV6vD0WzAl1dR/RILMS7jSHhGDnYDNH2Dzn6ECEly
	 M0+GSr/JGL8nAopaejPjKSQKa6Jmnx6kHabKvo9FyggKvIK/+rwoLnO5mphSBOrVi8
	 U9wdgL7Nl7zM0jbSh9FiGcxw5b5J+su+JR+7Gf4XG9wvT3v6GVYlXJH8m3l11OFKZ1
	 9jEHuFYuJh2kBStvb3JCpXCoRR3L/JiHNjMlM70jCbMyIiQEwYJp2wijiSZ4G1su3J
	 9j8W/sm+G2yCx41UsRZ1DC/eNueJYqT+Lq5WzrcGaGCVNkuw9bP/AltQfceSnkaSt6
	 lK+siW3UD/EyQ==
Date: Tue, 8 Oct 2024 09:19:13 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
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
	Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v4 5/8] arch: introduce set_direct_map_valid_noflush()
Message-ID: <ZwTO4S_smfPbP06x@kernel.org>
References: <20241007062858.44248-1-rppt@kernel.org>
 <20241007062858.44248-6-rppt@kernel.org>
 <CAAhV-H4u5qk-Zd8ctiooCv_hGKbDpXRAtTZMMsUab9bbLAnd5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4u5qk-Zd8ctiooCv_hGKbDpXRAtTZMMsUab9bbLAnd5A@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_232303_225392_EAA40D24 
X-CRM114-Status: GOOD (  21.80  )
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

Hi Huacai,

On Tue, Oct 08, 2024 at 10:11:25AM +0800, Huacai Chen wrote:
> Hi, Mike,
> 
> On Mon, Oct 7, 2024 at 2:30 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > Add an API that will allow updates of the direct/linear map for a set of
> > physically contiguous pages.
> >
> > It will be used in the following patches.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  arch/arm64/include/asm/set_memory.h     |  1 +
> >  arch/arm64/mm/pageattr.c                | 10 ++++++++++
> >  arch/loongarch/include/asm/set_memory.h |  1 +
> >  arch/loongarch/mm/pageattr.c            | 21 +++++++++++++++++++++
> >  arch/riscv/include/asm/set_memory.h     |  1 +
> >  arch/riscv/mm/pageattr.c                | 15 +++++++++++++++
> >  arch/s390/include/asm/set_memory.h      |  1 +
> >  arch/s390/mm/pageattr.c                 | 11 +++++++++++
> >  arch/x86/include/asm/set_memory.h       |  1 +
> >  arch/x86/mm/pat/set_memory.c            |  8 ++++++++
> >  include/linux/set_memory.h              |  6 ++++++
> >  11 files changed, 76 insertions(+)
> >
> > diff --git a/arch/loongarch/include/asm/set_memory.h b/arch/loongarch/include/asm/set_memory.h
> > index d70505b6676c..55dfaefd02c8 100644
> > --- a/arch/loongarch/include/asm/set_memory.h
> > +++ b/arch/loongarch/include/asm/set_memory.h
> > @@ -17,5 +17,6 @@ int set_memory_rw(unsigned long addr, int numpages);
> >  bool kernel_page_present(struct page *page);
> >  int set_direct_map_default_noflush(struct page *page);
> >  int set_direct_map_invalid_noflush(struct page *page);
> > +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
> >
> >  #endif /* _ASM_LOONGARCH_SET_MEMORY_H */
> > diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
> > index ffd8d76021d4..f14b40c968b4 100644
> > --- a/arch/loongarch/mm/pageattr.c
> > +++ b/arch/loongarch/mm/pageattr.c
> > @@ -216,3 +216,24 @@ int set_direct_map_invalid_noflush(struct page *page)
> >
> >         return __set_memory(addr, 1, __pgprot(0), __pgprot(_PAGE_PRESENT | _PAGE_VALID));
> >  }
> > +
> > +int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
> > +{
> > +       unsigned long addr = (unsigned long)page_address(page);
> > +       pgprot_t set, clear;
> > +
> > +       return __set_memory((unsigned long)page_address(page), nr, set, clear);
> This line should be removed.

Argh, copy/paste is so hard...

Thanks, will do.
 
> Huacai

-- 
Sincerely yours,
Mike.

