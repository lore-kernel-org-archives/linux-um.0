Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59575C44507
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 20:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4V4fuwVKw9a+buqSTfOSwTO6Zlt+2k8vx+/ObUQlSos=; b=HQ5Qh4GW0ZNpagHU2JuFi2w/fW
	Tu79X8S4X34D09e27blz/YLnNmB1jAoAdwjGto/7oTzwZPJwKiJj4nE+NipWIi+dSDvmoOdeBe+fJ
	yXB/EElI74Zvey4uUReyez3p+bRFUcRMnO91RxYp2YQJAI1B7pHzShsxOZ1xj1pE+KjD/lSG6pTPX
	ZoZgYebFb+T6DP7m+h2sS658TePOunx4eWu/CtFBOgyIemdoXd2hiz1FvozZSzlz3p69CuySIGbop
	qLiZytW3VdgD96MllJhqvZxJnLh2aaHg23a+ZRl4SuA5RsJODpwPUaIxszctPP5wU0byi0t/P1T3g
	DSENE1bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whv9s-00000003YY6-1moy;
	Thu, 09 Jul 2026 20:15:44 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whv9n-00000003YWN-3q28
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 20:15:42 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-ca913a601fbso174564a12.3
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783628139; x=1784232939; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4V4fuwVKw9a+buqSTfOSwTO6Zlt+2k8vx+/ObUQlSos=;
        b=CNkoS/doRzyGAaI+c0xQog+i9DspD956cADpCa6oZCebu6It/3LyyIovG/1h2NOwoF
         olmSyXsPgb8L4YYLAGlDxzE3X96orgP0R7v0iquRqXSN9wSv+759SiQ3ExMz1WUwcJgL
         RJctJvrA7807CxlvYL2hG9gFCKy4YZXPCfNn1tpR/2ThzDFd1KxsgTvdxkHTDh2rW/hg
         aBUtCf6fcuoN3WdJ6qwNDlus5PAIY7uPdaoqjemntngvgUzcfXliRGBeKsIRb260xc5d
         qoohxxTz3jhlWVeRyVxQhBFYGpatrn8yMhNOibJ7D0LeRQrX2fmNMloiQdBIztQLFuTY
         825Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783628139; x=1784232939;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4V4fuwVKw9a+buqSTfOSwTO6Zlt+2k8vx+/ObUQlSos=;
        b=cO018+n7Ack0Xf3bURzpdpcxLHHKH6mMtmFkcJZISlpxBHdvaua+pr9BneBib6JyT+
         Vip9kyqGenMGQA4IuQ1sgaqlVIHIN2156MuuskOq3IvIEB0kRaFRaEpYITmkXTEgJrnM
         aettC/DCAOoAAwaQdxY/7mci7+f5pNd35FVFuT7EoLZWUSSBi86eAQPfjLZcOvRaJb8v
         SVUAJfl4tM/a37y8OF66R8CNZmy3VVhINmriUevm27KL4zU7i1Y1VTr4jOIZP637MDXj
         fvPbQ/qU7ziwP0EcdB7TSMvWRbSjh2Yty7p5+trZzjuC56aSyRoVLZxdFLOz6cwkUPNM
         vafQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrhO0BcpQzcBaRLypGDfVB5mat4mpe6T2eGdioFACc6gu3UwmiDRO+fCPFk5ShZWE9C8DajmSZrg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxcqV8WMoHsk9+oUv7qnd/gOFToU/3oxhA2LxBqB3AqZwz+l5yv
	6SLGRw1rb+oYFYtYZHrCxZB3lePHRSfbTpgfEC0059IfqhSHTytTMMz0
