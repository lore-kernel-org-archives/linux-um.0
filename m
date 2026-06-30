Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9FBC43327
	for <linux-um@archiver.kernel.org>; Tue, 30 Jun 2026 15:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RdsRgNbVkI3Xb/bXMSfj+yw5lewzrynD2xqGGnGzV8Y=; b=ns3nzycz/OBF4OIEHm9gWggTyV
	RYqG4YhILlCXHqZe7qJsfuh5PLVCq0g5I4alQxdOndXPM+z6tiUEN7jCg6VgnXF4ysYvO4q4yeFh0
	VwpYiDaurr5oQ/gx2xE3OSW9u/2ykUX7oGItey8Kci5k7eNZ35/9LboGVGwP/XR2y9cxYS7sWg0Tv
	IiElfaPnvQSkGQgk3v0UWrla1VyEAmOmkwdvVfFvA1Rr21T6jhpr7Xw+TDhO+PDEVPCqR6kof5JTn
	gSG1/CUt63MtL8RThPkt3BNN8RiwGQAJqJdH19chwFCb20At7riWwnpqENdN5avckMfFmyYkoh0Zq
	6lbzCsGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weaRY-0000000HNZn-1w9L;
	Tue, 30 Jun 2026 15:32:12 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weaRW-0000000HNZC-0D0g;
	Tue, 30 Jun 2026 15:32:11 +0000
Date: Tue, 30 Jun 2026 17:32:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782833526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RdsRgNbVkI3Xb/bXMSfj+yw5lewzrynD2xqGGnGzV8Y=;
	b=qu/1s0nHQC6KFpDGuKrxXJLqBTdl1FoH/4yCYl34ohT2guoTuARwKQEULMNqdYWydigyrj
	UQsxj+D6QvmsMUbHcM7u3rM86IjWKPJT39xqCzzGIvsLgqe2Hz4HBOvbz7iysNXKPy5W/u
	R/GUuEzOAf1ZZdsDdNL4Jr6q/bCrdt9+3kstOwvKETmQg7hIqCfC8XESzPiKTthZJ9Oc09
	xpBcumA8KxG/PCdAqz4l1iGj82SI/tB9ALWL8NP8tofOtWsr179TrHBkKBYCmCED0scKGL
	24UnriDqIvgBJ16vM4xBQFbAgoL54zsV+WuM26JgtD+5w8qeomuxalv2Kqf/NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782833526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RdsRgNbVkI3Xb/bXMSfj+yw5lewzrynD2xqGGnGzV8Y=;
	b=vVSU3b5gGX9pyXfPgfu3YTbbfDnrmDCkQKRUwm+vxUCIXLFG0mbsTHQglZDx4c5OUPi7Tu
	n00gEBCaZoE4kFBg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: oleg@redhat.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	kees@kernel.org, guoren@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	geert@linux-m68k.org, tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, 
	glaubitz@physik.fu-berlin.de, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, luto@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	peterz@infradead.org, wad@chromium.org, thuth@redhat.com, mark.rutland@arm.com, 
	ada.coupriediaz@arm.com, kevin.brodsky@arm.com, linusw@kernel.org, yeoreum.yun@arm.com, 
	song@kernel.org, james.morse@arm.com, anshuman.khandual@arm.com, 
	broonie@kernel.org, liqiang01@kylinos.cn, pengcan@kylinos.cn, ryan.roberts@arm.com, 
	yangtiezhu@loongson.cn, sshegde@linux.ibm.com, mchauras@linux.ibm.com, 
	austin.kim@lge.com, jchrist@linux.ibm.com, arnd@arndb.de, sohil.mehta@intel.com, 
	andrew.cooper3@citrix.com, jgross@suse.com, kas@kernel.org, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-csky@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v16 18/18] arm64: vdso: Expose sigreturn address on vdso
 to the kernel
Message-ID: <20260630172619-6c78c2e2-c2d3-44be-88e6-6c82de12baf4@linutronix.de>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-19-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629130616.642022-19-ruanjinjie@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_083210_227494_D0F3B7B2 
X-CRM114-Status: GOOD (  17.35  )
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

On Mon, Jun 29, 2026 at 09:06:16PM +0800, Jinjie Ruan wrote:
> Syscall User Dispatch (SUD) requires the signal trampoline code to not be
> intercepted. This is necessary to support returning with a locked selector
> while avoiding infinite recursion back into the signal handler.
> 
> Implement arch_syscall_is_vdso_sigreturn() for arm64 to support this
> exclusion mechanism. For native 64-bit tasks, it checks whether the current
> PC matches the 'svc #0' instruction inside the vDSO sigreturn trampoline.
> 
> 	SYM_CODE_START(__kernel_rt_sigreturn)
> 	        mov     x8, #__NR_rt_sigreturn
> 	        svc     #0
> 	SYM_CODE_END(__kernel_rt_sigreturn)
> 
> For COMPAT tasks, it verifies if the instruction falls within
> the architecture's 'sigpage' range, allowing the kernel to safely bypass
> dispatching syscalls originating from these areas back to userspace.
> 
> Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Suggested-by: kemal <kmal@cock.li>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/include/asm/elf.h |  1 +
>  arch/arm64/kernel/vdso.c     | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index d2779d604c7b..f43d4dea916a 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -185,6 +185,7 @@ do {									\
>  struct linux_binprm;
>  extern int arch_setup_additional_pages(struct linux_binprm *bprm,
>  				       int uses_interp);
> +extern bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);

A header for that?

>  /* 1GB of VA */
>  #ifdef CONFIG_COMPAT
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 592dd8668de4..5a0314a3c26e 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -343,3 +343,19 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  
>  	return ret;
>  }
> +
> +bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
> +{
> +	unsigned long sigtramp;
> +
> +#ifdef CONFIG_COMPAT
> +	if (is_compat_task()) {
> +		unsigned long sigpage = (unsigned long)current->mm->context.sigpage;
> +
> +		return regs->pc >= sigpage && regs->pc < (sigpage + PAGE_SIZE);
> +	}
> +#endif
> +	sigtramp = (unsigned long)VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
> +
> +	return regs->pc == (sigtramp + 8);

Instead of hardcoding 'sigtramp + 8' you could add a new label to the 'svc #0'
instruction and use that with VDSO_SYMBOL().


Thomas

