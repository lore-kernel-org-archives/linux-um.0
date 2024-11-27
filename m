Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C132D609C1
	for <linux-um@archiver.kernel.org>; Wed, 27 Nov 2024 10:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IEvNyAYks0AMQbCVMoEqNUfUt4d+cek6xNEkPiUJc4I=; b=GN/qb3h8wizO8EYBj0WMWQNzTu
	bannbL8DdDupkPOQzzsLdE0iJrxE9n4z74dRHuAdYjOu/yWmncKLCYRG7eGIngT/dzMMwK4NCfPTb
	rgvQLCMcRMm4h/ZaAEZp0H8l5vjIChzXFRtkgyqIWZ2W2Nifwv5qpeeJs8y9s8eLVD2o5D8A+kc6G
	bOGvdowoPCy7kuM9xxHyrZDooDGEXUFghuOk0g7ZBEjfMxxf9GhPSvzooGQvZlALSbHboBD3IeUrV
	Taoyd2ZYPhiSpbfNhK3IxaOPQeoAdQsH42EARDL2eDkJVdv6QC2hVSIaneQEu1FMSzwQ2U8KIID+t
	6TqWXZGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGEqN-0000000ClLc-38jo;
	Wed, 27 Nov 2024 10:00:23 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGEqL-0000000ClKN-0svB
	for linux-um@lists.infradead.org;
	Wed, 27 Nov 2024 10:00:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IEvNyAYks0AMQbCVMoEqNUfUt4d+cek6xNEkPiUJc4I=;
	t=1732701618; x=1733911218; b=qdyAqmp4RCGhWU0XW7rPxwpxzyNNqiWUzQP68G361X53yhp
	KgHpd3FlzBFEfaoemfnAccLPBnxJ8lJI7TsVZZvs37lFFy6JZIiRNlDfAu6lDbEaPJbjfkxlFMpsz
	NjnaUejYxmVZbcxkvtL+Ba3L3pREXZ+eFAg5flqj2z1VoSLr7h2wTGtlIOVMW6nqC7FLlHCoAMt0N
	jQVVfqkHox8tkdNjPqS534LPturfAbjhfWaCzk3/Iqba2PANjyyMRRhSKyaGSzVYJnGswUgcxkWQx
	79J1EFJIFtfxTbylu+32cJ9Fzn8drfO/UgwBDSHrnhJ+iPyyuVvbUGAxVddGYgPA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tGEqF-0000000GXmD-0Ank;
	Wed, 27 Nov 2024 11:00:15 +0100
Message-ID: <10522b8bd09c5900164692281cce47fef5bd6be8.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 08/13] um: nommu: configure fs register on host
 syscall invocation
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com
Date: Wed, 27 Nov 2024 11:00:11 +0100
In-Reply-To: <894d17f7924e7d31bfd5d6595ee84158f7411e47.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
	 <894d17f7924e7d31bfd5d6595ee84158f7411e47.1731290567.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_020021_255155_ED73B9DF 
X-CRM114-Status: GOOD (  25.26  )
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

On Mon, 2024-11-11 at 15:27 +0900, Hajime Tazaki wrote:
> As userspace on UML/!MMU also need to configure %fs register when it is
> running to correctly access thread structure, host syscalls implemented
> in os-Linux drivers may be puzzled when they are called.=C2=A0 Thus it ha=
s to
> configure %fs register via arch_prctl(SET_FS) on every host syscalls.
>=20
> [SNIP]
> +
> +/**
> + * get_host_cpu_features() return true with X86_FEATURE_FSGSBASE even
> + * if the kernel is older and disabled using fsgsbase instruction.
> + * thus detection is based on whether SIGILL is raised or not.
> + */
> +static jmp_buf jmpbuf;
> +static void sigill(int sig, siginfo_t *si, void *ctx_void)
> +{
> +	siglongjmp(jmpbuf, 1);
> +}
> +
> +void __init check_fsgsbase(void)
> +{
> +	unsigned long fsbase;
> +	struct sigaction sa;
> +
> +	/* Probe FSGSBASE */
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_sigaction =3D sigill;
> +	sa.sa_flags =3D SA_SIGINFO | SA_RESETHAND;
> +	sigemptyset(&sa.sa_mask);
> +	if (sigaction(SIGILL, &sa, 0))
> +		os_warn("sigaction");
> +
> +	os_info("Checking FSGSBASE instructions...");
> +	if (sigsetjmp(jmpbuf, 0) =3D=3D 0) {
> +		asm volatile("rdfsbase %0" : "=3Dr" (fsbase) :: "memory");
> +		host_has_fsgsbase =3D 1;
> +		os_info("OK\n");
> +	} else {
> +		host_has_fsgsbase =3D 0;
> +		os_info("disabled\n");
> +	}
> +}

