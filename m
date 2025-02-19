Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E956C021B1
	for <linux-um@archiver.kernel.org>; Wed, 19 Feb 2025 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dFxe56y64fz2EeT0c2Pu85pRgsY04A3JsiBl9id3tQc=; b=lLCdf2mfTkCXohBR2RxBeSxoN5
	gip7ZU/uJs4bFiwcD+DtwDcvPjeOMZNsREPG70Co4XogpdLfwKnIxikHZoRBhVnoW72pX1H05Sjyr
	Bcbv4Un85MFtaxIJJbvyh7uPD9hCAY3KjAst52adZCmBYJVEwNLPepjTnheUAz10u75/s+ORSsRpt
	HOR1txAVLye93glWY+Ic9wD95zVyxC0ZNJBUkK4j+OhHRf0+B3suSzw4RCAH4npxBxPNNbBNdp7eC
	VRUaP12hAdWfLbmitqeGsPVXVBynalZOtJVoLJx1gU6R/Om5nV3vNYRopLjIzz1rXLtBywbWClAmQ
	ErzvKKRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkngA-0000000E2uD-0iXa;
	Wed, 19 Feb 2025 17:16:10 +0000
Received: from angie.orcam.me.uk ([78.133.224.34])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkng6-0000000E2qy-2Mtl;
	Wed, 19 Feb 2025 17:16:08 +0000
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 247399200B3; Wed, 19 Feb 2025 18:16:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 1E09592009E;
	Wed, 19 Feb 2025 17:16:05 +0000 (GMT)
Date: Wed, 19 Feb 2025 17:16:05 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: "Dmitry V. Levin" <ldv@strace.io>
cc: Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, 
    Alexey Gladkov <legion@kernel.org>, 
    Eugene Syromyatnikov <evgsyr@gmail.com>, 
    Charlie Jenkins <charlie@rivosinc.com>, Helge Deller <deller@gmx.de>, 
    Mike Frysinger <vapier@gentoo.org>, Renzo Davoli <renzo@cs.unibo.it>, 
    Davide Berardi <berardi.dav@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
    Russell King <linux@armlinux.org.uk>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
    WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
    Michal Simek <monstr@monstr.eu>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
    Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
    Stafford Horne <shorne@gmail.com>, 
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Christophe Leroy <christophe.leroy@csgroup.eu>, 
    Naveen N Rao <naveen@kernel.org>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, 
    Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    "David S. Miller" <davem@davemloft.net>, 
    Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
    Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
    Johannes Berg <johannes@sipsolutions.net>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
    Arnd Bergmann <arnd@arndb.de>, strace-devel@lists.strace.io, 
    linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, 
    loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
    linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
    linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
    linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
    linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
    linux-um@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v6 3/6] syscall.h: introduce syscall_set_nr()
In-Reply-To: <20250217091034.GD18175@strace.io>
Message-ID: <alpine.DEB.2.21.2502191658530.65342@angie.orcam.me.uk>
References: <20250217091034.GD18175@strace.io>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_091606_762620_B001389E 
X-CRM114-Status: GOOD (  15.18  )
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

On Mon, 17 Feb 2025, Dmitry V. Levin wrote:

> diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
> index ea050b23d428..b956b015641c 100644
> --- a/arch/mips/include/asm/syscall.h
> +++ b/arch/mips/include/asm/syscall.h
> @@ -41,6 +41,20 @@ static inline long syscall_get_nr(struct task_struct *task,
>  	return task_thread_info(task)->syscall;
>  }
>  
> +static inline void syscall_set_nr(struct task_struct *task,
> +				  struct pt_regs *regs,
> +				  int nr)
> +{
> +	/*
> +	 * New syscall number has to be assigned to regs[2] because
> +	 * syscall_trace_entry() loads it from there unconditionally.

 That label is called `trace_a_syscall' in arch/mips/kernel/scall64-o32.S 
instead.  To bring some order and avoid an inaccuracy here should the odd 
one be matched to the other three?

> +	 *
> +	 * Consequently, if the syscall was indirect and nr != __NR_syscall,
> +	 * then after this assignment the syscall will cease to be indirect.
> +	 */
> +	task_thread_info(task)->syscall = regs->regs[2] = nr;
> +}
> +
>  static inline void mips_syscall_update_nr(struct task_struct *task,
>  					  struct pt_regs *regs)
>  {

 Otherwise:

Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>

for this part, thank you!

  Maciej

