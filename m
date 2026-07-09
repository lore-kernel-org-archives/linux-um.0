Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37341C44506
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 19:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4WLiLUcdHKcbdohnfRqoOLrBkSnwixIbkHxH0bk89UM=; b=gm+dW4E5yQ0vUk4dBBMjfarHtg
	EeS3sR1AmO2TNeU8qRiPgWdu6/TYVXgByGaU2AKjZOaHlQ21SqtdVbNn1JjbrEaC1t8ZgluRry5/a
	ID2zNtgeHYaLVOHd671sUlrInUq3r2X46y/+fapVXhnt9ERHc1J7F71HMx7ZdsQkTdIn+fsqceFWF
	oFatEBXKb0MEfaPvXB5JKA4w+sF3ZnI6fSut7sXXOAKVjOoQUhKmUui3qBGjlU3dk4lwIt9ToIkZ0
	yr2AlVZwJ0f0TOB6tzbKgNo8IOU9Cbmx3/am++6ws+vGf7m28mMZcQ94a/3n0ZbHmnLFcqhAjKojP
	OQ8SwXqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whu8v-00000003QAr-0wbg;
	Thu, 09 Jul 2026 19:10:41 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whu8r-00000003Q95-1C2Q
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 19:10:40 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-381216921aaso325995a91.1
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 12:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783624236; x=1784229036; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4WLiLUcdHKcbdohnfRqoOLrBkSnwixIbkHxH0bk89UM=;
        b=nms3bijTlVnTCemDuvKLslLWrNMYx0dIq8V7vOXJkZdZ1hfQ0JNlb4gT2cHz/gGfts
         ZHhB+JBq00Sr9UgWL7bGowADhdRRT0E/U1RuMCYx1PM0WrWRcQGTwLsksm8PMNfXWVRm
         t2HdwjMu+X9SlXgEQvfOCXbTWaNMNcIl5DH1xKs6u3+NVX4w6WHRDgOyJG+txyo/7L3E
         6WiP9wCOBJAFJbQ7WJCGAIBNBNufUH7BO9n67f9d9brdzuvoEHG+e2NeIGTn85PMzkun
         F9k4saXdy0etjF6DeN5KY2YdcOs7UQXUKQaMCGC1mQvIvH4BQuThW77j4amgwXRj8x78
         ZS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783624236; x=1784229036;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4WLiLUcdHKcbdohnfRqoOLrBkSnwixIbkHxH0bk89UM=;
        b=Fvk2q0ZW8n6UwF/Nqcp7eG/73PCfLEXBbjl+mdLuC60gYPOLnUHZbS6qhhmP1oHwuo
         5Uk2iRuREIU4ZGw+I9Bbx9gi2n2gUg15/77OPs7Sn/YG+TRcJ7zfiuIsoXlRcvAMFxzI
         /mm1APzknzjv/+GGA5M/0Z1+C9OSICENgp7eIVSTkjs+6+uX/TR5jEC/LrAaowlDrm/t
         wNiD/8+TjXHvyMAYGlXqH8bTKtbxFzTK95WKvaVJnlBiJ3NIkYIqhM7zU5EUPEAQFTUB
         MLxPjlfU+fLTAHcg07yDn/ll+9Y/B5BItZ4WRX4CT/XIUSITR/Q9DdsGLha34pKSrTaz
         Fbow==
X-Forwarded-Encrypted: i=1; AHgh+RpjX5uRy9RcVWLHmJbWInctlL3I/iRD6hXPRvRX8SpD+yeP+1FbvUgiZfmmLitudumihOFasyXy9w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2ZCTCZNyF05DNYY0fe8N2P3737cjLxAh4ISRNcyU35jQDV8LA
	w7TgSuqbJGLPMoY5yITzL65Iw8HIAD70lmPI7CP3Qe1QtvLrJQyZdeSr