According to Documentation/arch/x86/x86_64/fsgs.rst it looks like this
can also be checked using the HWCAP2_FSGSBASE bit in AT_HWCAP2.

Maybe that is a bit simpler?

> [SNIP]
>=20
> =C2=A0__visible void do_syscall_64(struct pt_regs *regs)
> =C2=A0{
> =C2=A0	int syscall;
> @@ -49,6 +76,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
> =C2=A0	if (syscall =3D=3D __NR_vfork)
> =C2=A0		stack_copy =3D vfork_save_stack();
> =C2=A0
> +	/* set fs register to the original host one */
> +	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
> +
> =C2=A0	if (likely(syscall < NR_syscalls)) {
> =C2=A0		PT_REGS_SET_SYSCALL_RETURN(regs,
> =C2=A0				EXECUTE_SYSCALL(syscall, regs));
> @@ -63,6 +93,11 @@ __visible void do_syscall_64(struct pt_regs *regs)
> =C2=A0	set_thread_flag(TIF_SIGPENDING);
> =C2=A0	interrupt_end();
> =C2=A0
> +	/* restore back fs register to userspace configured one */
> +	os_x86_arch_prctl(0, ARCH_SET_FS,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void *)(current->thread.regs.regs.gp[F=
S_BASE
> +						=C2=A0=C2=A0=C2=A0=C2=A0 / sizeof(unsigned long)]));
> +
> =C2=A0	/* execve succeeded */
> =C2=A0	if (syscall =3D=3D __NR_execve && regs->regs.gp[HOST_AX] =3D=3D 0)
> =C2=A0		userspace(&current->thread.regs.regs);
> diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
> index edb17fc73e07..d56df936a2d7 100644
> --- a/arch/x86/um/syscalls_64.c
> +++ b/arch/x86/um/syscalls_64.c
> @@ -12,11 +12,26 @@
> =C2=A0#include <asm/prctl.h> /* XXX This should get the constants from li=
bc */
> =C2=A0#include <registers.h>
> =C2=A0#include <os.h>
> +#include <asm/thread_info.h>
> +#include <asm/mman.h>
> +
> +#ifndef CONFIG_MMU
> +/*
> + * The guest libc can change FS, which confuses the host libc.
> + * In fact, changing FS directly is not supported (check
> + * man arch_prctl). So, whenever we make a host syscall,
> + * we should be changing FS to the original FS (not the
> + * one set by the guest libc). This original FS is stored
> + * in host_fs.
> + */
> +long long host_fs =3D -1;

Right, the libc already uses it for its own thread-local storage. That
is a bit annoying, as UML doesn't need threading in that sense.

Note that similar handling needs to happen for every userspace to
kernel switch. I guess the only other location is the signal handler.

Benjamin

> +#endif
> =C2=A0
> =C2=A0long arch_prctl(struct task_struct *task, int option,
> =C2=A0		unsigned long __user *arg2)
> =C2=A0{
> =C2=A0	long ret =3D -EINVAL;
> +#ifdef CONFIG_MMU
> =C2=A0
> =C2=A0	switch (option) {
> =C2=A0	case ARCH_SET_FS:
> @@ -38,6 +53,48 @@ long arch_prctl(struct task_struct *task, int option,
> =C2=A0	}
> =C2=A0
> =C2=A0	return ret;
> +#else
> +
> +	unsigned long *ptr =3D arg2, tmp;
> +
> +	switch (option) {
> +	case ARCH_SET_FS:
> +		if (host_fs =3D=3D -1)
> +			os_arch_prctl(0, ARCH_GET_FS, (void *)&host_fs);
> +		ret =3D 0;
> +		break;
> +	case ARCH_SET_GS:
> +		ret =3D 0;
> +		break;
> +	case ARCH_GET_FS:
> +	case ARCH_GET_GS:
> +		ptr =3D &tmp;
> +		break;
> +	}
> +
> +	ret =3D os_arch_prctl(0, option, ptr);
> +	if (ret)
> +		return ret;
> +
> +	switch (option) {
> +	case ARCH_SET_FS:
> +		current->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)] =3D
> +			(unsigned long) arg2;
> +		break;
> +	case ARCH_SET_GS:
> +		current->thread.regs.regs.gp[GS_BASE / sizeof(unsigned long)] =3D
> +			(unsigned long) arg2;
> +		break;
> +	case ARCH_GET_FS:
> +		ret =3D put_user(current->thread.regs.regs.gp[FS_BASE / sizeof(unsigne=
d long)], arg2);
> +		break;
> +	case ARCH_GET_GS:
> +		ret =3D put_user(current->thread.regs.regs.gp[GS_BASE / sizeof(unsigne=
d long)], arg2);
> +		break;
> +	}
> +
> +	return ret;
> +#endif
> =C2=A0}
> =C2=A0
> =C2=A0SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)