X-Gm-Gg: AfdE7clhzmF7QVbVzt4PnKFwdMB6pjIG27aRnLrUlMaYCb7w4wC6ykXqzeDqFJOYgC/
	HqesPHmMyKqft4FXOc7hCYGxhaTU9Fa8DqxqZ8sEtLSV7JmaANl6aj71NUdTQp/um5e+ESw9Luz
	jlnFh69+pZ5JnudlMZ+UswOLK4Hedwt7Vx3XqXbP48nup2v4tTK6ZcIJ6xbjKbgd5CcbnHS4+72
	KRsI4Hk6/0TWngtFtDzASD6Z4kryHJ1xit91TRq5ys5zJIh+lSWh6NtP2ClNUriKzPgyNuQfBnA
	BEBPjUdy3hVHWHQOPnQUMFenRpjlgKvFiOPVZkP+aW4HYp+2RlSf6LzPEneTvNGDyhEm1TVkWpg
	TlUmTB/EC+F98c78YPrIj4GKgtT6oujpsGp7bMZnObvbIlY27ufesm5com1ca3JtXMyoWhHrn5L
	xr4hg7bNYzAZTqEAb6rQvAI964Jo+l4+/G/NL0VVWqHuiD2Z25AFz4HcNf5CrcSgVrCS9VFzg=
X-Received: by 2002:a05:6a21:32a2:b0:398:8870:b58f with SMTP id adf61e73a8af0-3c0bcbe77a5mr11679805637.14.1783628138627;
        Thu, 09 Jul 2026 13:15:38 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3120c8e41fcsm2908315eec.15.2026.07.09.13.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:15:38 -0700 (PDT)
Date: Fri, 10 Jul 2026 01:45:19 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry
 handling
Message-ID: <ak_7lawD_OujooyZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707181957.433213175@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_131539_969520_87E4B01E 
X-CRM114-Status: GOOD (  41.38  )
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