X-Gm-Gg: AfdE7cnEIiktL8OUtk1xDlRNXf9R9uz6QZhcdkMw6/WooUvnvDxrAqEOVuneaA2LzNs
	kH+R+yzViNdlc/tLeaSJjvXLzbHyj/HKZV91hw5HMr4domYSiLu2YpxEkWBblefgeAq6lAxapet
	0CpLrSBQPN7fd0TWevPFmJ7AlaO74Bsjt1ko0AvVzgqosApy5z/PU/yPw8tbreUrUbcjtgTqkRa
	QzGzl2TLuW6UauBJLHLv+wgJDtNpmP2cRUckvo9BFWKuY/Pdw1GpGPtJKTkBEfhLqkC1htv4F3x
	bcsu35/PuT0gH7ZCFAFzCGh70+JcPZ6TnRGU3BJqeNVU5O3DHSkHB/CS7mCtjq3ydD+i34cxujV
	jxUaJrUkMAGpQtvUgFZ8zk5tQt+FkN6UV7xhowMTvIiQ09pfKTe6RXTdse2TrEXOp6Tg1vcFJKd
	ou0vApFIUA6iEMmmBl6cHXJuc7tZKbYKeM1EOwsN2g7vILI1F4ihkSnL4N3yhI
X-Received: by 2002:a17:90a:c2d0:b0:381:dc88:7c09 with SMTP id 98e67ed59e1d1-38941ebc22dmr8070366a91.33.1783624236407;
        Thu, 09 Jul 2026 12:10:36 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a92eccsm30700023eec.23.2026.07.09.12.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:10:35 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:40:00 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Guo Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, 
	Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, 
	Brian Cain <bcain@kernel.org>, Michal Simek <monstr@monstr.eu>, 
	Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, linux-snps-arc@lists.infradead.org, 
	linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 11/18] seccomp, treewide: Rename and convert
 __secure_computing() to return boolean
Message-ID: <ak_x_ndzTNX2hfSG@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.230735780@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190254.230735780@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_121037_376170_DB66E44C 
X-CRM114-Status: GOOD (  33.40  )
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

