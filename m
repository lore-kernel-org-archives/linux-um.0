Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AE1EEEC3B
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 13:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kNEunTeVMZoZsbTlonWDa4MFr62DcMyj+Pd8OO3wHEk=; b=Qmpco45YWa3vfbxxVl1ge9QFh3
	2SSGC3DrVcUzxSqUVL4aDkSefmQPo8IAkRrs0itYXaeaXj4vyn9bY1GK1erPHV102jAZI/DtsfR+w
	f/pg4XQs+h3Rkk3ggTcCN7F6qHvmLOq4f7E1rlRiTEgJOlDX7Xt2o7kq1XGW1LlAh0aJmjXom4T4+
	K63Qn/OiE1uxWS4FD49TvZ4VYasrdhuqP3gtltPFQj3VB9t1379kQsHc2cTaraEMx6jWj+zaaoWuy
	jvOSzfYZCUZy38jxSSqgiqc+fzgLp/nbjpGo/7m55ATeEMWHs+dE6ei0sIEVWURDCHcDUDT1/kDZP
	ZBz3sYOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp63V-0000000FzY6-0WMp;
	Fri, 13 Sep 2024 13:09:45 +0000
Received: from out0-193.mail.aliyun.com ([140.205.0.193])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp63R-0000000FzXZ-3uQ5
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 13:09:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726232977; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kNEunTeVMZoZsbTlonWDa4MFr62DcMyj+Pd8OO3wHEk=;
	b=b2O1uPu7V9Ng3j4NRQXVf6njGcxSMJ6Jb9uBqggbvlkZhUJmcmLxxjaXdQuzg/78gcTl6LNOjofQmLsJhpJ8LY5lkIwNcoi/ykF0UV9pWlIAYOs4+XBFmzqOw+oeV1/FHYU/iWfTMuestXTMgddyujIkjOqG4qa2WL9sa7z0Oes=
Received: from 30.39.224.11(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZIM1.15_1726232966)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 21:09:35 +0800
Message-ID: <f6422fd4-ac5c-407b-a0f4-e4fefed02dad@antgroup.com>
Date: Fri, 13 Sep 2024 21:09:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: always use the internal copy of the FP registers
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
References: <20240913082244.767799-1-benjamin@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20240913082244.767799-1-benjamin@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_060942_501062_C323CCD4 
X-CRM114-Status: GOOD (  23.84  )
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

On 2024/9/13 16:22, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> When switching from userspace to the kernel, all registers including the
> FP registers are copied into the kernel and restored later on. As such,
> the true source for the FP register state is actually already in the
> kernel and they should never be grabbed from the userspace process.
> 
> Change the various places to simply copy the data from the internal FP
> register storage area.

Cool! I had similar thoughts, but I haven't tried to make it happen.

> Note that on i386 the format of PTRACE_GETFPREGS
> and PTRACE_GETFPXREGS is different enough that conversion would be
> needed. With this patch, -EINVAL is returned if the non-native format is
> requested.
> 
> The upside is, that this patchset fixes setting registers via ptrace
> (which simply did not work before) as well as fixing setting floating
> point registers using the mcontext on signal return on i386.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> 
> ---
> 
> I think that ideally more changs should be done in this space. For a
> start, one can remove support for hosts without PTRACE_GETFPXREGS. But,
> more importantly, UML should probably implement the regset API, which
> would considerably improve both ptrace and coredump generation and
> should also make it easy to fix the cases where this patch returns an
> error.
> ---
>  arch/um/include/shared/registers.h |  6 ---
>  arch/um/kernel/process.c           | 11 ++++-
>  arch/x86/um/os-Linux/registers.c   | 12 +++---
>  arch/x86/um/ptrace_32.c            | 50 ++++++++++++-----------
>  arch/x86/um/ptrace_64.c            | 20 ++++-----
>  arch/x86/um/signal.c               | 65 ++++++++++++++----------------
>  6 files changed, 80 insertions(+), 84 deletions(-)
> 
> diff --git a/arch/um/include/shared/registers.h b/arch/um/include/shared/registers.h
> index a0450326521c..7d81b2339a48 100644
> --- a/arch/um/include/shared/registers.h
> +++ b/arch/um/include/shared/registers.h
> @@ -8,12 +8,6 @@
>  
>  #include <sysdep/ptrace.h>
>  
> -extern int save_i387_registers(int pid, unsigned long *fp_regs);
> -extern int restore_i387_registers(int pid, unsigned long *fp_regs);
> -extern int save_fp_registers(int pid, unsigned long *fp_regs);
> -extern int restore_fp_registers(int pid, unsigned long *fp_regs);
> -extern int save_fpx_registers(int pid, unsigned long *fp_regs);
> -extern int restore_fpx_registers(int pid, unsigned long *fp_regs);
>  extern int init_pid_registers(int pid);
>  extern void get_safe_registers(unsigned long *regs, unsigned long *fp_regs);
>  extern int get_fp_registers(int pid, unsigned long *regs);
> diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
> index be2856af6d4c..ad798d40f8a4 100644
> --- a/arch/um/kernel/process.c
> +++ b/arch/um/kernel/process.c
> @@ -290,8 +290,15 @@ unsigned long __get_wchan(struct task_struct *p)
>  
>  int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
>  {
> -	int cpu = current_thread_info()->cpu;
> +#ifdef CONFIG_X86_32
> +	extern int have_fpx_regs;
>  
> -	return save_i387_registers(userspace_pid[cpu], (unsigned long *) fpu);
> +	/* FIXME: A plain copy does not work on i386 with have_fpx_regs */
> +	if (have_fpx_regs)
> +		return -1;
> +#endif
> +	memcpy(fpu, &t->thread.regs.regs.fp, sizeof(*fpu));
> +
> +	return 0;
>  }

This function is expected to return a boolean value which should be
true on success.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/binfmt_elf.c?h=v6.11-rc7#n1816

Regards,
Tiwei

