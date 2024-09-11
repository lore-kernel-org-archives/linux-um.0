Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20520EE498D
	for <linux-um@archiver.kernel.org>; Wed, 11 Sep 2024 10:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gilhAcdrA7pGmi/s85r2gM91YcnlghiT9xFnkSLLu+Y=; b=TD4V3mWAPIYx4Xn2LKqJ1A+qBS
	7DC/BdyDf1BMOOnCuFAdmQiiaCAoDG3qFfIoYG1qQeMUiKW4Cag4gVM3pYVeCFN8RFSlrvPoW+jbn
	Xeu+lN5gSQe1oaDE0zrnvGJLNWj1klzxFLaTKfrHEc9lLnxS4LvDJhLMp7bPuK1m4l/KfeevbIzib
	qkSQOXwe48iSO4rX800H30wJLPPZLNGn620T5MtQtowFLiINYOSfiLQxREzeeZuq/Z+BaAA8f+i0n
	cxlM7MXxcp3ywRMa3aX4fWMNCX8CIVQOzy0AMbXOqgSj51T+Y6sUDiLGomreTsYrJ0z+SuCnAwxeG
	x83jaS/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soKaL-000000095Yj-1pY2;
	Wed, 11 Sep 2024 10:28:29 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soKUQ-0000000948R-2219;
	Wed, 11 Sep 2024 10:22:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4C9715C0235;
	Wed, 11 Sep 2024 10:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6640EC4CEC5;
	Wed, 11 Sep 2024 10:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726050140;
	bh=8dWUooDoOxWC7Oca2MrJGx9YGMSeHFyGIMo9brZfk4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MbotaJ9vmctcoaZuCwWhMhi9fy5FIYS+b/HAYEruiQzbymZobfKvo47gbwbW+fy1t
	 kmLvVspCoENf4YJ7MG6qyNvTNAzqVaH95FS48N7vxf5HH4w5x9HqfrCJhhZOz0qSYT
	 FD4o6UXDBrwti0gG104xpdNn7cPukgyiIL3B2k9CSxzBbiHil9QxdJScuV7IplHt5W
	 o1J96IBLlfPsULekNIV4gsIz3YvGb3R5Lz6mZ8XITZx+iA0s8RnjfUTf8lq+EpquOb
	 tNbpjbzeeIR2Bev+q9SOEtahsme33D5y9Lo7KW1fhsL38m9Zfs1kaXRBBkfiBGmn1+
	 HGqEyFiCasPYg==
Date: Wed, 11 Sep 2024 13:19:07 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
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
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
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
Subject: Re: [PATCH v3 6/8] x86/module: perpare module loading for ROX
 allocations of text
Message-ID: <ZuFumwtGQGOPMDo3@kernel.org>
References: <20240909064730.3290724-1-rppt@kernel.org>
 <20240909064730.3290724-7-rppt@kernel.org>
 <20240909092923.GB4723@noisy.programming.kicks-ass.net>
 <Zt8HiAzcaZS8lHT-@kernel.org>
 <20240909104940.71d8464c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909104940.71d8464c@gandalf.local.home>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_032222_672185_9C64051A 
X-CRM114-Status: GOOD (  16.40  )
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

On Mon, Sep 09, 2024 at 10:49:40AM -0400, Steven Rostedt wrote:
> On Mon, 9 Sep 2024 17:34:48 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > > This is insane, just force BUILDTIME_MCOUNT_SORT  
> > 
> > The comment in ftrace.c says "... while mcount loc in modules can not be
> > sorted at build time"
> >  
> > I don't know enough about objtool, but I'd presume it's because the sorting
> > should happen after relocations, no?
> > 
> 
> IIRC, the sorting at build time uses scripts/sorttable.c, which from what I
> can tell, only gets called on vmlinux.

Regardless of the tool, the sorting should be done after relocation, no?

But isn't mcount loc is in data section? Then there should be no problem
just drop this patch
 
> -- Steve

-- 
Sincerely yours,
Mike.

