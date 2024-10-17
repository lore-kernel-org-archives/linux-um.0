Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917A6D2127F
	for <linux-um@archiver.kernel.org>; Thu, 17 Oct 2024 11:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5TEnRdFDrGp3g8cb84z8escMU96OZKkwtQ0FRZiWHBE=; b=etVMcfXiASp4bsG+KgOQVgvwG+
	NmwL3+ajznxkvVX6tEehQbF5Z6q7pn836X6IMJ16d2/9W7VI9HRryg5Icvr3k96XT3Wj9Vmeq6M3G
	Bq08e+YSzfRPXUDv4XO4Svn2uZpRuTooD1zQvABGI7Bz9u6R+vPqlJmi4s9JPSFpmkaesApBjoftg
	RvZPhvSPyax6eJtrsQqEgxTljZsGh6uJVDthGciR/8jBK+ylGJtNW1ydiCacT2Yp++hSYnjpYwWXa
	AdmtOQ0fr/tsJPQKyWp4sf2Ri4BGlvXVND40lKs5bG7WeezcpdgktCzaI1X4nFky5DZoACQ8M7UFh
	27jP5FbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Ogp-0000000Edtg-3FYl;
	Thu, 17 Oct 2024 11:29:11 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Ogh-0000000EdpP-3inN;
	Thu, 17 Oct 2024 11:29:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E816CA43D50;
	Thu, 17 Oct 2024 11:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51E6C4CEC3;
	Thu, 17 Oct 2024 11:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729164541;
	bh=rt80HNwYvry4F4GclVQlY1veJ+krWpXQVKReUpcl890=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ot+aEOLgX5JjytFWTSP6bvwXMFkowa3+f8eQ2nWquiQ2RAv0bCvly8HaX5AltuwSG
	 MSL87zIBHWGLQnCmCdiEfFC7X5ejkFjDqsJRxmUPBDOphZUPBuoh9vgoceix8Psav5
	 Yvn0UgFKrQvx/wSoy69QgTtp5NCCSdTL6QB1vx3PWWPTlokB4+yqFBJYWypC9U2bHQ
	 nQtmXd5x7H21VQL4AHHLnM8nJNg1uOm2mWoaE2bjtRwnQ1e9g0HZLSZljRpX0WRG/I
	 j7Jg7Czseip6435Tp950cr2IcSkIthwfZaEljLp7+y1XWJYi+AU0xcha6M5b6FnQGJ
	 4UYbNkR0gIbzA==
Date: Thu, 17 Oct 2024 14:25:05 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
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
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
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
Subject: Re: [PATCH v6 6/8] x86/module: prepare module loading for ROX
 allocations of text
Message-ID: <ZxD0EVBoO-jcxEGE@kernel.org>
References: <20241016122424.1655560-1-rppt@kernel.org>
 <20241016122424.1655560-7-rppt@kernel.org>
 <20241016170128.7afeb8b0@gandalf.local.home>
 <20241017093515.GU16066@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017093515.GU16066@noisy.programming.kicks-ass.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_042904_229178_97028133 
X-CRM114-Status: GOOD (  29.16  )
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

On Thu, Oct 17, 2024 at 11:35:15AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 16, 2024 at 05:01:28PM -0400, Steven Rostedt wrote:
> > On Wed, 16 Oct 2024 15:24:22 +0300
> > Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > > diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> > > index 8da0e66ca22d..b498897b213c 100644
> > > --- a/arch/x86/kernel/ftrace.c
> > > +++ b/arch/x86/kernel/ftrace.c
> > > @@ -118,10 +118,13 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
> > >  		return ret;
> > >  
> > >  	/* replace the text with the new text */
> > > -	if (ftrace_poke_late)
> > > +	if (ftrace_poke_late) {
> > >  		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
> > > -	else
> > > -		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
> > > +	} else {
> > > +		mutex_lock(&text_mutex);
> > > +		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
> > > +		mutex_unlock(&text_mutex);
> > > +	}
> > >  	return 0;
> > >  }
> > 
> > So this slows down the boot by over 30ms. That may not sound like much, but
> > we care very much about boot times. This code is serialized with boot and
> > runs whenever ftrace is configured in the kernel. The way I measured this,
> > was that I added:
> > 
> 
> > If this is only needed for module load, can we at least still use the
> > text_poke_early() at boot up?
> 
> Right, so I don't understand why this is needed at all.
> ftrace_module_init() runs before complete_formation() which normally
> switches to ROX, as such ftrace should be able to continue to do direct
> modifications here.

With this series the module text is allocated as ROX at the first place, so
the modifications ftrace does to module text have to either use text poking
even before complete_formation() or deal with a writable copy like I did
for relocations and alternatives.

I've been carrying the ftrace changes from a very old prototype and
didn't pay enough attention to them them until Steve's complaint.

I'll look into it.
 
> Which reminds me, at some point I did patches adding a
> MODULE_STATE_UNFORMED callback in order for static_call / jump_label to
> be able to avoid the expensive patching on module load as well (arguably
> ftrace should be using that too, instead of a custom callback).
> 

-- 
Sincerely yours,
Mike.