On Tue, Jul 07, 2026 at 09:06:40PM +0200, Thomas Gleixner wrote:
> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> The return value of __secure_computing() currently uses 0 to indicate
> that a system call should be allowed, and -1 to indicate that it should
> be blocked/killed. This 0/-1 pattern is non-intuitive for a security
> check function and makes the control flow at the call sites less readable.
> 
> Furthermore, any potential future changes to these return values would
> require a high-risk, error-prone audit of all its users across different
> architectures.
> 
> Sanitize this logic by converting the return type of __secure_computing()
> to a proper boolean, where 'true' explicitly means 'allow' and 'false'
> means 'fail/deny'.
> 
> Update all the two dozen or so call sites across the tree to align with
> this new boolean semantic. No functional changes are intended, as the
> callers still return -1 to the lower-level assembly entry code upon
> seccomp denial.
> 
> Rename the function to __seccomp_permit_syscall() so that the purpose is
> entirely clear.
> 
> [ tglx: Rename the function ]
> 
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> ---
>  arch/alpha/kernel/ptrace.c            |    2 -
>  arch/arm/kernel/ptrace.c              |    2 -
>  arch/arm64/kernel/ptrace.c            |    2 -
>  arch/csky/kernel/ptrace.c             |    2 -
>  arch/m68k/kernel/ptrace.c             |    2 -
>  arch/mips/kernel/ptrace.c             |    2 -
>  arch/parisc/kernel/ptrace.c           |    2 -
>  arch/sh/kernel/ptrace_32.c            |    2 -
>  arch/um/kernel/skas/syscall.c         |    2 -
>  arch/x86/entry/vsyscall/vsyscall_64.c |   14 ++++++-------
>  arch/xtensa/kernel/ptrace.c           |    3 --
>  include/linux/entry-common.h          |    9 +++-----
>  include/linux/seccomp.h               |   12 +++++------
>  kernel/seccomp.c                      |   35 +++++++++++++++++-----------------
>  14 files changed, 45 insertions(+), 46 deletions(-)
> --- a/arch/alpha/kernel/ptrace.c
> +++ b/arch/alpha/kernel/ptrace.c
> @@ -387,7 +387,7 @@ asmlinkage unsigned long syscall_trace_e
>  	 * If this fails, seccomp may already have set up the return value
>  	 * (e.g. SECCOMP_RET_ERRNO / TRACE).
>  	 */
> -	if (secure_computing() == -1) {
> +	if (!seccomp_permit_syscall()) {
>  		if (regs->r19 == 0 && regs->r0 == (unsigned long)-1)
>  			syscall_set_return_value(current, regs, -ENOSYS, 0);
>  		syscall_set_nr(current, regs, -1);
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -855,7 +855,7 @@ asmlinkage int syscall_trace_enter(struc
>  
>  	/* Do seccomp after ptrace; syscall may have changed. */
>  #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
> -	if (secure_computing() == -1)
> +	if (!seccomp_permit_syscall())
>  		return -1;
>  #else
>  	/* XXX: remove this once OABI gets fixed */
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -2420,7 +2420,7 @@ int syscall_trace_enter(struct pt_regs *
>  	}
>  
>  	/* Do the secure computing after ptrace; failures should be fast. */
> -	if (secure_computing() == -1)
> +	if (!seccomp_permit_syscall())
>  		return NO_SYSCALL;
>  
>  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> --- a/arch/csky/kernel/ptrace.c
> +++ b/arch/csky/kernel/ptrace.c
> @@ -323,7 +323,7 @@ asmlinkage int syscall_trace_enter(struc
>  		if (ptrace_report_syscall_entry(regs))
>  			return -1;
>  
> -	if (secure_computing() == -1)
> +	if (!seccomp_permit_syscall())
>  		return -1;
>  
>  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> --- a/arch/m68k/kernel/ptrace.c
> +++ b/arch/m68k/kernel/ptrace.c
> @@ -281,7 +281,7 @@ asmlinkage int syscall_trace_enter(void)
>  	if (test_thread_flag(TIF_SYSCALL_TRACE))
>  		ret = ptrace_report_syscall_entry(task_pt_regs(current));
>  
> -	if (secure_computing() == -1)
> +	if (!seccomp_permit_syscall())
>  		return -1;
>  
>  	return ret;
> --- a/arch/mips/kernel/ptrace.c
> +++ b/arch/mips/kernel/ptrace.c
> @@ -1328,7 +1328,7 @@ asmlinkage long syscall_trace_enter(stru
>  			return -1;
>  	}
>  
> -	if (secure_computing())
> +	if (!seccomp_permit_syscall())
>  		return -1;
>  
>  	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
> --- a/arch/parisc/kernel/ptrace.c
> +++ b/arch/parisc/kernel/ptrace.c
> @@ -351,7 +351,7 @@ long do_syscall_trace_enter(struct pt_re
>  	}
>  
>  	/* Do the secure computing check after ptrace. */
> -	if (secure_computing() == -1)
> +	if (!seccomp_permit_syscall())
>  		return -1;
>  
>  #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
> --- a/arch/sh/kernel/ptrace_32.c
> +++ b/arch/sh/kernel/ptrace_32.c
> @@ -460,7 +460,7 @@ asmlinkage long do_syscall_trace_enter(s
>  		return -1;
>  	}
>  
> -	if (secure_computing() == -1)
> +	if (!seccomp_permit_syscall())
>  		return -1;
>  
>  	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
> --- a/arch/um/kernel/skas/syscall.c
> +++ b/arch/um/kernel/skas/syscall.c
> @@ -27,7 +27,7 @@ void handle_syscall(struct uml_pt_regs *
>  		goto out;
>  
>  	/* Do the seccomp check after ptrace; failures should be fast. */
> -	if (secure_computing() == -1)
> +	if (!seccomp_permit_syscall())
>  		goto out;
>  
>  	syscall = UPT_SYSCALL_NR(r);
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -118,10 +118,10 @@ static bool write_ok_or_segv(unsigned lo
>  
>  static bool __emulate_vsyscall(struct pt_regs *regs, unsigned long address)
>  {
> -	unsigned long caller;
> -	int vsyscall_nr, syscall_nr, tmp;
> +	unsigned long caller, orig_dx;
> +	int vsyscall_nr, syscall_nr;
> +	bool skip;
>  	long ret;
> -	unsigned long orig_dx;
>  
>  	/* Confirm that the fault happened in 64-bit user mode */
>  	if (!user_64bit_mode(regs))
> @@ -197,16 +197,16 @@ static bool __emulate_vsyscall(struct pt
>  	 */
>  	regs->orig_ax = syscall_nr;
>  	regs->ax = -ENOSYS;
> -	tmp = secure_computing();
> -	if ((!tmp && regs->orig_ax != syscall_nr) || regs->ip != address) {
> +	skip = !seccomp_permit_syscall();
> +	if ((!skip && regs->orig_ax != syscall_nr) || regs->ip != address) {
>  		warn_bad_vsyscall(KERN_DEBUG, regs,
>  				  "seccomp tried to change syscall nr or ip");
>  		force_exit_sig(SIGSYS);
>  		return true;
>  	}
>  	regs->orig_ax = -1;
> -	if (tmp)
> -		goto do_ret;  /* skip requested */
> +	if (skip)
> +		goto do_ret;
>  
>  	/*
>  	 * With a real vsyscall, page faults cause SIGSEGV.
> --- a/arch/xtensa/kernel/ptrace.c
> +++ b/arch/xtensa/kernel/ptrace.c
> @@ -553,8 +553,7 @@ int do_syscall_trace_enter(struct pt_reg
>  		return 0;
>  	}
>  
> -	if (regs->syscall == NO_SYSCALL ||
> -	    secure_computing() == -1) {
> +	if (regs->syscall == NO_SYSCALL || !seccomp_permit_syscall()) {
>  		do_syscall_trace_leave(regs);
>  		return 0;
>  	}
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -102,9 +102,8 @@ static __always_inline long syscall_trac
>  
>  	/* Do seccomp after ptrace, to catch any tracer changes. */
>  	if (work & SYSCALL_WORK_SECCOMP) {
> -		ret = __secure_computing();
> -		if (ret == -1L)
> -			return ret;
> +		if (!__seccomp_permit_syscall())
> +			return -1L;
>  	}
>  
>  	/* Either of the above might have changed the syscall number */
> @@ -115,7 +114,7 @@ static __always_inline long syscall_trac
>  
>  	syscall_enter_audit(regs, syscall);
>  
> -	return ret ? : syscall;
> +	return syscall;
>  }
>  
>  /**
> @@ -138,7 +137,7 @@ static __always_inline long syscall_trac
>   * It handles the following work items:
>   *
>   *  1) syscall_work flag dependent invocations of
> - *     ptrace_report_syscall_entry(), __secure_computing(), trace_sys_enter()
> + *     ptrace_report_syscall_entry(), __seccomp_permit_syscall(), trace_sys_enter()
>   *  2) Invocation of audit_syscall_entry()
>   */
>  static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -22,14 +22,14 @@
>  #include <linux/atomic.h>
>  #include <asm/seccomp.h>
>  
> -extern int __secure_computing(void);
> +extern bool __seccomp_permit_syscall(void);
>  
>  #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
> -static inline int secure_computing(void)
> +static __always_inline bool seccomp_permit_syscall(void)
>  {
>  	if (unlikely(test_syscall_work(SECCOMP)))
> -		return  __secure_computing();
> -	return 0;
> +		return  __seccomp_permit_syscall();
> +	return true;
>  }
>  #else
>  extern void secure_computing_strict(int this_syscall);
> @@ -50,11 +50,11 @@ static inline int seccomp_mode(struct se
>  struct seccomp_data;
>  
>  #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
> -static inline int secure_computing(void) { return 0; }
> +static inline bool seccomp_permit_syscall(void) { return true; }
>  #else
>  static inline void secure_computing_strict(int this_syscall) { return; }
>  #endif
> -static inline int __secure_computing(void) { return 0; }
> +static inline bool __seccomp_permit_syscall(void) { return true; }
>  
>  static inline long prctl_get_seccomp(void)
>  {
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1100,12 +1100,13 @@ void secure_computing_strict(int this_sy
>  	else
>  		BUG();
>  }
> -int __secure_computing(void)
> +
> +bool __seccomp_permit_syscall(void)
>  {
>  	int this_syscall = syscall_get_nr(current, current_pt_regs());
>  
>  	secure_computing_strict(this_syscall);
> -	return 0;
> +	return true;
>  }
>  #else
>  
> @@ -1256,7 +1257,7 @@ static int seccomp_do_user_notification(
>  	return -1;
>  }
>  
> -static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
> +static bool __seccomp_filter(int this_syscall, const bool recheck_after_trace)
>  {
>  	u32 filter_ret, action;
>  	struct seccomp_data sd;
> @@ -1294,7 +1295,7 @@ static int __seccomp_filter(int this_sys
>  	case SECCOMP_RET_TRACE:
>  		/* We've been put in this state by the ptracer already. */
>  		if (recheck_after_trace)
> -			return 0;
> +			return true;
>  
>  		/* ENOSYS these calls if there is no tracer attached. */
>  		if (!ptrace_event_enabled(current, PTRACE_EVENT_SECCOMP)) {
> @@ -1330,19 +1331,19 @@ static int __seccomp_filter(int this_sys
>  		 * a skip would have already been reported.
>  		 */
>  		if (__seccomp_filter(this_syscall, true))
> -			return -1;
> +			return false;
>  
> -		return 0;
> +		return true;
>  
>  	case SECCOMP_RET_USER_NOTIF:
>  		if (seccomp_do_user_notification(this_syscall, match, &sd))
>  			goto skip;
>  
> -		return 0;
> +		return true;
>  
>  	case SECCOMP_RET_LOG:
>  		seccomp_log(this_syscall, 0, action, true);
> -		return 0;
> +		return true;
>  
>  	case SECCOMP_RET_ALLOW:
>  		/*
> @@ -1350,7 +1351,7 @@ static int __seccomp_filter(int this_sys
>  		 * this action since SECCOMP_RET_ALLOW is the starting
>  		 * state in seccomp_run_filters().
>  		 */
> -		return 0;
> +		return true;
>  
>  	case SECCOMP_RET_KILL_THREAD:
>  	case SECCOMP_RET_KILL_PROCESS:
> @@ -1367,46 +1368,46 @@ static int __seccomp_filter(int this_sys
>  		} else {
>  			do_exit(SIGSYS);
>  		}
> -		return -1; /* skip the syscall go directly to signal handling */
> +		return false; /* skip the syscall go directly to signal handling */
>  	}
>  
>  	unreachable();
>  
>  skip:
>  	seccomp_log(this_syscall, 0, action, match ? match->log : false);
> -	return -1;
> +	return false;
>  }
>  #else
> -static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
> +static bool __seccomp_filter(int this_syscall, const bool recheck_after_trace)
>  {
>  	BUG();
>  
> -	return -1;
> +	return false;
>  }
>  #endif
>  
> -int __secure_computing(void)
> +bool __seccomp_permit_syscall(void)
>  {
>  	int mode = current->seccomp.mode;
>  	int this_syscall;
>  
>  	if (IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) &&
>  	    unlikely(current->ptrace & PT_SUSPEND_SECCOMP))
> -		return 0;
> +		return true;
>  
>  	this_syscall = syscall_get_nr(current, current_pt_regs());
>  
>  	switch (mode) {
>  	case SECCOMP_MODE_STRICT:
>  		__secure_computing_strict(this_syscall);  /* may call do_exit */
> -		return 0;
> +		return true;
>  	case SECCOMP_MODE_FILTER:
>  		return __seccomp_filter(this_syscall, false);
>  	/* Surviving SECCOMP_RET_KILL_* must be proactively impossible. */
>  	case SECCOMP_MODE_DEAD:
>  		WARN_ON_ONCE(1);
>  		do_exit(SIGKILL);
> -		return -1;
> +		return false;
>  	default:
>  		BUG();
>  	}
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

