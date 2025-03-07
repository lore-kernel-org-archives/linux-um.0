Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C30C282D0
	for <linux-um@archiver.kernel.org>; Fri,  7 Mar 2025 07:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2kI/DyRmOVkLlEuN4OSBLzhuWKZ7ObXXJXTyokhHSok=; b=SfgRrCxW4QKSuSBnITsHClztx+
	qquzTWCKeR4i5dcwIQqPq+1+olpKiYnGMsFzJHhEH9GdqPnpxYQbOB/Qc8aroQFV4d1npb4B/34nS
	1dpw0n2p8vgO+EWUrRcKlyfvKRfkSQyGhyf1EsR+XHKTJn9qdycw/c+z1JAT7Hyc4UiWUzrudiUaV
	pRy7Pd2rc+EhKyoXklBwY2kPC6HZMaYEFFtPm29B5JcNQlLV76hwD4Ip7kKbWi+mD4aV0fyGWiT9/
	/qCdQEGp/3bZSfH5iCI+a8uQGhmTpFu43rdlbMmfPHeRT6AYrG3EpORLbX2rHMBYxVPPH17YA/gEj
	sUhXAfwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqRlT-0000000DOHZ-2wVM;
	Fri, 07 Mar 2025 07:04:59 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqRlR-0000000DOGr-0Bzd
	for linux-um@lists.infradead.org;
	Fri, 07 Mar 2025 07:04:58 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-22398e09e39so26706685ad.3
        for <linux-um@lists.infradead.org>; Thu, 06 Mar 2025 23:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741331095; x=1741935895; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2kI/DyRmOVkLlEuN4OSBLzhuWKZ7ObXXJXTyokhHSok=;
        b=K+8C1JwqqWT4WT2m5WuIdhFyQamIepsA623RDdBCz8OOAhz8eIqip+nJy+hk3z2Ene
         0wZTU95nkJ+1BvoNlIqx44SHMwf8HhN6u8GYqjdzWUvbambAI+Ved9WJkVxYv//xErXR
         5jjMZm1jMX3CzvyBZRR1uwi+5QDyKBTNSAP4dAMyi20d4ivRHsC2GOICIoN39XvLOV9O
         9whz52sg3QP4Tydu82LILbi1PAFV8d1r5szCE+gb0x+HQ/5Pp9d3868GHr9J8IY6OXQW
         HyFUQYaZ7b+0gPL/rplK0a1YrKqQV7Gm56Z9tFvTBYXRuxCc6P/eD6qX/qYhcMVkIytK
         9/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741331095; x=1741935895;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kI/DyRmOVkLlEuN4OSBLzhuWKZ7ObXXJXTyokhHSok=;
        b=Gf8JUNCYBHuX6k6gWpBZ1yuzWoozwczeznB23GpRVhVDLKguaRvQDBQfTyUmfTYByD
         yxGrfoJ1SZyZJdwCVNow4rXTJkNDEXGAse6TVOcTTV6OAjfA9Rcwea/2dZT8WfKWucEw
         wfJc/In2DbMIMLcuwhdel0EAk+cZ5aDsKL6O3OKSJ4gbuyLYe8r/oEXf0h1ibTrrhwVB
         OVKPOxGPx77WQ134LbbG+a4+E+RUCTfDM6trtHnfTvtiZ+T3m+s7qGkvVsSgZBq4mmAg
         nHCmax0S1ZP/TAa6BRZ+XWuBP7YJAZsr0PGozblduxPH/+SPd66CMPHKQhuVxmrF3oEV
         j4jw==
X-Gm-Message-State: AOJu0Yy4htux/fXI98P0hbWtlxB+1KJmiud3HLxr15+9nu9cj5WvpOyD
	+JoHWiaUDEstHzeHvgouL6bCV1vUlEHY/K8u1Xd1TRtIj1iTW2I0
X-Gm-Gg: ASbGnctM954JAolHzjHgYlADs3iL+lOgJDnF2UfGLwLR4xVCK9aQ6viyQjiDs3QOmCa
	TCFGRlyZn68QtpA+0BxXyS5FTPPJKCw0zu85SXq86YZezJIyP86h/eJGVqzMARXbH/YvkeiX63+
	zwrn0nmwux8L5hwfhhV1kYBZ7PJcfiL2813tTItBXgxZXakwbIkpjm46NMEWyKc/uOT5t5DPnqs
	2T//7fKOq93r3nH+JG/vGrsar2aEpXwZ2Mg/nYQSuZf1l5PEGPVM0/ELxmK4VYhddUd4HvPRXSx
	xh+bHWj9TUB0QWJZ4ZQXXNuEIRH4GPme8M7H+Aa9yaVE4RIGUgxA3N4IuYuhFjILSO/uUxCBlaX
	2Rn3T6q//Fz9CigrT/0ydj8ibeIxH1ck=
