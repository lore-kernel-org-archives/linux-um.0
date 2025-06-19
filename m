Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1322C7115C
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 11:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o1tFXS+TJ1ZGCzP8M87H8urSF5Lqav+Fm/SKH+l0rSM=; b=sp1OYeGgBjjuIO0Sh6Ypy8QO+l
	vJovCPbpHxkHypH0to78Ufg5DMaRyLMMCoIqNsp2/GbS8YUsr0Z/sDRM+bVY2u56Zr3x86VzYXcVq
	0h21pYrPUYayTZaY0BUExTVebsGE+4vqk73KjZ/3synqTpLzf5/bzVPezwgs7XS/Sdy2FnIASU1Bf
	XsMNspQ+q2kkozRRaxtCn98oP//QadsBvturuTXzMbndVU4NM5PnBvnFgEKAjo0lFIxhA4rxlXbke
	JTS8tlEIXruwRFM6bbu43AQ8AeK8YxxtPi+unOLjEsHdeTbPE5m3ONGIz+HY2o8e9QLuqWpJPFfk2
	bXbaoHlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSDW8-0000000CtVT-3Z6K;
	Thu, 19 Jun 2025 11:33:16 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSCcv-0000000ClVH-0sDW
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 10:36:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=o1tFXS+TJ1ZGCzP8M87H8urSF5Lqav+Fm/SKH+l0rSM=;
	t=1750329371; x=1751538971; b=baWK5ldzhjYbrIbhMgq0NYwpSmUkytuBuJNHYPBH/TXy542
	vQeWdRrwH2R0EKgEl3O2NNhbHYltmQjoZaowayDYcLqhpbLwpDkYCRIMWP1+yQ/d1Gmf8pR2LUWnw
	Qbbq8SuOLsU+QaYrCQHBpuuRejhMQBydv6evH1fINgpmtLtL7Z9+mjX8YOW91JPmmBYLALySq0nvh
	RvfXn4smZoVar+tSIPac9a934ZOJ63tBVixgS+liWeywxsErOtuHfaV7omKTs7034dfDuZxlk9TZs
	8jrWAPc/CfMpeMDhuOLAPEaw1kTpi5ZQQElGPRU7M5lnQrDZyud0zrXq1A6hikzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uSCcq-00000000weQ-1JoW;
	Thu, 19 Jun 2025 12:36:08 +0200
Message-ID: <55ff3fa8f19c61745933e7814029cef526271eb4.camel@sipsolutions.net>
Subject: Re: [PATCH v9 06/13] x86/um: nommu: process/thread handling
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org
Date: Thu, 19 Jun 2025 12:36:04 +0200
In-Reply-To: <031503649a24799bff082cf917c36550f4820181.1750294482.git.thehajime@gmail.com> (sfid-20250619_030508_526938_21F4E6DC)
References: <cover.1750294482.git.thehajime@gmail.com>
	 <031503649a24799bff082cf917c36550f4820181.1750294482.git.thehajime@gmail.com>
	 (sfid-20250619_030508_526938_21F4E6DC)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250619_033613_272102_1CA3F109 
X-CRM114-Status: GOOD (  20.47  )
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

Hi,

