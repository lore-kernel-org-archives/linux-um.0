Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CDFC43458
	for <linux-um@archiver.kernel.org>; Sat, 27 Jun 2026 16:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pqs/ye2kXwxgJDCxnwtvFqZZnhC3gp8cMlEAEpWw8AE=; b=dJR2woa/WEjRiVniwnQMtuWLrx
	DRTSZ6Zk5FoRlhFMXeLKewC4bN+RnFmbI89ZZDnVoVGPllPl50sDZzCm45SvacHC86BzqXVoEagq1
	EMp7iXhKUkM7mgN+ctmJZvY4rXIFdc+Zouh+G5UX63zmE4uOpkEwJ31pFiBk8uKD6h7WTX6jSwDlt
	ois61uFdXEsuuR0HCWzlA1FbhxgBCBaZd46kCslPHNp0Qc6IO5uEfUioU32366ucfcoOOFNfqOA0T
	HCReYjbEF28tBh7wqVPhbTlHCDINS2+oGGhNA9I+RwDtNf3Z3Bf/K9MjND+4prwlmJnoOPUu+1PIi
	CSI/eucw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdVn6-0000000Cd8U-0jJW;
	Sat, 27 Jun 2026 16:22:00 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdVn1-0000000Cd7z-3Ucj
	for linux-um@lists.infradead.org;
	Sat, 27 Jun 2026 16:21:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pqs/ye2kXwxgJDCxnwtvFqZZnhC3gp8cMlEAEpWw8AE=;
	t=1782577315; x=1783786915; b=a+R6UDaqK8Gidvyax/jH+l7EcG46wpqIWT6NFGZyN1SC0qA
	V+il4qMIG3XvK5tcFVKDEXbv7DWq/H/Kf+zaWwfyhxJDsMcQ3mHpxLG3mRU8wTQGvqe3zjo17NyBR
	VpFPjdVpf6bIh/PY+bWkY6Ccq0WXeWz+Y3UH2mj0UNHmdBQbrrijQvEyXuIARpuuzCPlIHzL5Z2Po
	f3B7Z+WnmVBUlqSpVuK2UubztOqRYTB0yj+utuOlLtJV4RZ7if1TuAf3nf7ImDzpRuQxmzSlfykDa
	GXqN/+tBZoJnC+1jZZ4K+cTzpKwOonLwZJHnMC2LbG2uQQVzYlmbWmn+TggL3AJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1wdVmp-0000000Abp7-0NHu;
	Sat, 27 Jun 2026 18:21:43 +0200
Message-ID: <c4bc735d4413410c6ff5c5011ebdf0fffe05866f.camel@sipsolutions.net>
Subject: Re: [PATCH 0/7] um: skas: harden the seccomp userspace stub
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov	
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, 	linux-um@lists.infradead.org
Date: Sat, 27 Jun 2026 18:21:41 +0200
In-Reply-To: <CAM_iQpUc4dQvYXbGpUgBXke+a8hVXnBCtjziXd1QX=QJXWiwjA@mail.gmail.com>
References: <cover.1781925126.git.xiyou.wangcong@gmail.com>
	 <1e1681eecfa5dd30181534674b1a17756df802f8.camel@sipsolutions.net>
	 <CAM_iQpWj+daY6tsPXKq=B4ekjr-8-tpfX+2twLhW_oGP_YqOHw@mail.gmail.com>
	 <03b2134eea62d664781069c8bd072705e0fc4aee.camel@sipsolutions.net>
	 <CAM_iQpUc4dQvYXbGpUgBXke+a8hVXnBCtjziXd1QX=QJXWiwjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260627_092156_027861_F18FF8A3 
X-CRM114-Status: GOOD (  59.08  )
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

On Wed, 2026-06-24 at 16:12 -0700, Cong Wang wrote:
> On Wed, Jun 24, 2026 at 12:54=E2=80=AFAM Benjamin Berg
> <benjamin@sipsolutions.net> wrote:
> >=20
> > On Tue, 2026-06-23 at 15:08 -0700, Cong Wang wrote:
> > > On Mon, Jun 22, 2026 at 5:08=E2=80=AFAM Benjamin Berg <benjamin@sipso=
lutions.net> wrote:
> > > >=20
> > > > On Fri, 2026-06-19 at 20:22 -0700, Cong Wang wrote:
> > > > > From: Cong Wang <cwang@multikernel.io>
> > > > >=20
> > > > > In the seccomp ("SECCOMP") userspace mode, each guest userspace p=
rocess
> > > > > runs in a stub under a seccomp filter and traps to the monitor (t=
he UML
> > > > > kernel) on every syscall. Two items on the stub.c "Known security=
 issues"
