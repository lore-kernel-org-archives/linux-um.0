Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C872EC19F32
	for <linux-um@archiver.kernel.org>; Fri,  7 Mar 2025 10:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Ur9qS/1GAOuKdkposMVo8MkyCbee5glWvahiWz6zfw=; b=bpszjyj8y/1qBF86gQFWUhpdXj
	Llt3s8B+m++EtC2bHuePNufuZKlbdWFmqb/byLU+c3UV38m9oLbifmwa6SQhJgmtH0BH+cZMeeYVk
	jdh1JYRwo8ZiVhCqjAccO2nl7wZjHExANeNoaoutdBGYCwe5B89IvlQP76JTEOC7l3F4hSJ5yNdY3
	z3wHadLUCnzfHXr0v+yNaybPU++3RuSaCzXjptBmbBPh7CIG++l7gALklqbutRYGYXhdPgq9Oaxh0
	6Ty+pzWJJeYtSMi3pFjUz00Nz6reSupUs06LEv42ZwXtuNDV03wcEmkEKiZC7pDHKRGeCb3YsUydL
	gqBSZ4Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqUwJ-0000000Ds2i-18De;
	Fri, 07 Mar 2025 10:28:23 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqUvo-0000000DrxO-0gRD
	for linux-um@lists.infradead.org;
	Fri, 07 Mar 2025 10:27:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9Ur9qS/1GAOuKdkposMVo8MkyCbee5glWvahiWz6zfw=;
	t=1741343270; x=1742552870; b=Bw0/K6GWcP1ovmntAaiBSsGamOSRKFGjUHkDsv/JYgWirh2
	bCHDU8XD8VBbU1LOH6MiT3n/vA4Z7oCx+qsn453RFVXaqKL8PcQ0DPWV3J8/vOB5jFCMn7kRhv8rP
	gCcve6YFQTatodNqbm/P/WeNSAZSZfbK63e2jOK61DX0EQCNkuibQH5JB/ePJgYwxRszlA1gkHL8z
	+GtQPHXjw8cy8nWezS/PYchwi2DnfUnro8hyvPlc1q3Zq+qCMnqELHzKnayzZCDAfEwDVra5jN7a2
	cEsBZXvZ354wwACRyrTmf44XFdXm36Ma8yyqf4ViEKmYz48fiOY/yxdgJtnAzlyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tqUvg-00000003pKT-3PjS;
	Fri, 07 Mar 2025 11:27:45 +0100
Message-ID: <7d709b34a3add55481c822204e148b28b5e29f81.camel@sipsolutions.net>
Subject: Re: [PATCH 7/9] um: Implement kernel side of SECCOMP based process
 handling
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, johannes@sipsolutions.net
Date: Fri, 07 Mar 2025 11:27:43 +0100
In-Reply-To: <m2wmd1z5gt.wl-thehajime@gmail.com>
References: <20250224181827.647129-1-benjamin@sipsolutions.net>
		<20250224181827.647129-8-benjamin@sipsolutions.net>
	 <m2wmd1z5gt.wl-thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_022752_381031_DB236A3B 
X-CRM114-Status: GOOD (  33.48  )
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

