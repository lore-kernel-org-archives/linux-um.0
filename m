Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62B9CDB46F
	for <linux-um@archiver.kernel.org>; Mon, 22 Jun 2026 12:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5fES3RNV3CWXsNhn1djAZTH/TuiReSKc/dZ7IobNbdA=; b=sKwmfF9cBm456SC+jZKKUDdbe7
	w+0mrYoh5jpQGK4M9EEWD2i/GD3y5kpGJiJU8OK8celS8TPQDIGO20IwjHBLic5dEUrHx+mckG0g3
	99Wgr+Ltu193fcoZbY5kAGE9dI8nTdAa8jlGbwl92yBYKyTaeBBB7i0SUWqCYpgArxBQVQMyXukWF
	MNw3tebwy957Vllqsg1lMC1TquJcST8xEisjhXLr38fdwYgMNg4/c7oKdV/giWfpAdD0elA4hvMFW
	Kdj7w5XN2JkLx/uChwcVYcS6XhQeLQqMH6Z+YsQ0dR2+PmRmwJfdy+nlz5V5R8ou24w2bdEMp4Ne/
	OzAJrGow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbdS6-00000004x5l-1SYq;
	Mon, 22 Jun 2026 12:08:34 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbdS2-00000004x5A-0jIl
	for linux-um@lists.infradead.org;
	Mon, 22 Jun 2026 12:08:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5fES3RNV3CWXsNhn1djAZTH/TuiReSKc/dZ7IobNbdA=;
	t=1782130110; x=1783339710; b=NGxhduvCSb978dHGaULQn1SrE2t10Fugy+2/n79SQcSxKbX
	e5e7Ggsk/q6kLMD1XCKjYz2ADIClSBpMQWOe6zaVzS8l5JUdRI0REj6bSctHiSNKC/6GPEIoAPTs+
	H9AE1e877Uzc6OAHHPILlFC06T7Sibz73oLogIs6FfHIstv5d4upQ+5cgP4iENs0k1RXtWLr4jEO/
	nZ1LdLKcaEvAxzXm9TOdmi+IryYomhVsUe65ZE4x/oNn/0v/kF15wA+czJ1qicPu5TIR4+FNZBOtH
	IJe5WX2Jm+FomCfPZaomtNZyRG08tzHTbtzCZDolzLIrjWjX2a9GWQDO9P9qeXHw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1wbdRu-0000000CY8F-16dw;
	Mon, 22 Jun 2026 14:08:22 +0200
Message-ID: <1e1681eecfa5dd30181534674b1a17756df802f8.camel@sipsolutions.net>
Subject: Re: [PATCH 0/7] um: skas: harden the seccomp userspace stub
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Cong Wang <xiyou.wangcong@gmail.com>, Richard Weinberger
 <richard@nod.at>,  Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, 	linux-um@lists.infradead.org
Date: Mon, 22 Jun 2026 14:08:21 +0200
In-Reply-To: <cover.1781925126.git.xiyou.wangcong@gmail.com>
References: <cover.1781925126.git.xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_050830_244578_A5375390 
X-CRM114-Status: GOOD (  20.39  )
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

On Fri, 2026-06-19 at 20:22 -0700, Cong Wang wrote:
> From: Cong Wang <cwang@multikernel.io>
>=20
> In the seccomp ("SECCOMP") userspace mode, each guest userspace process
> runs in a stub under a seccomp filter and traps to the monitor (the UML
> kernel) on every syscall. Two items on the stub.c "Known security issues"
> list could not be addressed by the filter alone:
>=20
> =C2=A0 - a hijacked stub could mmap() arbitrary physmem offsets, which is=
 an