> > > > > list could not be addressed by the filter alone:
> > > > >=20
> > > > > =C2=A0 - a hijacked stub could mmap() arbitrary physmem offsets, =
which is an
> > > > > =C2=A0=C2=A0=C2=A0 intra-guest disclosure and, on this base (sing=
le physmem fd, no
> > > > > =C2=A0=C2=A0=C2=A0 kernel/user split), a host escape; and
> > > > >=20
> > > > > =C2=A0 - a hijacked stub could block SIGALRM via a crafted rt_sig=
return to
> > > > > =C2=A0=C2=A0=C2=A0 evade preemption and wedge the monitor indefin=
itely.
> > > > >=20
> > > > > This series closes both:
> > > > >=20
> > > > > =C2=A0 1-2: route the stub's mmap() through a SECCOMP_RET_USER_NO=
TIF listener
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 owned by the monitor (no beh=
avioural change yet).
> > > > > =C2=A0 3-4: validate each mmap() against the mm's page table -- a=
llowed iff the
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PTE already maps the request=
ed frame with no more access than it
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 grants -- including out-of-b=
atch mmaps a hijacked stub issues on
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 its own.
> > > > > =C2=A0 5:=C2=A0=C2=A0 route and validate munmap() the same way (r=
ange-confined below
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STUB_START).
> > > >=20
> > > >=20
> > > > That approach seems odd to me. Adding an explicit out-of-band check
> > > > means you require two extra context switches per mmap syscall. I wo=
uld
> > > > expect that this makes the SECCOMP approach a lot slower than ptrac=
e().
> > > > My take is still that it is possible to carefully craft a SECCOMP
> > > > filter as well as stub/kernel code that makes exploitation impossib=
le
> > > > for non-SMP.
> > > >=20
> > > > The true SMP case is more complicated, but we do not have that anyw=
ay,
> > > > so I would not worry about it for now.
> > > >=20
> > > > Did you run any performance tests?
> > >=20
> > > Sorry, I thought I included them in patch 4/7, but I missed them.
> > >=20
> > > Here they are:
> > >=20
> > > mmap() -- ns/call
> > > -----------------
> > > size=C2=A0=C2=A0 WITH med=C2=A0=C2=A0 WITHOUT med=C2=A0=C2=A0 delta=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WITH p99=
=C2=A0=C2=A0 WITHOUT p99
> > > 4K=C2=A0=C2=A0=C2=A0=C2=A0 13056=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10368=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2688=C2=A0 (+26%)=C2=A0=
=C2=A0=C2=A0=C2=A0 17408=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15104
> > > 16K=C2=A0=C2=A0=C2=A0 13824=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11008=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2816=C2=A0 (+26%)=C2=A0=C2=A0=
=C2=A0=C2=A0 15616=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12544
> > > 64K=C2=A0=C2=A0=C2=A0 19840=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15616=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +4224=C2=A0 (+27%)=C2=A0=C2=A0=
=C2=A0=C2=A0 21760=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 17408
> > > 256K=C2=A0=C2=A0 33152=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 28928=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +4224=C2=A0 (+15%)=C2=A0=C2=A0=C2=
=A0=C2=A0 36352=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 31744
> > > 1M=C2=A0=C2=A0=C2=A0=C2=A0 95616=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 84608=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +11008 (+13%)=C2=A0=C2=A0=
=C2=A0=C2=A0 117504=C2=A0=C2=A0=C2=A0=C2=A0 108032
> > >=20
> > > munmap() -- ns/call
> > > -------------------
> > > size=C2=A0=C2=A0 WITH med=C2=A0=C2=A0 WITHOUT med=C2=A0=C2=A0 delta=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WITH p99=
=C2=A0=C2=A0 WITHOUT p99
> > > 4K=C2=A0=C2=A0=C2=A0=C2=A0 11008=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8448=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2560=C2=A0 (+30%)=
=C2=A0=C2=A0=C2=A0=C2=A0 13568=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11264
> > > 16K=C2=A0=C2=A0=C2=A0 10752=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8448=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2304=C2=A0 (+27%)=C2=A0=
=C2=A0=C2=A0=C2=A0 12288=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9472
> > > 64K=C2=A0=C2=A0=C2=A0 12032=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9728=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2304=C2=A0 (+24%)=C2=A0=
=C2=A0=C2=A0=C2=A0 13824=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10752
> > > 256K=C2=A0=C2=A0 15360=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12800=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2560=C2=A0 (+20%)=C2=A0=C2=A0=C2=
=A0=C2=A0 17152=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14592
> > > 1M=C2=A0=C2=A0=C2=A0=C2=A0 27648=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24832=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2816=C2=A0 (+11%)=C2=A0=
=C2=A0=C2=A0=C2=A0 30976=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26880
> > >=20
> > > Since this is a clear security-vs-performance balance, I picked secur=
ity
> > > over performance. Please let me know if you prefer otherwise.
> >=20
> > So, I still believe that (almost) zero-overhead is possible in the
> > current framework. Maybe one could add a non-zero overhead option, but
> > then I would like to be able to disable it as there are plenty of
> > scenarios where security is of no concern.
>=20
> This is fair, I can add an option to keep it disabled by default.

Sure. But I still think that a discussion is needed on whether another
option is viable. I would really prefer not adding your proposed
solution if another low/zero overhead option is viable.