On Tue, Jul 07, 2026 at 09:05:53PM +0200, Thomas Gleixner wrote:
> Sorry for the long CC list, but this is a treewide change.
> 
> Michal recently posted a RFC patch to separate the potential syscall number
> modifications in syscall_enter_user_mode_work() from the information
> whether the syscall should be processed and the return value modified:
> 
>   https://lore.kernel.org/lkml/CE1qW@kunlun.suse.cz
> 
> The existing logic is:
> 
> arch_syscall()
> 	regs->result = -ENOSYS;
> 
> 	syscallnr = syscall_enter_from_user_mode(regs, syscall);
> 
> 	if (syscallnr != -1L)
> 		regs->result = invoke_syscall(regs, syscall;
> 
> syscall_enter_from_user_mode() invokes ptrace, seccomp and
> tracing/BPF/Probes. All of them can modify the syscall number.
> 
> ptrace and seccomp explicitly set the syscall number to -1L to indicate
> that the syscall invocation needs to be skipped and the result has not to
> be modified as it might have been modified by ptrace or seccomp. The
> tracer/BPF/Probes mechanism can modify the syscall number as well and
> relies implicitly on the -1L logic.
> 
> This can obviously not be differentiated from a syscall invocation where
> userspace provided -1 as syscall number.
> 
> The general agreement of the discussion was that the current mechanism,
> while functionally correct is non-intuitive and something like Michals
> proposal would make that code clearer and easier to handle on the
> architecture side:
> 
> arch_syscall()
> 	regs->result = -ENOSYS;
> 
> 	if (syscall_enter_from_user_mode(regs, &syscall)) 
> 		regs->result = invoke_syscall(regs, syscall;
> 
> That discussion made me look deeper into the related code and as usual
> there were a lot of other things to discover.
> 
>   1) Stack randomization
> 
>      add_random_kstack_offset() can only be invoked after
>      enter_from_user_mode() established proper state as it calls into
>      instrumentable code.
> 
>      PowerPC got that wrong and the other architectures either invoke it
>      after enter_from_user_mode() or after syscall_enter_from_user_mode().
> 
>      The latter is suboptimal as the randomization takes place after all
>      the user mode entry work. Aside of that add_random_kstack_offset()
>      uses get/put_cpu_var(), which makes it usable in preemptible code, but
>      when invoked in the interrupt disabled region that's pointless
>      overhead.
> 
>   2) As discussed in the above thread just changing the function signature
>      of syscall_enter_from_user_mode[_work]() so they take a pointer
>      argument for the syscall and then return 0 on success is not really
>      intuitive either. Aside of that this breaks the implicit assumption of
>      the tracer when setting the syscall number to -1.
> 
>   3) The x86 entry code has some historically accumulated oddities
> 
> The following series addresses this by:
> 
>   1) Providing new [syscall_]enter_from_user_mode() variants, which include
>      stack randomization and utilize a new add_random_kstack_offset_irqsoff()
>      variant, which avoids the get/put_cpu_var() overhead and converting all
>      usage sites over
> 
>   2) Picking up Jinjie's seccomp patch from:
> 
>      https://lore.kernel.org/lkml/20260629130616.642022-2-ruanjinjie@huawei.com
> 
>      and addressing the feedback (renaming the seccomp functions)
> 
>   3) Making the ptrace and tracer related functions return a boolean value
>      to indicate syscall permission
> 
>   4) Addressing the x86 oddities
> 
>   5) Converting the tree over to the new scheme
> 
> With that all architectures using the generic syscall entry code follow the
> same scheme, apply stack randomization at the correct and earliest possible
> place and skip syscall processing depending on the boolean return value of
> syscall_enter_from_user_mode[_work]().
> 
> There should be no functional changes, at least there are none intended.
> 
> The resulting text size for the syscall entry code on x8664 is slightly
> smaller than before these changes.
> 
> Testing syscall heavy workloads and micro benchmarks shows a small
> performance gain for the general rework, but the last patch, which changes
> the logic to be more understandable has no measurable impact in either
> direction.
> 
> The series applies on Linus tree and is also available from git:
> 
>         git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-rework-v1
> 
> Thanks,
> 
> 	tglx
> ---
>  Documentation/core-api/entry.rst      |   33 +++++---
>  arch/alpha/kernel/ptrace.c            |    4 -
>  arch/arc/kernel/ptrace.c              |    2 
>  arch/arm/kernel/ptrace.c              |    4 -
>  arch/arm64/kernel/ptrace.c            |    4 -
>  arch/csky/kernel/ptrace.c             |    4 -
>  arch/hexagon/kernel/traps.c           |    2 
>  arch/loongarch/kernel/syscall.c       |   17 +---
>  arch/m68k/kernel/ptrace.c             |    4 -
>  arch/microblaze/kernel/ptrace.c       |    2 
>  arch/mips/kernel/ptrace.c             |    4 -
>  arch/nios2/kernel/ptrace.c            |    2 
>  arch/openrisc/kernel/ptrace.c         |    2 
>  arch/parisc/kernel/ptrace.c           |   12 +--
>  arch/powerpc/kernel/syscall.c         |    5 -
>  arch/riscv/kernel/traps.c             |   14 +--
>  arch/s390/kernel/syscall.c            |   11 +-
>  arch/sh/kernel/ptrace_32.c            |    4 -
>  arch/sparc/kernel/ptrace_32.c         |    2 
>  arch/sparc/kernel/ptrace_64.c         |    2 
>  arch/um/kernel/ptrace.c               |    2 
>  arch/um/kernel/skas/syscall.c         |    2 
>  arch/x86/entry/syscall_32.c           |   70 +++++++------------
>  arch/x86/entry/syscall_64.c           |   61 ++++++----------
>  arch/x86/entry/vsyscall/vsyscall_64.c |   14 +--
>  arch/x86/include/asm/entry-common.h   |    1 
>  arch/x86/include/asm/syscall.h        |   10 --
>  arch/xtensa/kernel/ptrace.c           |    5 -
>  include/asm-generic/syscall.h         |    4 -
>  include/linux/entry-common.h          |  125 ++++++++++++++++++++--------------
>  include/linux/irq-entry-common.h      |    6 -
>  include/linux/ptrace.h                |   13 +--
>  include/linux/randomize_kstack.h      |   19 +++++
>  include/linux/seccomp.h               |   12 +--
>  kernel/entry/syscall-common.c         |    7 +
>  kernel/seccomp.c                      |   35 ++++-----
>  36 files changed, 264 insertions(+), 256 deletions(-)
> 
> 
> 
> _______________________________________________
> linux-snps-arc mailing list
> linux-snps-arc@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-snps-arc

Boot tested this on P11 LPAR and P9 powernv system.
Tested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