> =C2=A0=C2=A0=C2=A0 intra-guest disclosure and, on this base (single physm=
em fd, no
> =C2=A0=C2=A0=C2=A0 kernel/user split), a host escape; and
>=20
> =C2=A0 - a hijacked stub could block SIGALRM via a crafted rt_sigreturn t=
o
> =C2=A0=C2=A0=C2=A0 evade preemption and wedge the monitor indefinitely.
>=20
> This series closes both:
>=20
> =C2=A0 1-2: route the stub's mmap() through a SECCOMP_RET_USER_NOTIF list=
ener
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 owned by the monitor (no behavioural=
 change yet).
> =C2=A0 3-4: validate each mmap() against the mm's page table -- allowed i=
ff the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PTE already maps the requested frame=
 with no more access than it
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 grants -- including out-of-batch mma=
ps a hijacked stub issues on
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 its own.
> =C2=A0 5:=C2=A0=C2=A0 route and validate munmap() the same way (range-con=
fined below
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STUB_START).


That approach seems odd to me. Adding an explicit out-of-band check
means you require two extra context switches per mmap syscall. I would
expect that this makes the SECCOMP approach a lot slower than ptrace().
My take is still that it is possible to carefully craft a SECCOMP
filter as well as stub/kernel code that makes exploitation impossible
for non-SMP.

The true SMP case is more complicated, but we do not have that anyway,
so I would not worry about it for now.

Did you run any performance tests?

> =C2=A0 6:=C2=A0=C2=A0 add a watchdog thread that detects a stub which sto=
ps reporting
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 back (e.g. blocked SIGALRM) and SIGK=
ILLs it, letting the monitor
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 recover via the existing teardown.

That also seems like an odd solution to me. Architecturally, UML first
receives the SIGALRM and forwards it to the child. It would seem much
easier to set a flag and clear it again when the process reports back
that it received the SIGALRM. Then, when the kernel receives the next
SIGALRM, just kill the child immediately if the flag is still set.

> =C2=A0 7:=C2=A0=C2=A0 drop the now-resolved "Known security issues" note =
and refresh the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seccomp=3D help text.


Benjamin

> After the series a hijacked stub is confined to the frames its own page
> tables reference and can no longer reach arbitrary guest/host memory; one
> that evades preemption is detected out of band and killed rather than
> wedging the monitor.
>=20
> Verified on UML (UP and 2-CPU SMP): boots and survives fork/exec storms
> and heavy mmap/munmap churn with zero false denials or false kills; an
> artificially SIGALRM-blocked busy loop is killed in ~5s and the monitor
> recovers, while syscall-making processes are untouched. Each patch builds
> and the series is bisectable.
>=20
> ---
> Cong Wang (7):
> =C2=A0 um: skas: create a seccomp USER_NOTIF listener and hand it to the
> =C2=A0=C2=A0=C2=A0 monitor
> =C2=A0 um: skas: gate stub mmap() through the USER_NOTIF monitor
> =C2=A0 um: skas: validate stub mmap() against the guest page table
> =C2=A0 um: skas: handle out-of-batch stub mmap notifications
> =C2=A0 um: skas: validate stub munmap() against the guest address range
> =C2=A0 um: skas: kill stubs that block SIGALRM via a watchdog thread
> =C2=A0 um: skas: refresh stub security notes after closing the known issu=
es
>=20
> =C2=A0arch/um/include/shared/skas/mm_id.h |=C2=A0=C2=A0 1 +
> =C2=A0arch/um/include/shared/skas/skas.h=C2=A0 |=C2=A0=C2=A0 5 +
> =C2=A0arch/um/kernel/skas/stub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 22 --
> =C2=A0arch/um/kernel/skas/stub_exe.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 19 +-
> =C2=A0arch/um/kernel/skas/uaccess.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 48 +++++
> =C2=A0arch/um/os-Linux/skas/process.c=C2=A0=C2=A0=C2=A0=C2=A0 | 315 +++++=
+++++++++++++++++++----
> =C2=A0arch/um/os-Linux/start_up.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 6 -
> =C2=A07 files changed, 344 insertions(+), 72 deletions(-)
>=20
>=20
> base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1