And I still absolutely believe that it is viable to modify the current
code and make it secure. I just never finished that work because it
requires a lot of care and it is not that important to us.

> > Also, I am unsure what you measured there. When you write "mmap" here,
> > is that an "mmap" call made by the userspace process (which might not
> > actually change the page mappings), or is that an "mmap" call that was
> > queued for the stub to process?
> >=20
> > A large amount of the overhead that UML tends to have happens when
> > handling both minor and major page faults. Simple tests for this is for
> > example a relatively tight fork/exec loop or just applications starting
> > up. In our test runs, we saw major speed improvements (>10%) just by
> > fixing bugs in the TLB handling code that resulted in fewer page faults
> > happening at application runtime.
>=20
> It is just a simple user-space mmap() loop just for benchmarking this
> patchset.

If you just say "mmap() loop" I think that you are purely doing an
mmap/unmap syscall of anonymous memory in a loop. However, the kernel
may not map any of those pages until they are actually accessed. I
would not have been surprised if you did not see any performance
difference at all in such a test.

Are you actually touching (writing) each of the mapped pages?

> > > Meanwhile, after a second thought, there is a zero-overhead solution.
> > > pidfd_mmap(), which can be built on top of another patch of mine:
> > > https://lore.kernel.org/all/20260613001533.314739-2-xiyou.wangcong@gm=
ail.com/
> >=20
> > Sure, should some sort of method land that allows directly modifying
> > the mappings of the remote process, that would be rather convenient.
> >=20
>=20
> Great. I will work on it. One question: should I drop this one or we can =
use
> this one as the short term solution before the pidfd_mmap() solution gets=
 in?
> Even if we had pidfd_mmap(), UML might still want to keep compatibility w=
ith
> older host kernels?

Of course, UML should not regress on older kernels. Also, any new API
like that will probably still take a while. That said, I am not sure
there is a pressing need to fix the security problem as long as we have
ptrace mode available.

>=20
> > > Something like:
> > >=20
> > > int map(struct mm_id *mm_idp, unsigned long virt, unsigned long len, =
int prot,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int phys_fd, unsigned long=
 long offset)
> > > {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return pidfd_mmap(mm_idp->=
stub_pidfd, (void *)virt, len,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 prot_to_mmap(prot), MAP_FIXED | MAP_SHARED,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 phys_fd, offset);
> > > }
> > > int unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len=
)
> > > {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return pidfd_munmap(mm_idp=
->stub_pidfd, (void *)addr, len);
> > > }
> > >=20
> > > Obviously, this one requires a new syscall for the host kernel first.
> > >=20
> > > >=20
> > > > > =C2=A0 6:=C2=A0=C2=A0 add a watchdog thread that detects a stub w=
hich stops reporting
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 back (e.g. blocked SIGALRM) =
and SIGKILLs it, letting the monitor
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 recover via the existing tea=
rdown.
> > > >=20
> > > > That also seems like an odd solution to me. Architecturally, UML fi=
rst
> > > > receives the SIGALRM and forwards it to the child. It would seem mu=
ch
> > > > easier to set a flag and clear it again when the process reports ba=
ck
> > > > that it received the SIGALRM. Then, when the kernel receives the ne=
xt
> > > > SIGALRM, just kill the child immediately if the flag is still set.
> > >=20
> > > The flag-and-recheck scheme matches the ptrace path (wait_stub_done),=
 where
> > > the monitor is the tracer: it sees the stub's SIGALRM as a waitpid()
> > > signal-stop and PTRACE_CONTs it, so "monitor receives, then deals wit=
h the
> > > child" is accurate there. This patch is on the seccomp path
> > > (wait_stub_done_seccomp), which is architecturally different.
> > >=20
> > > Or am I missing anything?
> >=20
> > The fact that it is not actually different from an architectural
> > standpoint. In both cases SIGALRM is reported back to the kernel. It
> > obviously has to be reported back, otherwise scheduling would not work.
>=20
> You're right.
>=20
> In the seccomp path the monitor also receives the SIGALRM and
> forwards it to the stub: the per-vCPU POSIX timer targets the monitor thr=
ead
> and um_timer() -> os_alarm_process() -> kill(stub, SIGALRM) forwards
> the tick. ptrace vs. seccomp differ only in how the monitor
> learns the stub stopped (waitpid vs. futex), not in the point you raised.
>=20
> So the watchdog thread is redundant. The inner FUTEX_WAIT loop in
> wait_stub_done_seccomp already wakes on every forwarded tick via EINTR;
> responsive stub acks by flipping data->futex out of FUTEX_IN_CHILD, a
> SIGALRM-blocking one doesn't, exactly your flag scheme. I'll drop the hel=
per
> thread and timerfd and detect the stall inline: count consecutive ticks w=
here
> the stub didn't report and goto out_kill past a small threshold.

Not sure I follow and the description makes me wonder if it was written
by an LLM. To me it seems overly complicated and incorrect in subtle
ways.

Benjamin