On Fri, 2025-03-07 at 16:04 +0900, Hajime Tazaki wrote:
> thanks for the update; was waiting for this.
>=20
> On Tue, 25 Feb 2025 03:18:25 +0900,
> Benjamin Berg wrote:
> >=20
> > This adds the kernel side of the seccomp based process handling.
> >=20
> > Co-authored-by: Johannes Berg <johannes@sipsolutions.net>
> > Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
> > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> (snip)
> > diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
> > index f8ee5d612c47..0abc509e3f4c 100644
> > --- a/arch/um/kernel/skas/mmu.c
> > +++ b/arch/um/kernel/skas/mmu.c
> > @@ -38,14 +38,11 @@ int init_new_context(struct task_struct *task, stru=
ct mm_struct *mm)
> > =C2=A0	scoped_guard(spinlock_irqsave, &mm_list_lock) {
> > =C2=A0		/* Insert into list, used for lookups when the child dies */
> > =C2=A0		list_add(&mm->context.list, &mm_list);
> > -
>=20
> maybe this is not needed.

Oh, that is a mistake from amending patches. I changed the code and
removed this line in the wrong patch.

> > =C2=A0	}
> > =C2=A0
> > -	new_id->pid =3D start_userspace(stack);
> > -	if (new_id->pid < 0) {
> > -		ret =3D new_id->pid;
> > +	ret =3D start_userspace(new_id);
> > +	if (ret < 0)
> > =C2=A0		goto out_free;
> > -	}
> > =C2=A0
> > =C2=A0	/* Ensure the new MM is clean and nothing unwanted is mapped */
> > =C2=A0	unmap(new_id, 0, STUB_START);
> > diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_=
exe.c
> > index 23c99b285e82..f40f2332b676 100644
> > --- a/arch/um/kernel/skas/stub_exe.c
> > +++ b/arch/um/kernel/skas/stub_exe.c
> > @@ -3,6 +3,9 @@
> > =C2=A0#include <asm/unistd.h>
> > =C2=A0#include <sysdep/stub.h>
> > =C2=A0#include <stub-data.h>
> > +#include <linux/filter.h>
> > +#include <linux/seccomp.h>
> > +#include <generated/asm-offsets.h>
> > =C2=A0
> > =C2=A0void _start(void);
> > =C2=A0
> > @@ -25,8 +28,6 @@ noinline static void real_init(void)
> > =C2=A0	} sa =3D {
> > =C2=A0		/* Need to set SA_RESTORER (but the handler never returns) */
> > =C2=A0		.sa_flags =3D SA_ONSTACK | SA_NODEFER | SA_SIGINFO | 0x04000000=
,
> > -		/* no need to mask any signals */
> > -		.sa_mask =3D 0,
> > =C2=A0	};
> > =C2=A0
> > =C2=A0	/* set a nice name */
> > @@ -35,6 +36,9 @@ noinline static void real_init(void)
> > =C2=A0	/* Make sure this process dies if the kernel dies */
> > =C2=A0	stub_syscall2(__NR_prctl, PR_SET_PDEATHSIG, SIGKILL);
> > =C2=A0
> > +	/* Needed in SECCOMP mode (and safe to do anyway) */
> > +	stub_syscall5(__NR_prctl, PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> > +
> > =C2=A0	/* read information from STDIN and close it */
> > =C2=A0	res =3D stub_syscall3(__NR_read, 0,
> > =C2=A0			=C2=A0=C2=A0=C2=A0 (unsigned long)&init_data, sizeof(init_data=
));
> > @@ -63,18 +67,133 @@ noinline static void real_init(void)
> > =C2=A0	stack.ss_sp =3D (void *)init_data.stub_start + UM_KERN_PAGE_SIZE=
;
> > =C2=A0	stub_syscall2(__NR_sigaltstack, (unsigned long)&stack, 0);
> > =C2=A0
> > -	/* register SIGSEGV handler */
> > -	sa.sa_handler_ =3D (void *) init_data.segv_handler;
> > -	res =3D stub_syscall4(__NR_rt_sigaction, SIGSEGV, (unsigned long)&sa,=
 0,
> > -			=C2=A0=C2=A0=C2=A0 sizeof(sa.sa_mask));
> > -	if (res !=3D 0)
> > -		stub_syscall1(__NR_exit, 13);
> > +	/* register signal handlers */
> > +	sa.sa_handler_ =3D (void *) init_data.signal_handler;
> > +	sa.sa_restorer =3D (void *) init_data.signal_restorer;
> > +	if (!init_data.seccomp) {
> > +		/* In ptrace mode, the SIGSEGV handler never returns */
> > +		sa.sa_mask =3D 0;
> > +
> > +		res =3D stub_syscall4(__NR_rt_sigaction, SIGSEGV,
> > +				=C2=A0=C2=A0=C2=A0 (unsigned long)&sa, 0, sizeof(sa.sa_mask));
> > +		if (res !=3D 0)
> > +			stub_syscall1(__NR_exit, 13);
> > +	} else {
> > +		/* SECCOMP mode uses rt_sigreturn, need to mask all signals */
> > +		sa.sa_mask =3D ~0ULL;
> > +
> > +		res =3D stub_syscall4(__NR_rt_sigaction, SIGSEGV,
> > +				=C2=A0=C2=A0=C2=A0 (unsigned long)&sa, 0, sizeof(sa.sa_mask));
> > +		if (res !=3D 0)
> > +			stub_syscall1(__NR_exit, 14);
> > +
> > +		res =3D stub_syscall4(__NR_rt_sigaction, SIGSYS,
> > +				=C2=A0=C2=A0=C2=A0 (unsigned long)&sa, 0, sizeof(sa.sa_mask));
> > +		if (res !=3D 0)
> > +			stub_syscall1(__NR_exit, 15);
> > +
> > +		res =3D stub_syscall4(__NR_rt_sigaction, SIGALRM,
> > +				=C2=A0=C2=A0=C2=A0 (unsigned long)&sa, 0, sizeof(sa.sa_mask));
> > +		if (res !=3D 0)
> > +			stub_syscall1(__NR_exit, 16);
> > +
> > +		res =3D stub_syscall4(__NR_rt_sigaction, SIGTRAP,
> > +				=C2=A0=C2=A0=C2=A0 (unsigned long)&sa, 0, sizeof(sa.sa_mask));
> > +		if (res !=3D 0)
> > +			stub_syscall1(__NR_exit, 17);
> > +
> > +		res =3D stub_syscall4(__NR_rt_sigaction, SIGILL,
> > +				=C2=A0=C2=A0=C2=A0 (unsigned long)&sa, 0, sizeof(sa.sa_mask));
> > +		if (res !=3D 0)
> > +			stub_syscall1(__NR_exit, 18);
> > +
> > +		res =3D stub_syscall4(__NR_rt_sigaction, SIGFPE,
> > +				=C2=A0=C2=A0=C2=A0 (unsigned long)&sa, 0, sizeof(sa.sa_mask));
> > +		if (res !=3D 0)
> > +			stub_syscall1(__NR_exit, 19);
> > +	}
> > +
> > +	/*
> > +	 * If in seccomp mode, install the SECCOMP filter and trigger a sysca=
ll.
> > +	 * Otherwise set PTRACE_TRACEME and do a SIGSTOP.
> > +	 */
> > +	if (init_data.seccomp) {
> > +		struct sock_filter filter[] =3D {
> > +#if __BITS_PER_LONG > 32
> > +			/* [0] Load upper 32bit of instruction pointer from seccomp_data */
> > +			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
> > +				 (offsetof(struct seccomp_data, instruction_pointer) + 4)),
> > +
> > +			/* [1] Jump forward 3 instructions if the upper address is not iden=
tical */
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, (init_data.stub_start) >> 32, 0=
, 3),
> > +#endif
> > +			/* [2] Load lower 32bit of instruction pointer from seccomp_data */
> > +			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
> > +				 (offsetof(struct seccomp_data, instruction_pointer))),
> > +
> > +			/* [3] Mask out lower bits */
> > +			BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xfffff000),
> > +
> > +			/* [4] Jump to [6] if the lower bits are not on the expected page *=
/
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, (init_data.stub_start) & 0xffff=
f000, 1, 0),
> > +
> > +			/* [5] Trap call, allow */
> > +			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_TRAP),
> > +
> > +			/* [6,7] Check architecture */
> > +			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
> > +				 offsetof(struct seccomp_data, arch)),
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,
> > +				 UM_SECCOMP_ARCH_NATIVE, 1, 0),
> > +
> > +			/* [8] Kill (for architecture check) */
> > +			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
> > +
> > +			/* [9] Load syscall number */
> > +			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
> > +				 offsetof(struct seccomp_data, nr)),
> > +
> > +			/* [10-14] Check against permitted syscalls */
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_futex,
> > +				 5, 0),
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, STUB_MMAP_NR,
> > +				 4, 0),
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_munmap,
> > +				 3, 0),
> > +#ifdef __i386__
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_set_thread_area,
> > +				 2, 0),
> > +#else
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_arch_prctl,
> > +				 2, 0),
> > +#endif
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_rt_sigreturn,
> > +				 1, 0),
>=20
> I was trying to understand what you mean 'permitted syscalls' here.
> Is this a list of syscall used by UML itself, or something else ?
>=20
> and should the list be maintained/updated if UML expands the permitted
> syscalls ?

