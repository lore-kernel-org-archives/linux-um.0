Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34745C36010
	for <linux-um@archiver.kernel.org>; Fri,  4 Apr 2025 21:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b051QUX3UtX/R5LwAMioVLK4E9rgok5BIu5BrEoTuDA=; b=CLcEosZqzoprpEhemO3rpNM6c+
	pOHU0gz4c7dTpVpUo3mhPW1rVT+eUWUIGopvhaRyWWxfiuGqxJhlI211gBqqI/rtwzzEqS3+EOej4
	0EN53VSNxOxBVzU36FMGqZGSPmc60k+6MOurcLpE6kMukyWn4gypMBddO4498ls3vN3K+Q6fEhGMR
	sCVL/4KpMUsI97bwI0cxmZVmloM+UW1VWdPGHzIAIzURwO7j3n6pXzxImSkwUVoTPpVYrQhW/fu/r
	aFTSCNXbfmVDBrYNGYqxVdF70DsC0HB8QJtYOgkCcXR5JIO3VLULQbZO4O1/E423iKbm65RuPhoRa
	vpfNROVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0oKe-0000000CrUC-2XQW;
	Fri, 04 Apr 2025 21:12:08 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0oKc-0000000CrTY-3Fdp
	for linux-um@lists.infradead.org;
	Fri, 04 Apr 2025 21:12:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A8AAAA468C0;
	Fri,  4 Apr 2025 21:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5478FC4CEDD;
	Fri,  4 Apr 2025 21:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743801125;
	bh=c41VoVob9JxIaXHt65iyTULs+UIrvUrhj7v93r/214U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JhGHUAC76KC7nIuwxuLSz406addg7bxZ9rycXCDim12I1I+rhOPbdebKSm5vLNye1
	 ZqxMenwSxEN0/ARJhUUO+oER7TWGWkvn+1hmXEdHz5qVyA53A2WYa1RubDetkmZft6
	 q8UmB6gTVb1NXoRQqFNcQbF86ttCRYNL8h3SGs02HDUlpOi4+lFSNKgin3c0NwuqeU
	 YkTq1tbxJrO0dIToD92DJsnxhucSI+6VE7mPDuzVEp4J/rYAsWKHa85aydVCR4X3OB
	 KFI6syerKy1IHevUn8lgj+esJjigA21eZOcPkH1ti92ehqeP5hOBU1lyjRR5pr3WFJ
	 QWxEOWkH36VpQ==
Date: Fri, 4 Apr 2025 14:12:01 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] um: fix _nofault accesses
Message-ID: <20250404211201.GB299251@ax162>
References: <20250404170518.e88e8ad2d4cc.Ia93876fd0393b68c171d47cd9678aa458ed10d98@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404170518.e88e8ad2d4cc.Ia93876fd0393b68c171d47cd9678aa458ed10d98@changeid>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_141206_946676_1D5BF6F5 
X-CRM114-Status: GOOD (  25.19  )
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

