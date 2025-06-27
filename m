Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7447CC7EE2A
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 04:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e4SsKNyHocVmPE3uEf3i+nlYrFGTvwC/1u2v7ilqmHM=; b=1QXzEoJoxoxpn3b7ZKa6pSRkK4
	4d8QWfoLOxJSXZ57+QTvyhum7sOrzejXXlBILFXm1A4Fk52s7owY8AfuoAA09IEM312hK96ynkBSG
	B4MWtgxS9rs43gfRgozPUcWUYF8x/nSU8T6Staa4MW3+Fy97uH4DFrBlDf3v2RPiTuwCGjH8Pogus
	Tf0aBNWKhHD6/V1F1Prw7FFjQc9pTHSJvHhaCshXBM8EuYeNolS/OKo6AAdN+yVGHoe/l0lMoCshv
	eUHzSDU3YOy63Nw/Ef3nIsPE+5MRl/bpYFDjeDH/HKOQFH+wupMzFfNAprnbkmugtxoIqwkLwHLZU
	SMyrihKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV17z-0000000DaJI-36B9;
	Fri, 27 Jun 2025 04:55:55 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV11D-0000000DZKk-2v26
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 04:48:57 +0000
Date: Fri, 27 Jun 2025 06:48:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750999734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4SsKNyHocVmPE3uEf3i+nlYrFGTvwC/1u2v7ilqmHM=;
	b=S+3dv3/w0u0xiSdS4n9zFFU8DDC4MqKtFGFMlL6v2LUYjpAOPHhbarEjzdex9ta99asNZl
	Nc6W9d2kRsJ1Hs9OWdDNPElQo9KuBnhxOKNIYpY/1x61l3rRvqgzOQ0RgoCFpypQOWdRqy
	M1bVNwnSdnat41eesb9poMHNzidHIrJRBDxlHbWhpY8rvCaReAjHv7M+4LuToWhjQiIm4o
	ctpbIUpTRaNNeePFNc7npISp85N1mH5pD+uC/m354I0h2fH6xV8bEJRnOE+TjvHY4D79CQ
	Rkhvxtt0R1u4owCxJdlL1Opsz6xyqu29dSLITejmzJAARGlPvRZMZOajmGlIag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750999734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4SsKNyHocVmPE3uEf3i+nlYrFGTvwC/1u2v7ilqmHM=;
	b=XJNEc1I4eJk9j523+kL+RUa+PHPocjDcDsOpxJ+VnUUs2pXGgbNMlzs6CPs5IG8Av1+fa/
	g0kJ28AEIjrohWDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: kunit-dev@googlegroups.com, linux-um@lists.infradead.org, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [RFC 1/2] tools/nolibc: add sigaction()
Message-ID: <20250627063347-cc3c0ad0-7b3b-4bcd-963f-729db103760f@linutronix.de>
References: <20250626195714.2123694-1-benjamin@sipsolutions.net>
 <20250626195714.2123694-2-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626195714.2123694-2-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_214855_874537_DF2ADF72 
X-CRM114-Status: GOOD (  21.70  )
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

On Thu, Jun 26, 2025 at 09:57:13PM +0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> In preparation to add tests that use it.

I tried to implement signal support in nolibc before but ran into some issues.
Unfortunately I don't remember the details.
But I guess you know more about signals than me, so let's try it again.
In any case this should add some tests to
tools/testing/selftests/nolibc/nolibc-test.c.

If you test it with qemu-user please be aware that there were issues around
SA_RESTORER up until recently [0] [1].

[1] https://lore.kernel.org/qemu-devel/20250202-riscv-sa-restorer-v1-1-6f4bf814a1dd@t-8ch.de/
[0] https://lore.kernel.org/qemu-devel/mvmed060xc9.fsf@suse.de/

> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  tools/include/nolibc/nolibc.h |  3 +++
>  tools/include/nolibc/signal.h | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
> index c199ade200c2..29e37a755aba 100644
> --- a/tools/include/nolibc/nolibc.h
> +++ b/tools/include/nolibc/nolibc.h
> @@ -92,6 +92,9 @@
>  #ifndef _NOLIBC_H
>  #define _NOLIBC_H
>  
> +/* So that we do not get compatibility types/defines */
> +#define __KERNEL__

Could you explain this more?

The user may have included kernel UAPI headers already before including nolibc,
so it doesn't really work.

> +
>  #include "std.h"
>  #include "arch.h"
>  #include "types.h"
> diff --git a/tools/include/nolibc/signal.h b/tools/include/nolibc/signal.h
> index ac13e53ac31d..fa52119e577f 100644
> --- a/tools/include/nolibc/signal.h
> +++ b/tools/include/nolibc/signal.h
> @@ -14,6 +14,7 @@
>  #include "arch.h"
>  #include "types.h"
>  #include "sys.h"
> +#include <linux/signal.h>
>  
>  /* This one is not marked static as it's needed by libgcc for divide by zero */
>  int raise(int signal);
> @@ -23,4 +24,37 @@ int raise(int signal)
>  	return sys_kill(sys_getpid(), signal);
>  }
>  
> +/*
> + * sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
> + */
> +
> +#ifdef SA_RESTORER
> +__attribute__((naked))

__attribute__((naked)) is not supported everywhere.

> +static void my_sa_restorer(void)

This should use a name with less potential to conflict with user code.
Like __nolibc_sa_restorer().

> +{
> +	my_syscall0(__NR_rt_sigreturn);
> +}
> +#endif
> +
> +static __attribute__((unused))
> +int sys_sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
> +{
> +	struct sigaction real_act = *act;
> +#ifdef SA_RESTORER
> +	if (!(real_act.sa_flags & SA_RESTORER)) {
> +		real_act.sa_flags |= SA_RESTORER;
> +		real_act.sa_restorer = my_sa_restorer;
> +	}
> +#endif
> +
> +	return my_syscall4(__NR_rt_sigaction, signum, &real_act, oldact,
> +			   sizeof(act->sa_mask));

No need for the linebreak.

> +}
> +
> +static __attribute__((unused))
> +int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
> +{
> +	return __sysret(sys_sigaction(signum, act, oldact));
> +}
> +
>  #endif /* _NOLIBC_SIGNAL_H */
> -- 
> 2.50.0
> 

