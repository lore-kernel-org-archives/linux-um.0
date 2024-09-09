Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D475BECE57B
	for <linux-um@archiver.kernel.org>; Mon,  9 Sep 2024 09:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f16Hum48X2/PRv+OYRnrqWvXhbLKUUXP4MBg4DPZdlQ=; b=Ft8m2Fq7CWXg1G2FOTEqp+UmLH
	eiAFJeD+seb85X02dK58ebmedo1IsimREInv/TmwCO5zBJdq73wXggShF9DDniBLO2h5EvEUGkpEG
	V5pIjcUwFFyrMMPcXszfKephemlFWIaSj+1pxjM7AZlci5WP+hI0WcDUqdsp9eOvzdXTtDB4RuwWZ
	AQaLh4t8bo+N+e06uil/3DTHwscJl+njVKTyncYFqpDYzDooU/BH4MjcnPUuZ+N40n4xLysfpQP0+
	+NIVimeKLMfekUBQgTUD5AlfVR/mxE8uJKiybEdsn8xnxi26HHheHM4Dj7ydno4X39tCFc7YdZAys
	H4LRnSUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snaiK-00000001Jgq-0u1h;
	Mon, 09 Sep 2024 09:29:40 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snaiG-00000001JdG-2Ibo;
	Mon, 09 Sep 2024 09:29:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f16Hum48X2/PRv+OYRnrqWvXhbLKUUXP4MBg4DPZdlQ=; b=PHcK1SUWaNK+mGL/l3LU81VEdD
	D9nBb1lF9fC+k5KduxINliKCuQNtwOV9r3VV7JhDFojWrMZqtjtzwsWQR7ymjqHMdZK4/Tzo1krQG
	l72L0TWbRaFKsNxIJEvL02K4akN/vihdxELVqTsQPMZh102jhI0PE6Yrqkpm+R5bTxUWvCjPykmtq
	WlbddJH0odsLTU/9pMOdxn+PkTNa49n7N5ZvM4UD0maObK3Zd9qj9kNJXbjqHQeNmT1JTuolvrtNi
	Vpta2pPXprvf8lrp/xLulCdRHeE9tzU/AQ/jRdr1yi09xwhjfkgynp4ly+k7LQoKGQqGefX9PFflQ
	rxIuTYAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1snai3-0000000AlXL-0vBQ;
	Mon, 09 Sep 2024 09:29:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 80F5330047C; Mon,  9 Sep 2024 11:29:23 +0200 (CEST)
Date: Mon, 9 Sep 2024 11:29:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v3 6/8] x86/module: perpare module loading for ROX
 allocations of text
Message-ID: <20240909092923.GB4723@noisy.programming.kicks-ass.net>
References: <20240909064730.3290724-1-rppt@kernel.org>
 <20240909064730.3290724-7-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909064730.3290724-7-rppt@kernel.org>
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

On Mon, Sep 09, 2024 at 09:47:28AM +0300, Mike Rapoport wrote:
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 8da0e66ca22d..563d9a890ce2 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c

> @@ -654,4 +656,15 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>  }
>  #endif
>  
> +void ftrace_swap_func(void *a, void *b, int n)
> +{
> +	unsigned long t;
> +
> +	WARN_ON_ONCE(n != sizeof(t));
> +
> +	t = *((unsigned long *)a);
> +	text_poke_copy(a, b, sizeof(t));
> +	text_poke_copy(b, &t, sizeof(t));
> +}

This is insane, just force BUILDTIME_MCOUNT_SORT