"permitted" are the legitimate syscalls that the stub code needs. So
yes, this is what UML itself uses (see "stub_signal_interrupt"). The
userspace process itself is not allowed to do any host syscalls.

> > +			/* [15] Not one of the permitted syscalls */
> > +			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
> > +
> > +			/* [16] Permitted call for the stub */
> > +			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
> > +		};
> > +		struct sock_fprog prog =3D {
> > +			.len =3D sizeof(filter) / sizeof(filter[0]),
> > +			.filter =3D filter,
> > +		};
> > +
> > +		if (stub_syscall3(__NR_seccomp, SECCOMP_SET_MODE_FILTER,
> > +				=C2=A0 SECCOMP_FILTER_FLAG_TSYNC,
> > +				=C2=A0 (unsigned long)&prog) !=3D 0)
> > +			stub_syscall1(__NR_exit, 20);
> > =C2=A0
> > -	stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
> > +		/* Fall through, the exit syscall will cause SIGSYS */
> > +	} else {
> > +		stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
> > =C2=A0
> > -	stub_syscall2(__NR_kill, stub_syscall0(__NR_getpid), SIGSTOP);
> > +		stub_syscall2(__NR_kill, stub_syscall0(__NR_getpid), SIGSTOP);
> > +	}
> > =C2=A0
> > -	stub_syscall1(__NR_exit, 14);
> > +	stub_syscall1(__NR_exit, 30);
> > =C2=A0
> > =C2=A0	__builtin_unreachable();
> > =C2=A0}
>=20
> I was thinking that if I can clean up (or share) the seccomp filter
> code of nommu UML with this, but it is not likely as the memory layout
> is different.=C2=A0 I would think that the detection part might be useful
> as well for nommu.

I would guess there is not much overlap. You might also need a 64 bit
pointer comparison to check which memory range the code is in, but that
is probably about it.

Benjamin

