Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09127CF11E2
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 12:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MMFSdssYTW+4NNyjS0814kyorBaE/aOEf2w/qKFhX5Y=; b=EchwpLbmh+shCfpFohLk17Cy3p
	PnW9LZkh48AD10Q/XHmTv/+7iHy1y6SzB1sJm3r0MG1j3Cwr8vajuIOy0wZrLJtNkzE5ENx9K7OJN
	VGGeKBw6MMG0VGVCvQAeP+ieSM/Pg+aHoIBcce4G7vVOWkTOwtjbE8L8honBrRcIH85oWPxaT19oj
	hWk1jY9Cht+Vh+KT3h3U7P7EK78Sc8GXN32V8a8mUA7ojjJkKY+xqt3+Nvy9So1ta4Kxum0B1lWF3
	PkUHXq9+gZ160mewQrbD9Z5APlUfg6g4ZAsoetgtmH9HdEUdDazcDjvo2QwYOpuw56rhSHY9Ru7ib
	caZcoOjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sysWF-0000000ClMF-2v5J;
	Thu, 10 Oct 2024 12:43:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sysF6-0000000ChmM-3v6O
	for linux-um@bombadil.infradead.org;
	Thu, 10 Oct 2024 12:26:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=MMFSdssYTW+4NNyjS0814kyorBaE/aOEf2w/qKFhX5Y=; b=LU00/qimNH+P0f1KxNJ8390Duy
	awgn0ZKnP1dlzgULTmn4Z0OCaF1rXu45Cu2tiAPc8900wZOc/8CRq5z0L6eSkMvgQ0Z++4ys2GDEL
	i7QdEtrf2WxFaUpaOMidHZZI/WsECnf+KLaxcrFK3MDrlGsH2xVz5BkTF1V21/iXU7WCR9f/LvWRY
	Si7KFjC8K86msSpvucKYeeWHEThgMHfCXN/8ttAUroSnE0PNXS5IyC2hSLy2SYo72wmoSXqNhAJKT
	wWAgMZLbbL86Jh0uzYQ7tmwh+M4zmKNqH+Nq1LpoQT2+/wPXWfR8AL64jyoEIKT3Z13ldypU4FLDq
	wKlsmYsA==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sysF1-00000005NVh-2VNu
	for linux-um@lists.infradead.org;
	Thu, 10 Oct 2024 12:26:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MMFSdssYTW+4NNyjS0814kyorBaE/aOEf2w/qKFhX5Y=;
	t=1728563161; x=1729772761; b=sDvcnNpGPKPOp4/A3K9cOm2jakcpcRd0ezzZAaXIhVSDl1O
	atBhAjkGf203LnrFnF+vbN/snh/qAG9P6RimE4YfdNCG+NApatADhabBWideY4TFsZSTEicd/6slg
	D1BZY44VhCCZNVQn+RcAjYEKA591QjBHdSIszZ+/HsSt4KFBGWROIHFfuUhgCmAjtBfQZ4jwcJ26M
	aieB4BQursW3QUt6xqtNrppoE28RVVMRphrvOKgdtIMH0VZEFahE/oadw5+0mmUIyjzsZaLr1UXxU
	KYPxxsR/reDNky35i9wmZoVAMVAVQlch+h3PIVFoZ946kH2OMhWo0T9eIoJlajXg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sysEw-0000000652Z-0CHM;
	Thu, 10 Oct 2024 14:25:58 +0200
Message-ID: <c0796b351a640f1d65ae5c28774f3e77e358e1fa.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 8/9] um: Implement kernel side of SECCOMP based
 process handling
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Date: Thu, 10 Oct 2024 14:25:55 +0200
In-Reply-To: <590b1ea94cd8166dde2230e8aa8c80045f30cfe4.camel@sipsolutions.net>
References: <20240925203232.565086-1-benjamin@sipsolutions.net>
	 <20240925203232.565086-9-benjamin@sipsolutions.net>
	 <590b1ea94cd8166dde2230e8aa8c80045f30cfe4.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_132603_710022_84BC7D0F 
X-CRM114-Status: GOOD (  34.59  )
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

