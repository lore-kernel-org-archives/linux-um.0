Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37713C44501
	for <linux-um@archiver.kernel.org>; Wed,  8 Jul 2026 15:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XJPmMJ/10WNM7Sp5MUPTojvNQKhdTzesC5opB6cbbnk=; b=subnOnNRi5jqUlfWLr/XmZgnwp
	UFuGahbbGPF0494lNY/AGmmgE6PL5mObIPXcCuiawvealBr4CcXRpvVY4ULks4QOgWbiP2Ar27OWE
	nhQ5AFYfgfrRbeDgxoJ88NNrEV2GnRJAZVjsFsXeFVdZD7PQlCZm5ODTXDreVJmGNe/KURiQatuLS
	gEX/adyD+GaoOFRIPUW9fiDbuNQAZVWvwsPQSwRhKot9hZc4TcsAhb23W9Jva3IPoj6MzKHuC67tp
	9JaoFmY8Zz37djKOeV3xXxlX8ld5R1dBVqiHCW0GZzmM0C49oVB0M+M4XdLuDUdRmgYejuX219Fb3
	LA77Y2yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whUZu-0000000HWwP-1AQQ;
	Wed, 08 Jul 2026 15:52:50 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whUZr-0000000HWuk-1ICj
	for linux-um@lists.infradead.org;
	Wed, 08 Jul 2026 15:52:48 +0000
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C55F775A94;
	Wed,  8 Jul 2026 15:52:43 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Date: Wed, 8 Jul 2026 17:52:42 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [patch 13/18] entry: Make trace_syscall_enter() return type bool
Message-ID: <ak5ySpil83TNWxeq@kunlun.suse.cz>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.338083894@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190254.338083894@kernel.org>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: C55F775A94
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-2.00 / 50.00];
	REPLY(-4.00)[];
	RDNS_NONE(2.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLs1yuyu6ywojxyk8y3ncu5g39)]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_085247_504057_A17510D2 
X-CRM114-Status: GOOD (  27.71  )
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

Hello,

On Tue, Jul 07, 2026 at 09:06:48PM +0200, Thomas Gleixner wrote:
> In preparation of converting the return value of
> syscall_enter_from_user_mode[_work]() bool, rework trace_syscall_enter() to
> 
>  - update the syscall number via a pointer argument
> 
>  - Return True if the syscall number is != -1, False otherwise

This does not achieve the goal of the initial RFC: To detangle the
return value of syscall_enter_from_user_mode from the syscall number.

This still conflates them, making it impossible to tell if the syscall
was rejected or syscall number was -1 to start with. Now also obfuscated
by performing the check deeper inside the common code.

> That aligns with ptrace_report_syscall_permit_enter() and
> seccomp_permit_syscall().
> 
> The only difference is that this also returns False, when the syscall
> number was already -1 to begin with, but there is not much which can be
> done about that. As the architecture has to preset the return value to
> -ENOSYS anyway, that results in the correct return value for such an
> invalid syscall.

That's not possible to do for architectures where the syscall number and
the syscall return value are in the same register.

You suggested that it is possible to not write the return value into an
actual register but use an additional field for that, and have the exit
code write the register.

However, that's not what is documented, nor what is currently done.

While this is an improvement in some respects the goal to have clear and
intelligible API around the generic entry is not acheived.

Thanks

Michal

> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  include/linux/entry-common.h  |    8 +++++---
>  kernel/entry/syscall-common.c |    7 ++++---
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -58,7 +58,7 @@ static __always_inline bool arch_ptrace_
>  #endif
>  
>  bool syscall_user_dispatch(struct pt_regs *regs);
> -long trace_syscall_enter(struct pt_regs *regs, long syscall);
> +bool trace_syscall_enter(struct pt_regs *regs, long *syscall);
>  void trace_syscall_exit(struct pt_regs *regs, long ret);
>  
>  static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
> @@ -108,8 +108,10 @@ static __always_inline long syscall_trac
>  	/* Either of the above might have changed the syscall number */
>  	syscall = syscall_get_nr(current, regs);
>  
> -	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
> -		syscall = trace_syscall_enter(regs, syscall);
> +	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
> +		if (!trace_syscall_enter(regs, &syscall))
> +			return -1L;
> +	}
>  
>  	syscall_enter_audit(regs, syscall);
>  
> --- a/kernel/entry/syscall-common.c
> +++ b/kernel/entry/syscall-common.c
> @@ -7,14 +7,15 @@
>  
>  /* Out of line to prevent tracepoint code duplication */
>  
> -long trace_syscall_enter(struct pt_regs *regs, long syscall)
> +bool trace_syscall_enter(struct pt_regs *regs, long *syscall)
>  {
> -	trace_sys_enter(regs, syscall);
> +	trace_sys_enter(regs, *syscall);
>  	/*
>  	 * Probes or BPF hooks in the tracepoint may have changed the
>  	 * system call number. Reread it.
>  	 */
> -	return syscall_get_nr(current, regs);
> +	*syscall = syscall_get_nr(current, regs);
> +	return *syscall != -1L;
>  }
>  
>  void trace_syscall_exit(struct pt_regs *regs, long ret)
> 

