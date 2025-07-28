Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B877DC87FC9
	for <linux-um@archiver.kernel.org>; Mon, 28 Jul 2025 11:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P78DUA8gdUh/DnTSJLNoinyom7BKeyDXzzR0VnFVu0I=; b=wRhC3ntpBebgUbo/lLki7vrRXl
	Gn3iofOpsbWsCnYIqzB/nzI7t1m1F+YyttXHcjR8ygouTh8qUzArRx/4YkzJlUq2u8VOZVv4FG+L7
	EcXuwFoaZX+2Pzi2XkidtlGfDIKU8C9bXlZ6sfo+26tpOJWggLxcVTSd3K3ShOjyFjPdhRqSC1IMt
	rY0ZZ45SbbEzI50f+zy9DaAb4oW6zr3QwL39jxZ1/bRIKP7UOz6nL/bsVlVy11rAKFNQdGxBVtSYx
	+BdtwEKXKNbyBJscjEZJAy/AdUrEQLkxSQvX20yXaIfvKwYSeJksgCxPNMFApB556BSfXT+gbd2nN
	aSYNqAEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugLav-0000000EItj-0WzA;
	Mon, 28 Jul 2025 11:00:37 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugLO1-0000000EGfA-1JjD
	for linux-um@lists.infradead.org;
	Mon, 28 Jul 2025 10:47:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=P78DUA8gdUh/DnTSJLNoinyom7BKeyDXzzR0VnFVu0I=;
	t=1753699635; x=1754909235; b=iu0EX/+WL1E+oCp/nES+RTKtTSy1mjt+iS7PFR92zXJpOJH
	p0vdMeU2aKRN1gwVIYTVbko8xl5Rmd6mxzyMZhJwcaeqN0eQEYzoOW1tozFrOvmLW5oIMw9/a5COI
	StQWkgrD0POROvUAX2jQ3eRiMivUxlamgeoT/lUYq73UNRBXabtZMEV6S9W/JojkqDHEiy2/j3q4e
	2uC5ZDDH6WXEOTJ5P56VRJNpNmol578z2wwyYCYbZBrxTGkcEL6DaasYLiFGJUiqvZjhECoOH8Ga0
	EehBUw1gGVB5p4/ztWnsv8QVQhRhWw9dGK3tKf511V0V+wEUgXt4DPZZv3VFVyAw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ugLNt-0000000Cfcm-21ak;
	Mon, 28 Jul 2025 12:47:09 +0200
Message-ID: <233c916a5c598ca246b3138d13aaad44fdde68b2.camel@sipsolutions.net>
Subject: Re: [PATCH 9/9] um: Add initial SMP support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, tiwei.btw@antgroup.com, 
	linux-arch@vger.kernel.org
Date: Mon, 28 Jul 2025 12:47:08 +0200
In-Reply-To: <20250727062937.1369050-10-tiwei.bie@linux.dev> (sfid-20250727_083200_844163_0A31491B)
References: <20250727062937.1369050-1-tiwei.bie@linux.dev>
	 <20250727062937.1369050-10-tiwei.bie@linux.dev>
	 (sfid-20250727_083200_844163_0A31491B)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250728_034717_377226_D860E40D 
X-CRM114-Status: GOOD (  17.50  )
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

On Sun, 2025-07-27 at 14:29 +0800, Tiwei Bie wrote:
>=20
> +++ b/arch/um/include/asm/smp.h
> @@ -2,6 +2,27 @@
>  #ifndef __UM_SMP_H
>  #define __UM_SMP_H
> =20
> -#define hard_smp_processor_id()		0
> +#if IS_ENABLED(CONFIG_SMP)
> +
> +#include <linux/bitops.h>
> +#include <asm/current.h>
> +#include <linux/cpumask.h>
> +#include <shared/smp.h>
> +
> +#define raw_smp_processor_id() uml_curr_cpu()
> +
> +void arch_smp_send_reschedule(int cpu);
> +
> +void arch_send_call_function_single_ipi(int cpu);
> +
> +void arch_send_call_function_ipi_mask(const struct cpumask *mask);
> +
> +static inline void smp_cpus_done(unsigned int maxcpus) { }
> +
> +#else /* !CONFIG_SMP */
> +
> +#define raw_smp_processor_id() 0

This seems a bit odd to me, linux/smp.h also defines
raw_smp_processor_id() to 0 the same way, unconditionally.

It almost seems to me we should define raw_smp_processor_id() only for
SMP? But then also __smp_processor_id()? Maybe not?

linux-arch folks, do you have any comments?

> --- /dev/null
> +++ b/arch/um/include/asm/spinlock.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_UM_SPINLOCK_H
> +#define __ASM_UM_SPINLOCK_H
> +
> +#include <asm/processor.h>
> +#include <asm-generic/spinlock.h>
> +
> +#endif /* __ASM_UM_SPINLOCK_H */

Do we need this file? Maybe asm-generic should be including the right
things it needs?

> +void enter_turnstile(struct mm_id *mm_id);
> +void exit_turnstile(struct mm_id *mm_id);

We could add __acquires(turnstile) and __releases(turnstile) or
something, to have sparse check that it's locked/unlocked correctly, but
not sure it's worth it.

> +int disable_kmalloc[NR_CPUS] =3D { 0 };

nit: you can remove the "0".

> +int smp_sigio_handler(struct uml_pt_regs *regs)
> +{
> +	int cpu =3D raw_smp_processor_id();
> +
> +	IPI_handler(cpu, regs);
> +	if (cpu !=3D 0)
> +		return 1;
> +	return 0;

nit: "return cpu !=3D 0;" perhaps

> +__uml_setup("ncpus=3D", uml_ncpus_setup,
> +"ncpus=3D<# of desired CPUs>\n"
> +"    This tells UML how many virtual processors to start. The maximum\n"
> +"    number of supported virtual processors can be obtained by querying\=
n"
> +"    the CONFIG_NR_CPUS option using --showconfig.\n\n"


I feel like probably this should at least for now be mutually exclusive
with time-travel=3D parameters, at least if it's not 1? Or perhaps only
with time-travel=3Dext?

The timer code is in another patch, will look at that also. I guess
until then it's more of a gut feeling on "how would this work" :)

johannes