On Thu, 2024-10-10 at 14:12 +0200, Johannes Berg wrote:
> On Wed, 2024-09-25 at 22:32 +0200, Benjamin Berg wrote:
> >=20
> > +	/*
> > +	 * If in seccomp mode, install the SECCOMP filter and
> > trigger a syscall.
> > +	 * Otherwise set PTRACE_TRACEME and do a SIGSTOP.
> > +	 */
> > +	if (init_data.seccomp) {
> > +		struct sock_filter filter[] =3D {
> > +#if __BITS_PER_LONG > 32
> > +			/* [0] Load upper 32bit of instruction
> > pointer from seccomp_data */
> > +			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
> > +				 (offsetof(struct seccomp_data,
> > instruction_pointer) + 4)),
> > +
> > +			/* [1] Jump forward 3 instructions if the
> > upper address is not identical */
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,
> > (init_data.stub_start) >> 32, 0, 3),
> > +#endif
> > +			/* [2] Load lower 32bit of instruction
> > pointer from seccomp_data */
> > +			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
> > +				 (offsetof(struct seccomp_data,
> > instruction_pointer))),
> > +
> > +			/* [3] Mask out lower bits */
> > +			BPF_STMT(BPF_ALU | BPF_AND | BPF_K,
> > 0xfffff000),
> > +
> > +			/* [4] Jump to [6] if the lower bits are
> > not on the expected page */
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,
> > (init_data.stub_start) & 0xfffff000, 1, 0),
> > +
> > +			/* [5] Trap call, allow */
> > +			BPF_STMT(BPF_RET | BPF_K,
> > SECCOMP_RET_TRAP),
> > +
> > +			/* [6,7] Check architecture */
> > +			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
> > +				 offsetof(struct seccomp_data,
> > arch)),
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,
> > +				 UM_SECCOMP_ARCH_NATIVE, 1, 0),
> > +
> > +			/* [8] Kill (for architecture check) */
> > +			BPF_STMT(BPF_RET | BPF_K,
> > SECCOMP_RET_KILL_PROCESS),
> > +
> > +			/* [9] Load syscall number */
> > +			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
> > +				 offsetof(struct seccomp_data,
> > nr)),
> > +
> > +			/* [10-14] Check against permitted
> > syscalls */
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,
> > __NR_futex,
> > +				 5, 0),
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,
> > STUB_MMAP_NR,
> > +				 4, 0),
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,
> > __NR_munmap,
> > +				 3, 0),
> > +#ifdef __i386__
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,
> > __NR_set_thread_area,
> > +				 2, 0),
> > +#else
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,
> > __NR_arch_prctl,
> > +				 2, 0),
> > +#endif
> > +			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,
> > __NR_rt_sigreturn,
> > +				 1, 0),
> > +
> > +			/* [15] Not one of the permitted syscalls
> > */
> > +			BPF_STMT(BPF_RET | BPF_K,
> > SECCOMP_RET_KILL_PROCESS),
> > +
> > +			/* [16] Permitted call for the stub */
> > +			BPF_STMT(BPF_RET | BPF_K,
> > SECCOMP_RET_ALLOW),
> > +		};
>=20
> So not sure, but what else would you need per the cover letter's
> description that it's not complete for the filter?

I think it'll become clear with the next patch.

The problem is that you can just jump to the address of the
rt_sigreturn syscall instruction with any stack/registers/stub data.
That is really convenient, as there is even a "ret" instruction right
afterwards.

So, you then just trick the kernel into thinking you legitimately need
to pagefault some new page to retrieve the FD and you are then free to
map any physical memory at that point.

It should be possible to prevent that by nailing down the instruction
for the recvmsg syscall and probably others. And also adding some
strategic sanity checks and trap instructions.

> > =C2=A0 * skas/process.c
> > =C2=A0 */
> > =C2=A0void wait_stub_done(int pid);
> > +void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int
> > wait_sigsys);
> > +
>=20
> nit: extra newline
>=20
> Also the function can be static?
>=20
> > +++ b/arch/um/os-Linux/skas/process.c
> > @@ -1,9 +1,11 @@
> > =C2=A0// SPDX-License-Identifier: GPL-2.0
> > =C2=A0/*
> > + * Copyright (C) 2021 Benjamin Berg <benjamin@sipsolutions.net>
> > =C2=A0 * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
> > =C2=A0 * Copyright (C) 2002- 2007 Jeff Dike
> > (jdike@{addtoit,linux.intel}.com)
> > =C2=A0 */
> > =C2=A0
> > +#include <linux/kconfig.h>
>=20
> Hmm. If this works, why do we have UML_CONFIG_64BIT? For ASM stuff?
>=20
> But you also use "using_seccomp" so this shouldn't be needed, or you've
> set it up very dangerously - that header file should probably include
> this then, or whatever is needed?
>=20
> Otherwise could end up with using_seccomp being used but not defined
> properly per the ifdef, and just be statically 0 anyway?

Hmm, I guess I need to check why I needed that.

> > =C2=A0#include <stdlib.h>
> > =C2=A0#include <stdbool.h>
> > =C2=A0#include <unistd.h>
> > @@ -25,8 +27,11 @@
> > =C2=A0#include <registers.h>
> > =C2=A0#include <skas.h>
> > =C2=A0#include <sysdep/stub.h>
> > +#include <sysdep/mcontext.h>
> > +#include <linux/futex.h>
> > =C2=A0#include <linux/threads.h>
> > =C2=A0#include <timetravel.h>
> > +#include <asm-generic/rwonce.h>
> > =C2=A0#include "../internal.h"
> > =C2=A0
> > =C2=A0int is_skas_winch(int pid, int fd, void *data)
> > @@ -142,6 +147,74 @@ void wait_stub_done(int pid)
> > =C2=A0	fatal_sigsegv();
> > =C2=A0}
> > =C2=A0
> > +#ifdef CONFIG_UML_SECCOMP
>=20
> Also not sure you need the ifdef at all?
>=20
> > +void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int
> > wait_sigsys)
>=20
> This could be static and then it doesn't matter to have the ifdef?
>=20
> > -		CATCH_EINTR(n =3D waitpid(pid, &status, WUNTRACED |
> > __WALL));
> > -		if (n < 0) {
> > +	if (using_seccomp) {
> > +		wait_stub_done_seccomp(mm_id, 1, 1);
>=20
> Also this builds because you declare the function but don't define it,
> but you already rely on the optimisation throwing it out anyway.
>=20
> > +#ifdef CONFIG_X86_32
> > +		extern int have_fpx_regs;
> > +
> > +		/*
> > +		 * FIXME: This is wrong, but the non-FPX layout is
> > closer to
> > +		 * what the mcontext presents to us. So, for all
> > intents and
> > +		 * purposes we'll behave mostly correct if we do
> > this.
>=20
> "correctly"
>=20
> but you don't care anyway since seccomp is only for 64-bit?

Not anymore, this patchset actually works fine on i386.

How else am I going to convince people to drop ptrace support ;-)

Benjamin