X-Google-Smtp-Source: AGHT+IGK7wMfK4ZHoiyiTHocbzlZwS6qQucPGPGu5nWKnpuZTjzQGjmf3lJJKNPmk1cuZp5Cz7YKoA==
X-Received: by 2002:a17:903:2445:b0:21f:988d:5758 with SMTP id d9443c01a7336-22428c075ccmr42861105ad.35.1741331095326;
        Thu, 06 Mar 2025 23:04:55 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91bdesm23307435ad.176.2025.03.06.23.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 23:04:53 -0800 (PST)
Date: Fri, 07 Mar 2025 16:04:50 +0900
Message-ID: <m2wmd1z5gt.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	johannes@sipsolutions.net,
	benjamin.berg@intel.com
Subject: Re: [PATCH 7/9] um: Implement kernel side of SECCOMP based process handling
In-Reply-To: <20250224181827.647129-8-benjamin@sipsolutions.net>
References: <20250224181827.647129-1-benjamin@sipsolutions.net>
	<20250224181827.647129-8-benjamin@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_230457_086132_63B8C040 
X-CRM114-Status: GOOD (  33.24  )
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

thanks for the update; was waiting for this.

On Tue, 25 Feb 2025 03:18:25 +0900,
Benjamin Berg wrote:
> 
> This adds the kernel side of the seccomp based process handling.
> 
> Co-authored-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
(snip)
> diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
> index f8ee5d612c47..0abc509e3f4c 100644
> --- a/arch/um/kernel/skas/mmu.c
> +++ b/arch/um/kernel/skas/mmu.c
> @@ -38,14 +38,11 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
>  	scoped_guard(spinlock_irqsave, &mm_list_lock) {
>  		/* Insert into list, used for lookups when the child dies */
>  		list_add(&mm->context.list, &mm_list);
> -

maybe this is not needed.

>  	}
>  
> -	new_id->pid = start_userspace(stack);
> -	if (new_id->pid < 0) {
> -		ret = new_id->pid;
> +	ret = start_userspace(new_id);
> +	if (ret < 0)
>  		goto out_free;
> -	}
>  
>  	/* Ensure the new MM is clean and nothing unwanted is mapped */
>  	unmap(new_id, 0, STUB_START);
> diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
> index 23c99b285e82..f40f2332b676 100644
> --- a/arch/um/kernel/skas/stub_exe.c
> +++ b/arch/um/kernel/skas/stub_exe.c
> @@ -3,6 +3,9 @@
>  #include <asm/unistd.h>
>  #include <sysdep/stub.h>
>  #include <stub-data.h>
> +#include <linux/filter.h>
> +#include <linux/seccomp.h>
> +#include <generated/asm-offsets.h>
>  
>  void _start(void);
>  
> @@ -25,8 +28,6 @@ noinline static void real_init(void)
>  	} sa = {
>  		/* Need to set SA_RESTORER (but the handler never returns) */
>  		.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO | 0x04000000,
> -		/* no need to mask any signals */
> -		.sa_mask = 0,
>  	};
>  
>  	/* set a nice name */
> @@ -35,6 +36,9 @@ noinline static void real_init(void)
>  	/* Make sure this process dies if the kernel dies */
>  	stub_syscall2(__NR_prctl, PR_SET_PDEATHSIG, SIGKILL);
>  
> +	/* Needed in SECCOMP mode (and safe to do anyway) */
> +	stub_syscall5(__NR_prctl, PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> +
>  	/* read information from STDIN and close it */
>  	res = stub_syscall3(__NR_read, 0,
>  			    (unsigned long)&init_data, sizeof(init_data));
> @@ -63,18 +67,133 @@ noinline static void real_init(void)
>  	stack.ss_sp = (void *)init_data.stub_start + UM_KERN_PAGE_SIZE;
>  	stub_syscall2(__NR_sigaltstack, (unsigned long)&stack, 0);
>  
> -	/* register SIGSEGV handler */
> -	sa.sa_handler_ = (void *) init_data.segv_handler;
> -	res = stub_syscall4(__NR_rt_sigaction, SIGSEGV, (unsigned long)&sa, 0,
> -			    sizeof(sa.sa_mask));
> -	if (res != 0)
> -		stub_syscall1(__NR_exit, 13);
> +	/* register signal handlers */
> +	sa.sa_handler_ = (void *) init_data.signal_handler;
> +	sa.sa_restorer = (void *) init_data.signal_restorer;
> +	if (!init_data.seccomp) {
> +		/* In ptrace mode, the SIGSEGV handler never returns */
> +		sa.sa_mask = 0;
> +
> +		res = stub_syscall4(__NR_rt_sigaction, SIGSEGV,
> +				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
> +		if (res != 0)
> +			stub_syscall1(__NR_exit, 13);
> +	} else {
> +		/* SECCOMP mode uses rt_sigreturn, need to mask all signals */
> +		sa.sa_mask = ~0ULL;
> +
> +		res = stub_syscall4(__NR_rt_sigaction, SIGSEGV,
> +				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
> +		if (res != 0)
> +			stub_syscall1(__NR_exit, 14);
> +
> +		res = stub_syscall4(__NR_rt_sigaction, SIGSYS,
> +				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
> +		if (res != 0)
> +			stub_syscall1(__NR_exit, 15);
> +
> +		res = stub_syscall4(__NR_rt_sigaction, SIGALRM,
> +				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
> +		if (res != 0)
> +			stub_syscall1(__NR_exit, 16);
> +
> +		res = stub_syscall4(__NR_rt_sigaction, SIGTRAP,
> +				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
> +		if (res != 0)
> +			stub_syscall1(__NR_exit, 17);
> +
> +		res = stub_syscall4(__NR_rt_sigaction, SIGILL,
> +				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
> +		if (res != 0)
> +			stub_syscall1(__NR_exit, 18);
> +
> +		res = stub_syscall4(__NR_rt_sigaction, SIGFPE,
> +				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
> +		if (res != 0)
> +			stub_syscall1(__NR_exit, 19);
> +	}
> +
> +	/*
> +	 * If in seccomp mode, install the SECCOMP filter and trigger a syscall.
> +	 * Otherwise set PTRACE_TRACEME and do a SIGSTOP.
> +	 */
> +	if (init_data.seccomp) {
> +		struct sock_filter filter[] = {
> +#if __BITS_PER_LONG > 32
> +			/* [0] Load upper 32bit of instruction pointer from seccomp_data */
> +			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
> +				 (offsetof(struct seccomp_data, instruction_pointer) + 4)),
> +
> +			/* [1] Jump forward 3 instructions if the upper address is not identical */
> +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, (init_data.stub_start) >> 32, 0, 3),
> +#endif
> +			/* [2] Load lower 32bit of instruction pointer from seccomp_data */
> +			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
> +				 (offsetof(struct seccomp_data, instruction_pointer))),
> +
> +			/* [3] Mask out lower bits */
> +			BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xfffff000),
> +
> +			/* [4] Jump to [6] if the lower bits are not on the expected page */
> +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, (init_data.stub_start) & 0xfffff000, 1, 0),
> +
> +			/* [5] Trap call, allow */
> +			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_TRAP),
> +
> +			/* [6,7] Check architecture */
> +			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
> +				 offsetof(struct seccomp_data, arch)),
> +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,
> +				 UM_SECCOMP_ARCH_NATIVE, 1, 0),
> +
> +			/* [8] Kill (for architecture check) */
> +			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
> +
> +			/* [9] Load syscall number */
> +			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
> +				 offsetof(struct seccomp_data, nr)),
> +
> +			/* [10-14] Check against permitted syscalls */
> +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_futex,
> +				 5, 0),
> +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, STUB_MMAP_NR,
> +				 4, 0),
> +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_munmap,
> +				 3, 0),
> +#ifdef __i386__
> +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_set_thread_area,
> +				 2, 0),
> +#else
> +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_arch_prctl,
> +				 2, 0),
> +#endif
> +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_rt_sigreturn,
> +				 1, 0),

