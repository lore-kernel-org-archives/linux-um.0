Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC55CAC58E
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 09:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uuiFwFdUmEb3KyaK4LSgIK/XQJhQ26QYeUh+dIW+CTE=; b=oCJuiejYO5KW+O1V4G28zlI667
	drimRAT9huImBlCUaye029rGAiqE5okZY1kvvEgXmSflbJWcIAXI4Z4EDVL4gpH55ILRNuRhdOYXH
	qz6kUKVQBKD0bY8UDNmeuQ9J/Juwj1albuWTy6KIM2aR/rJVglwofkLOkJciJK66k8d3MY/sCJa2j
	oOGQShDBpK/7+snlKdprNMy++YMY/zZlnne3YcDFgXxGOaHYnZTO0eFdKFIpzhpXCQjerOVss7Yyd
	4cyNM+X15h0w0+FztzCzfIdT1WRTJdK1BAnyLYfKLZr49jOM0kwNu8Z5XClzBvgElrAGcfKj0lplx
	rivCULCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy5Bj-00000003NFm-3hqM;
	Mon, 15 Sep 2025 09:07:55 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy5Bh-00000003NFM-3V1R
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 09:07:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757927271;
	bh=4yuYGuUCG9ZnWQ/ykpURTCRtVPfeMJh0JSqCuvBp7Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YF9Gvzw1617gAlI8HLr3bJP6ANZID1fqEojln0udCjl7467q7pSw5zRbQImSH4vfK
	 Je+2cwfLzNkXwZXT/ZeC6bqG4z5nVsZUYlKzPfmrdXsAvCJBPshS3yvJeM8i75jbGH
	 zsHsfMMe0Y7HkyAQkM0zDWM5jnsSL4mxjEZonTMA=
Date: Mon, 15 Sep 2025 11:07:51 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 9/9] um: switch ptrace FP register access to nolibc
Message-ID: <5502ceaf-0b40-4961-b9ba-0c5e63498778@t-8ch.de>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
 <20250915071115.1429196-10-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915071115.1429196-10-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_020754_046246_248CE12B 
X-CRM114-Status: GOOD (  17.46  )
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

On 2025-09-15 09:11:15+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The registers.c file only contain the routines for floating point
> register access in ptrace mode and initial size detection. The file can
> be moved over to nolibc by replacing the ptrace libc call with a simple
> wrapper that does a direct syscall.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  arch/x86/um/os-Linux/Makefile    |  5 ++++-
>  arch/x86/um/os-Linux/registers.c | 22 ++++++++--------------
>  2 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/um/os-Linux/Makefile b/arch/x86/um/os-Linux/Makefile
> index 77a308aaa5ec..d37320430822 100644
> --- a/arch/x86/um/os-Linux/Makefile
> +++ b/arch/x86/um/os-Linux/Makefile
> @@ -3,10 +3,13 @@
>  # Licensed under the GPL
>  #
>  
> -obj-y = registers.o mcontext.o
> +obj-y = mcontext.o
>  
>  obj-$(CONFIG_X86_32) += tls.o
>  
>  USER_OBJS := $(obj-y)
>  
> +obj-y += registers.o
> +NOLIBC_OBJS := registers.o
> +
>  include $(srctree)/arch/um/scripts/Makefile.rules
> diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
> index eb1cdadc8a61..55bce0d3f5d2 100644
> --- a/arch/x86/um/os-Linux/registers.c
> +++ b/arch/x86/um/os-Linux/registers.c
> @@ -6,18 +6,20 @@
>  
>  #include <errno.h>

Given that you are explicitly disabling errno support for nolibc, is
this include necessary?

>  #include <stdlib.h>
> -#include <sys/ptrace.h>
> +#include <linux/ptrace.h>
>  #ifdef __i386__
>  #include <sys/user.h>
>  #endif
>  #include <longjmp.h>
>  #include <sysdep/ptrace_user.h>
> -#include <sys/uio.h>
> +#include <linux/uio.h>

It looks fairly trivial to add sys/uio.h to nolibc.
Only 'struct iovec' (already provided by the UAPI) and readv()/writev()
are necessary.

>  #include <asm/sigcontext.h>
>  #include <linux/elf.h>
>  #include <registers.h>
>  #include <sys/mman.h>
>  
> +#define my_ptrace(...) my_syscall4(__NR_ptrace, __VA_ARGS__)

Why not add sys/ptrace.h to nolibc and then use sys_ptrace()?
In general I'm not a fan of the my_syscall() naming scheme and would
like to change this in nolibc itself, so having fewer external users
would be nice.

> +
>  static unsigned long ptrace_regset;
>  unsigned long host_fp_size;

(...)