On Thu, 2025-06-19 at 10:04 +0900, Hajime Tazaki wrote:
> Since ptrace facility isn't used under !MMU of UML, there is different
> code path to invoke processes/threads; there are no external process
> used, and need to properly configure some of registers (fs segment
> register for TLS, etc) on every context switch, etc.
>=20
> Signals aren't delivered in non-ptrace syscall entry/leave so, we also
> need to handle pending signal by ourselves.
>=20
> ptrace related syscalls are not tested yet so, marked
> arch_has_single_step() unsupported in !MMU environment.
>=20
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> Signed-off-by: Ricardo Koller <ricarkol@google.com>
> ---
> =C2=A0arch/um/include/asm/ptrace-generic.h |=C2=A0 2 +-
> =C2=A0arch/x86/um/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +-
> =C2=A0arch/x86/um/nommu/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0arch/x86/um/nommu/entry_64.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 22 ++++++++++++++
> =C2=A0arch/x86/um/nommu/syscalls_64.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 44 =
++++++++++++++++++++++++++++
> =C2=A05 files changed, 70 insertions(+), 3 deletions(-)
> =C2=A0create mode 100644 arch/x86/um/nommu/syscalls_64.c
>=20
> diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/p=
trace-generic.h
> index 4ff844bcb1cd..a9778c9a59a3 100644
> --- a/arch/um/include/asm/ptrace-generic.h
> +++ b/arch/um/include/asm/ptrace-generic.h
> @@ -14,7 +14,7 @@ struct pt_regs {
> =C2=A0	struct uml_pt_regs regs;
> =C2=A0};
> =C2=A0
> -#define arch_has_single_step()	(1)
> +#define arch_has_single_step()	(IS_ENABLED(CONFIG_MMU))
> =C2=A0
> =C2=A0#define EMPTY_REGS { .regs =3D EMPTY_UML_PT_REGS }
> =C2=A0
> diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> index 227af2a987e2..53c9ebb3c41c 100644
> --- a/arch/x86/um/Makefile
> +++ b/arch/x86/um/Makefile
> @@ -27,7 +27,8 @@ subarch-y +=3D ../kernel/sys_ia32.o
> =C2=A0
> =C2=A0else
> =C2=A0
> -obj-y +=3D syscalls_64.o vdso/
> +obj-y +=3D vdso/
> +obj-$(CONFIG_MMU) +=3D syscalls_64.o
> =C2=A0
> =C2=A0subarch-y =3D ../lib/csum-partial_64.o ../lib/memcpy_64.o \
> =C2=A0	../lib/memmove_64.o ../lib/memset_64.o
> diff --git a/arch/x86/um/nommu/Makefile b/arch/x86/um/nommu/Makefile
> index ebe47d4836f4..4018d9e0aba0 100644
> --- a/arch/x86/um/nommu/Makefile
> +++ b/arch/x86/um/nommu/Makefile
> @@ -5,4 +5,4 @@ else
> =C2=A0	BITS :=3D 64
> =C2=A0endif
> =C2=A0
> -obj-y =3D do_syscall_$(BITS).o entry_$(BITS).o os-Linux/
> +obj-y =3D do_syscall_$(BITS).o entry_$(BITS).o syscalls_$(BITS).o os-Lin=
ux/
> diff --git a/arch/x86/um/nommu/entry_64.S b/arch/x86/um/nommu/entry_64.S
> index e9bfc7b93c84..950447dfa66b 100644
> --- a/arch/x86/um/nommu/entry_64.S
> +++ b/arch/x86/um/nommu/entry_64.S
> @@ -89,3 +89,25 @@ ENTRY(__kernel_vsyscall)
> =C2=A0	jmp	*%rcx
> =C2=A0
> =C2=A0END(__kernel_vsyscall)
> +
> +// void userspace(struct uml_pt_regs *regs)
> +ENTRY(userspace)
> +
> +	/* align the stack for x86_64 ABI */
> +	and=C2=A0=C2=A0=C2=A0=C2=A0 $-0x10, %rsp
> +	/* Handle any immediate reschedules or signals */
> +	call	interrupt_end
> +
> +	movq	current_ptregs, %rsp
> +
> +	POP_REGS
> +
> +	addq	$8, %rsp	/* skip orig_ax */
> +	popq	%r11		/* pt_regs->ip */
> +	addq	$8, %rsp	/* skip cs */
> +	addq	$8, %rsp	/* skip flags */
> +	popq	%rsp
> +
> +	jmp	*%r11
> +
> +END(userspace)
> diff --git a/arch/x86/um/nommu/syscalls_64.c b/arch/x86/um/nommu/syscalls=
_64.c
> new file mode 100644
> index 000000000000..c78c442aed1d
> --- /dev/null
> +++ b/arch/x86/um/nommu/syscalls_64.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2003 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> + * Copyright 2003 PathScale, Inc.
> + *
> + * Licensed under the GPL
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/sched/mm.h>
> +#include <linux/syscalls.h>
> +#include <linux/uaccess.h>
> +#include <asm/prctl.h> /* XXX This should get the constants from libc */
> +#include <registers.h>
> +#include <os.h>
> +#include "syscalls.h"
> +
> +void arch_switch_to(struct task_struct *to)
> +{
> +	/*
> +	 * In !CONFIG_MMU, it doesn't ptrace thus,
> +	 * The FS_BASE/GS_BASE registers are saved here.
> +	 */
> +	current_top_of_stack =3D task_top_of_stack(to);
> +	current_ptregs =3D (long)task_pt_regs(to);
> +
> +	if ((to->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)] =3D=3D 0)=
 ||
> +	=C2=A0=C2=A0=C2=A0 (to->mm =3D=3D NULL))
> +		return;
> +
> +	/* this changes the FS on every context switch */
> +	arch_prctl(to, ARCH_SET_FS,
> +		=C2=A0=C2=A0 (void __user *) to->thread.regs.regs.gp[FS_BASE / sizeof(=
unsigned long)]);

Hmm,  the comment mentions FS_BASE/GS_BASE, but here you only handle
FS_BASE? Is that intentional?

Benjamin


> +}
> +
> +SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
> +		unsigned long, prot, unsigned long, flags,
> +		unsigned long, fd, unsigned long, off)
> +{
> +	if (off & ~PAGE_MASK)
> +		return -EINVAL;
> +
> +	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
> +}