I was trying to understand what you mean 'permitted syscalls' here.
Is this a list of syscall used by UML itself, or something else ?

and should the list be maintained/updated if UML expands the permitted
syscalls ?

> +			/* [15] Not one of the permitted syscalls */
> +			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
> +
> +			/* [16] Permitted call for the stub */
> +			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
> +		};
> +		struct sock_fprog prog = {
> +			.len = sizeof(filter) / sizeof(filter[0]),
> +			.filter = filter,
> +		};
> +
> +		if (stub_syscall3(__NR_seccomp, SECCOMP_SET_MODE_FILTER,
> +				  SECCOMP_FILTER_FLAG_TSYNC,
> +				  (unsigned long)&prog) != 0)
> +			stub_syscall1(__NR_exit, 20);
>  
> -	stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
> +		/* Fall through, the exit syscall will cause SIGSYS */
> +	} else {
> +		stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
>  
> -	stub_syscall2(__NR_kill, stub_syscall0(__NR_getpid), SIGSTOP);
> +		stub_syscall2(__NR_kill, stub_syscall0(__NR_getpid), SIGSTOP);
> +	}
>  
> -	stub_syscall1(__NR_exit, 14);
> +	stub_syscall1(__NR_exit, 30);
>  
>  	__builtin_unreachable();
>  }

I was thinking that if I can clean up (or share) the seccomp filter
code of nommu UML with this, but it is not likely as the memory layout
is different.  I would think that the detection part might be useful
as well for nommu.

-- Hajime