On Fri, Apr 04, 2025 at 05:05:19PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Nathan reported [1] that when built with clang, the um kernel
> crashes pretty much immediately. This turned out to be an issue
> with the inline assembly I had added, when clang used %rax/%eax
> for both operands. Reorder it so current->thread.segv_continue
> is written first, and then the lifetime of _faulted won't have
> overlap with the lifetime of segv_continue.
> 
> In the email thread Benjamin also pointed out that current->mm
> is only NULL for true kernel tasks, but we could do this for a
> userspace task, so the current->thread.segv_continue logic must
> be lifted out of the mm==NULL check.
> 
> Finally, while looking at this, put a barrier() so the NULL
> assignment to thread.segv_continue cannot be reorder before
> the possibly faulting operation.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/r/20250402221254.GA384@ax162 [1]
> Fixes: d1d7f01f7cd3 ("um: mark rodata read-only and implement _nofault accesses")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks, this makes my test case happy.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/um/include/asm/uaccess.h            |  2 ++
>  arch/um/kernel/trap.c                    | 26 ++++++++++++------------
>  arch/x86/um/shared/sysdep/faultinfo_32.h |  2 +-
>  arch/x86/um/shared/sysdep/faultinfo_64.h |  2 +-
>  4 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
> index 3a08f9029a3f..1c6e0ae41b0c 100644
> --- a/arch/um/include/asm/uaccess.h
> +++ b/arch/um/include/asm/uaccess.h
> @@ -55,6 +55,7 @@ do {									\
>  		goto err_label;						\
>  	}								\
>  	*((type *)dst) = get_unaligned((type *)(src));			\
> +	barrier();							\
>  	current->thread.segv_continue = NULL;				\
>  } while (0)
>  
> @@ -66,6 +67,7 @@ do {									\
>  	if (__faulted)							\
>  		goto err_label;						\
>  	put_unaligned(*((type *)src), (type *)(dst));			\
> +	barrier();							\
>  	current->thread.segv_continue = NULL;				\
>  } while (0)
>  
> diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
> index ce073150dc20..ef2272e92a43 100644
> --- a/arch/um/kernel/trap.c
> +++ b/arch/um/kernel/trap.c
> @@ -225,20 +225,20 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
>  			panic("Failed to sync kernel TLBs: %d", err);
>  		goto out;
>  	}
> -	else if (current->mm == NULL) {
> -		if (current->pagefault_disabled) {
> -			if (!mc) {
> -				show_regs(container_of(regs, struct pt_regs, regs));
> -				panic("Segfault with pagefaults disabled but no mcontext");
> -			}
> -			if (!current->thread.segv_continue) {
> -				show_regs(container_of(regs, struct pt_regs, regs));
> -				panic("Segfault without recovery target");
> -			}
> -			mc_set_rip(mc, current->thread.segv_continue);
> -			current->thread.segv_continue = NULL;
> -			goto out;
> +	else if (current->pagefault_disabled) {
> +		if (!mc) {
> +			show_regs(container_of(regs, struct pt_regs, regs));
> +			panic("Segfault with pagefaults disabled but no mcontext");
>  		}
> +		if (!current->thread.segv_continue) {
> +			show_regs(container_of(regs, struct pt_regs, regs));
> +			panic("Segfault without recovery target");
> +		}
> +		mc_set_rip(mc, current->thread.segv_continue);
> +		current->thread.segv_continue = NULL;
> +		goto out;
> +	}
> +	else if (current->mm == NULL) {
>  		show_regs(container_of(regs, struct pt_regs, regs));
>  		panic("Segfault with no mm");
>  	}
> diff --git a/arch/x86/um/shared/sysdep/faultinfo_32.h b/arch/x86/um/shared/sysdep/faultinfo_32.h
> index ab5c8e47049c..9193a7790a71 100644
> --- a/arch/x86/um/shared/sysdep/faultinfo_32.h
> +++ b/arch/x86/um/shared/sysdep/faultinfo_32.h
> @@ -31,8 +31,8 @@ struct faultinfo {
>  
>  #define ___backtrack_faulted(_faulted)					\
>  	asm volatile (							\
> -		"mov $0, %0\n"						\
>  		"movl $__get_kernel_nofault_faulted_%=,%1\n"		\
> +		"mov $0, %0\n"						\
>  		"jmp _end_%=\n"						\
>  		"__get_kernel_nofault_faulted_%=:\n"			\
>  		"mov $1, %0;"						\
> diff --git a/arch/x86/um/shared/sysdep/faultinfo_64.h b/arch/x86/um/shared/sysdep/faultinfo_64.h
> index 26fb4835d3e9..61e4ca1e0ab5 100644
> --- a/arch/x86/um/shared/sysdep/faultinfo_64.h
> +++ b/arch/x86/um/shared/sysdep/faultinfo_64.h
> @@ -31,8 +31,8 @@ struct faultinfo {
>  
>  #define ___backtrack_faulted(_faulted)					\
>  	asm volatile (							\
> -		"mov $0, %0\n"						\
>  		"movq $__get_kernel_nofault_faulted_%=,%1\n"		\
> +		"mov $0, %0\n"						\
>  		"jmp _end_%=\n"						\
>  		"__get_kernel_nofault_faulted_%=:\n"			\
>  		"mov $1, %0;"						\
> -- 
> 2.49.0
> 

