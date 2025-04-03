Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B237FC3601A
	for <linux-um@archiver.kernel.org>; Thu,  3 Apr 2025 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BqAS3ar+stmnWAgx4WLHG9me7UcMtPPHCaS+5D5/EJc=; b=HLc6XImVQOfm99kRSW0Wj6U1/x
	GDE0/2wrebr+LOFW7u76cyNmpEPLsa/XQ1Zjo9j+yNjHtkSV8XKokS0K0l5U18lwJR++m4b6VjLLh
	0FcN+x+tS4GAduFnk76njMpQGAWULIpDKwJd9ppHnNYx085YYLr5i8voHDqVanNIkI3ZwhMKtXxYr
	3D85hKJRCj9YbxcC2DOD0ByNJHSgG1b5QPWzFmVucMDHMYnUqUsMQrdANoY7EWS6j/2yZOCmlSVx/
	1vaj4jESEi8a+4rzmhs7s4Y0nXhFfytqb38aRZ1oluedgNEBJhaHti3tjCGClNPa6WVO1S+2odcUd
	XKAxchZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0QbG-00000009pe9-2KNw;
	Thu, 03 Apr 2025 19:51:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Q5q-00000009iEv-0snY
	for linux-um@lists.infradead.org;
	Thu, 03 Apr 2025 19:19:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 69E6144CA3;
	Thu,  3 Apr 2025 19:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2558C4CEED;
	Thu,  3 Apr 2025 19:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707953;
	bh=IbyUkp6kCh6S6vBIK5UVHOSIuVr1OBes+HRbtrN9NoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lo09+bro5SDyBXuu7a6KK2nZ8bB4QBIM/NG9DYp0YzZNEgTxpn6B9y+lWx3zbPQ+9
	 5cXiE/FyIozkiigZGUAb15G+QsaKlrrHCnlHu+UN3k1AYN3TcIYDPEskSMgmsCe6v1
	 cdhJQvalFIyAnNHZYP9c4Z04ybblyH+bGh+Pn2rMh9Zc3C5Bpa8TGRC65/P4yodFNH
	 nQMSNsTd92xXdLUHpuPzBKh8fHFV2Ha8jSg+JXlrr8n65SbhoeaCxUSq8HtNNCzy6b
	 XHvMAGeQy1SdozdIhynAgfcaEkXYqZ8XC1z16L7BHUZz7z/Ge3eBuQZObb0H2icrIh
	 8MI+UVl1SghBg==
Date: Thu, 3 Apr 2025 12:19:10 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Johannes Berg <johannes.berg@intel.com>,
	llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] um: mark rodata read-only and implement _nofault
 accesses
Message-ID: <20250403191910.GA3085607@ax162>
References: <20250210160926.420133-1-benjamin@sipsolutions.net>
 <20250210160926.420133-2-benjamin@sipsolutions.net>
 <20250402221254.GA384@ax162>
 <413669a192e65d67059245d38c03828f85d20717.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413669a192e65d67059245d38c03828f85d20717.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_121914_289235_53E86085 
X-CRM114-Status: GOOD (  20.62  )
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

On Thu, Apr 03, 2025 at 08:20:23AM +0200, Benjamin Berg wrote:
> Hi Nathan,
> 
> oops, that is a little logic bug in the code. When we are coming from
> userspace, we may be running as part of a user task and have an mm. And
> then the new "current->pagefault_disabled" logic is skipped. So when
> prepend_copy is doing its nofault copy to evade a lock it is crashing
> instead of failing gracefully and retrying.
> 
> In segv_handler, can you try moving that into a separate "else if"
> block just above the "current->mm == NULL" check?
> 
> Something like the patch I copied below.

Thanks, I applied that change, which shows a slightly different crash
message now:

Modules linked in:
Pid: 24, comm: mount Not tainted 6.14.0-rc5-00002-gd1d7f01f7cd3-dirty
RIP: 0033:_end_0+0x38/0x45
RSP: 00000000648bfca0  EFLAGS: 00010206
RAX: 0000000000000000 RBX: 00000000609c7ff8 RCX: 00000000606350b8
RDX: 00000000648bfc5e RSI: 0000000000001000 RDI: 0000000060c0c000
RBP: 00000000648bfcc0 R08: 0000000000000000 R09: 0000000060c0c780
R10: 0000000000000000 R11: 0000000000000206 R12: 00000000648bfd60
R13: 0000000060c0c900 R14: 0000000060c0c9f8 R15: 0000000000000007
Kernel panic - not syncing: Segfault without recovery target
CPU: 0 UID: 0 PID: 24 Comm: mount Not tainted 6.14.0-rc5-00002-gd1d7f01f7cd3-dirty #1
Stack:
 600c25f9 00000007 609c7ff8 608c4780
 648bfcf0 601533da 601533bb 648bfd60
 648bfdb0 608c4780 648bfd10 60152ece
Call Trace:
 [<600c25f9>] ? copy_from_kernel_nofault+0x0/0x64
 [<601533da>] prepend_copy+0x1f/0x51
 [<601533bb>] ? prepend_copy+0x0/0x51
 [<60152ece>] prepend+0x60/0x67
 [<60153389>] prepend_name+0x1f/0x51
 [<6015336a>] ? prepend_name+0x0/0x51
 [<60152bbd>] prepend_path+0xb9/0x1d8
 [<6003cb91>] ? um_set_signals+0x0/0x3b
 [<60152e27>] d_path+0xce/0x115
 [<60186805>] proc_pid_readlink+0xa1/0x17d
 [<6012b192>] vfs_readlink+0xec/0xee
 [<60138930>] ? touch_atime+0x0/0x162
 [<60120351>] do_readlinkat+0xbe/0x13a
 [<6011f92b>] sys_readlinkat+0x10/0x14
 [<6002cabb>] handle_syscall+0x7b/0xaa
 [<6002ca40>] ? handle_syscall+0x0/0xaa
 [<6003f695>] userspace+0x289/0x4a5
 [<6002a8e3>] fork_handler+0x56/0x5d

> diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
> index cbe924a0fa87..8a2e68d07de6 100644
> --- a/arch/um/kernel/trap.c
> +++ b/arch/um/kernel/trap.c
> @@ -330,20 +330,20 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
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

