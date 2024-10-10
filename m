Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C52CF11E1
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 12:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/6OMnIx6H699JktkVUKORMNGwDbehJ+Jre7EPXCn4H0=; b=0md/PYd8f142iOu9FRA3zc363N
	Uci9fzJJ71Kl50iS/kmaTuPt/TUgRoE07uDwuV0zd15WXoWxbpVQzIGwdBw8DP2KdyVX+V96c5B3D
	AEg2QQVyoXVJanPbV7lLHbP/+AMf20f9w++M6+eIcj0WII3/2xC5jc6tTRfFMZD7+V9SgMTZfPDZT
	58KP9Xi7gpye4nu6CsFsTMAFa0Xqa0AX//8DVtFucNlrgDUxboXRgCzx059uGHG6jRNZnr0dWmLFh
	4s+50Rai3csnuv4mWuO3iXtbSNEZRTKD519t0hdf7+lxCCD1LqCLiJSXZ6z1z5ENzfeNXh24JVof/
	px+WWp8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sysPM-0000000CjQp-2RZg;
	Thu, 10 Oct 2024 12:36:44 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sys1m-0000000CfH6-39Kz
	for linux-um@lists.infradead.org;
	Thu, 10 Oct 2024 12:12:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/6OMnIx6H699JktkVUKORMNGwDbehJ+Jre7EPXCn4H0=;
	t=1728562342; x=1729771942; b=DY/hU9EeImEEn5TgxLgjeGqNw6BFaniwWFxXy43JbLoQqbP
	s1j/CNiNEEDp/XSP8EWCFTWaEjIWizU/AawbebyOx0MjUwmmehFP7JrYryl9ELFUUy4qTiS3FJ9qy
	32DKXq1ofGALSmeygVrx7LurjRgKizaKSpM7cvc7hJEA8JO6LX7xvos5CqPsznlVN3xEEotGguW5a
	QLus8knST88p2mrMFSoaFNp3JMnpdLwBUx7v4zqs8VsM+YEt0IY4AKq2n/7A2r7xuEEu/7RsK9fBd
	q2RSXv8ska2J6/CvOYOW6Tb3ENGsV+Di64XDgAzPOmaopa/Cy+5XMAHVdXjaB7lA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sys1i-000000064ZK-3cI8;
	Thu, 10 Oct 2024 14:12:19 +0200
Message-ID: <590b1ea94cd8166dde2230e8aa8c80045f30cfe4.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 8/9] um: Implement kernel side of SECCOMP based
 process handling
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Date: Thu, 10 Oct 2024 14:12:17 +0200
In-Reply-To: <20240925203232.565086-9-benjamin@sipsolutions.net>
References: <20240925203232.565086-1-benjamin@sipsolutions.net>
	 <20240925203232.565086-9-benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_051222_814145_C0BA7296 
X-CRM114-Status: GOOD (  20.12  )
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

On Wed, 2024-09-25 at 22:32 +0200, Benjamin Berg wrote:
>=20
> +	/*
> +	 * If in seccomp mode, install the SECCOMP filter and trigger a syscall=
.
> +	 * Otherwise set PTRACE_TRACEME and do a SIGSTOP.
> +	 */
> +	if (init_data.seccomp) {
> +		struct sock_filter filter[] =3D {
> +#if __BITS_PER_LONG > 32
> +			/* [0] Load upper 32bit of instruction pointer from seccomp_data */
> +			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
> +				 (offsetof(struct seccomp_data, instruction_pointer) + 4)),
> +
> +			/* [1] Jump forward 3 instructions if the upper address is not identi=
cal */
> +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, (init_data.stub_start) >> 32, 0, =
3),
> +#endif
> +			/* [2] Load lower 32bit of instruction pointer from seccomp_data */
> +			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
> +				 (offsetof(struct seccomp_data, instruction_pointer))),
> +
> +			/* [3] Mask out lower bits */
> +			BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xfffff000),
> +
> +			/* [4] Jump to [6] if the lower bits are not on the expected page */
> +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, (init_data.stub_start) & 0xfffff0=
00, 1, 0),
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
> +
> +			/* [15] Not one of the permitted syscalls */
> +			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
> +
> +			/* [16] Permitted call for the stub */
> +			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
> +		};

So not sure, but what else would you need per the cover letter's
description that it's not complete for the filter?


>   * skas/process.c
>   */
>  void wait_stub_done(int pid);
> +void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_=
sigsys);
> +

nit: extra newline

Also the function can be static?

> +++ b/arch/um/os-Linux/skas/process.c
> @@ -1,9 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> + * Copyright (C) 2021 Benjamin Berg <benjamin@sipsolutions.net>
>   * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
>   * Copyright (C) 2002- 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
>   */
> =20
> +#include <linux/kconfig.h>

Hmm. If this works, why do we have UML_CONFIG_64BIT? For ASM stuff?

But you also use "using_seccomp" so this shouldn't be needed, or you've
set it up very dangerously - that header file should probably include
this then, or whatever is needed?

Otherwise could end up with using_seccomp being used but not defined
properly per the ifdef, and just be statically 0 anyway?

>  #include <stdlib.h>
>  #include <stdbool.h>
>  #include <unistd.h>
> @@ -25,8 +27,11 @@
>  #include <registers.h>
>  #include <skas.h>
>  #include <sysdep/stub.h>
> +#include <sysdep/mcontext.h>
> +#include <linux/futex.h>
>  #include <linux/threads.h>
>  #include <timetravel.h>
> +#include <asm-generic/rwonce.h>
>  #include "../internal.h"
> =20
>  int is_skas_winch(int pid, int fd, void *data)
> @@ -142,6 +147,74 @@ void wait_stub_done(int pid)
>  	fatal_sigsegv();
>  }
> =20
> +#ifdef CONFIG_UML_SECCOMP

Also not sure you need the ifdef at all?

> +void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_=
sigsys)

This could be static and then it doesn't matter to have the ifdef?

> -		CATCH_EINTR(n =3D waitpid(pid, &status, WUNTRACED | __WALL));
> -		if (n < 0) {
> +	if (using_seccomp) {
> +		wait_stub_done_seccomp(mm_id, 1, 1);

Also this builds because you declare the function but don't define it,
but you already rely on the optimisation throwing it out anyway.

> +#ifdef CONFIG_X86_32
> +		extern int have_fpx_regs;
> +
> +		/*
> +		 * FIXME: This is wrong, but the non-FPX layout is closer to
> +		 * what the mcontext presents to us. So, for all intents and
> +		 * purposes we'll behave mostly correct if we do this.

"correctly"

but you don't care anyway since seccomp is only for 64-bit?

johannes

