Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB9FCDB47F
	for <linux-um@archiver.kernel.org>; Wed, 24 Jun 2026 07:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j83tgyvEzMnKPxY7vqGnLBje/gilVk6K2jfsREn5Gcs=; b=DdoPOwiD6dLbERQfVVU6dZMHv9
	dOb5ekHWRNb/4PPPGi8A9KoUfEJFlzkMnZqVGhkX552szsygh8FL1YF50U/MxZ32v8hAMVQU+VW+Y
	VszXuI7YOruz58XAhqBgd7l8G+QPelkQA4EmKw4L7xICl8UZ0JTKzdmfGBfLFgUO4Sk1zaa/4TIhr
	MRu/1L3B3rIpTryGFcmKagSTwbpx3mTIv9H3xF/WsFNZlXh2zmMYaUw5yadUssQ+O9wXembIIyUqJ
	zEt2KUlAJufzjM83kX91G/AykuXNTdMnhw0QsmXpib61AxgK4jajWolqmMJBda48QCi+8SxB8/QC0
	A22cALvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcIRt-00000007M5x-28l0;
	Wed, 24 Jun 2026 07:55:05 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcIRp-00000007M4q-3i7q
	for linux-um@lists.infradead.org;
	Wed, 24 Jun 2026 07:55:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j83tgyvEzMnKPxY7vqGnLBje/gilVk6K2jfsREn5Gcs=;
	t=1782287701; x=1783497301; b=xi9kmuBI7zhOAA4ggAwkRkJfH4v0ykHxA553dpQ1xdgkHo9
	/orDuvcHdTspErtw2nIajLCViTlia+Q/wwymVBvRLCixIomlqHlChb0cfLq4Czk0M74S/Foe3NZHQ
	vRuK9ZKQaRzFiObHbWsPEzDyENqOhCmH1xARMzXiTjzSwmHkn0OuDTBovAHWRIRpZoQ/POnD3yrcD
	0qidK//xRPWLYqc9Fb4vi86cZXfFioJ353gXKCORjwe6VDrysEaJo0yOTop3ySD10yWYpSeJqPLdY
	CGVhUsrjEVPDex4vrRzGA8M2SnCiP03UrjvZ2umIg6adZyBeQANDZnBJghtGBVIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1wcIRe-0000000GXkZ-2T7V;
	Wed, 24 Jun 2026 09:54:50 +0200
Message-ID: <03b2134eea62d664781069c8bd072705e0fc4aee.camel@sipsolutions.net>
Subject: Re: [PATCH 0/7] um: skas: harden the seccomp userspace stub
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov	
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, 	linux-um@lists.infradead.org
Date: Wed, 24 Jun 2026 09:54:49 +0200
In-Reply-To: <CAM_iQpWj+daY6tsPXKq=B4ekjr-8-tpfX+2twLhW_oGP_YqOHw@mail.gmail.com>
References: <cover.1781925126.git.xiyou.wangcong@gmail.com>
	 <1e1681eecfa5dd30181534674b1a17756df802f8.camel@sipsolutions.net>
	 <CAM_iQpWj+daY6tsPXKq=B4ekjr-8-tpfX+2twLhW_oGP_YqOHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_005502_090220_68CA89B3 
X-CRM114-Status: GOOD (  38.28  )
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

On Tue, 2026-06-23 at 15:08 -0700, Cong Wang wrote:
> On Mon, Jun 22, 2026 at 5:08=E2=80=AFAM Benjamin Berg <benjamin@sipsoluti=
ons.net> wrote:
> >=20
> > On Fri, 2026-06-19 at 20:22 -0700, Cong Wang wrote:
> > > From: Cong Wang <cwang@multikernel.io>
> > >=20
> > > In the seccomp ("SECCOMP") userspace mode, each guest userspace proce=
ss
> > > runs in a stub under a seccomp filter and traps to the monitor (the U=
ML
> > > kernel) on every syscall. Two items on the stub.c "Known security iss=
ues"
> > > list could not be addressed by the filter alone:
> > >=20
> > > =C2=A0 - a hijacked stub could mmap() arbitrary physmem offsets, whic=
h is an
> > > =C2=A0=C2=A0=C2=A0 intra-guest disclosure and, on this base (single p=
hysmem fd, no
> > > =C2=A0=C2=A0=C2=A0 kernel/user split), a host escape; and
> > >=20
> > > =C2=A0 - a hijacked stub could block SIGALRM via a crafted rt_sigretu=
rn to
> > > =C2=A0=C2=A0=C2=A0 evade preemption and wedge the monitor indefinitel=
y.
> > >=20
> > > This series closes both:
> > >=20
> > > =C2=A0 1-2: route the stub's mmap() through a SECCOMP_RET_USER_NOTIF =
listener
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 owned by the monitor (no behavio=
ural change yet).
> > > =C2=A0 3-4: validate each mmap() against the mm's page table -- allow=
ed iff the
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PTE already maps the requested f=
rame with no more access than it
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 grants -- including out-of-batch=
 mmaps a hijacked stub issues on
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 its own.
> > > =C2=A0 5:=C2=A0=C2=A0 route and validate munmap() the same way (range=
-confined below
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STUB_START).
> >=20
> >=20
> > That approach seems odd to me. Adding an explicit out-of-band check
> > means you require two extra context switches per mmap syscall. I would
> > expect that this makes the SECCOMP approach a lot slower than ptrace().
> > My take is still that it is possible to carefully craft a SECCOMP
> > filter as well as stub/kernel code that makes exploitation impossible
> > for non-SMP.
> >=20
> > The true SMP case is more complicated, but we do not have that anyway,
> > so I would not worry about it for now.
> >=20
> > Did you run any performance tests?
>=20
> Sorry, I thought I included them in patch 4/7, but I missed them.
>=20
> Here they are:
>=20
> mmap() -- ns/call
> -----------------
> size=C2=A0=C2=A0 WITH med=C2=A0=C2=A0 WITHOUT med=C2=A0=C2=A0 delta=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WITH p99=C2=A0=
=C2=A0 WITHOUT p99
> 4K=C2=A0=C2=A0=C2=A0=C2=A0 13056=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10368=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2688=C2=A0 (+26%)=C2=A0=C2=
=A0=C2=A0=C2=A0 17408=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15104
> 16K=C2=A0=C2=A0=C2=A0 13824=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11008=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2816=C2=A0 (+26%)=C2=A0=C2=A0=C2=
=A0=C2=A0 15616=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12544
> 64K=C2=A0=C2=A0=C2=A0 19840=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15616=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +4224=C2=A0 (+27%)=C2=A0=C2=A0=C2=
=A0=C2=A0 21760=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 17408
> 256K=C2=A0=C2=A0 33152=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 28928=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +4224=C2=A0 (+15%)=C2=A0=C2=A0=C2=A0=C2=
=A0 36352=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 31744
> 1M=C2=A0=C2=A0=C2=A0=C2=A0 95616=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 84608=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +11008 (+13%)=C2=A0=C2=A0=C2=
=A0=C2=A0 117504=C2=A0=C2=A0=C2=A0=C2=A0 108032
>=20
> munmap() -- ns/call
> -------------------
> size=C2=A0=C2=A0 WITH med=C2=A0=C2=A0 WITHOUT med=C2=A0=C2=A0 delta=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WITH p99=C2=A0=
=C2=A0 WITHOUT p99
> 4K=C2=A0=C2=A0=C2=A0=C2=A0 11008=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8448=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2560=C2=A0 (+30%)=C2=A0=
=C2=A0=C2=A0=C2=A0 13568=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11264
> 16K=C2=A0=C2=A0=C2=A0 10752=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8448=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2304=C2=A0 (+27%)=C2=A0=C2=
=A0=C2=A0=C2=A0 12288=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9472
> 64K=C2=A0=C2=A0=C2=A0 12032=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9728=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2304=C2=A0 (+24%)=C2=A0=C2=
=A0=C2=A0=C2=A0 13824=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10752
> 256K=C2=A0=C2=A0 15360=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12800=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2560=C2=A0 (+20%)=C2=A0=C2=A0=C2=A0=C2=
=A0 17152=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14592
> 1M=C2=A0=C2=A0=C2=A0=C2=A0 27648=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24832=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2816=C2=A0 (+11%)=C2=A0=C2=
=A0=C2=A0=C2=A0 30976=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26880
>=20
> Since this is a clear security-vs-performance balance, I picked security
> over performance. Please let me know if you prefer otherwise.

So, I still believe that (almost) zero-overhead is possible in the
current framework. Maybe one could add a non-zero overhead option, but
then I would like to be able to disable it as there are plenty of
scenarios where security is of no concern.

Also, I am unsure what you measured there. When you write "mmap" here,
is that an "mmap" call made by the userspace process (which might not
actually change the page mappings), or is that an "mmap" call that was
queued for the stub to process?

A large amount of the overhead that UML tends to have happens when
handling both minor and major page faults. Simple tests for this is for
example a relatively tight fork/exec loop or just applications starting
up. In our test runs, we saw major speed improvements (>10%) just by
fixing bugs in the TLB handling code that resulted in fewer page faults
happening at application runtime.

> Meanwhile, after a second thought, there is a zero-overhead solution.
> pidfd_mmap(), which can be built on top of another patch of mine:
> https://lore.kernel.org/all/20260613001533.314739-2-xiyou.wangcong@gmail.=
com/

Sure, should some sort of method land that allows directly modifying
the=C2=A0mappings of the remote process, that would be rather convenient.=
=20

> Something like:
>=20
> int map(struct mm_id *mm_idp, unsigned long virt, unsigned long len, int =
prot,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int phys_fd, unsigned long lon=
g offset)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return pidfd_mmap(mm_idp->stub=
_pidfd, (void *)virt, len,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 prot_to_mmap(prot), MAP_FIXED | MAP_SHARED,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 phys_fd, offset);
> }
> int unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return pidfd_munmap(mm_idp->st=
ub_pidfd, (void *)addr, len);
> }
>=20
> Obviously, this one requires a new syscall for the host kernel first.
>=20
> >=20
> > > =C2=A0 6:=C2=A0=C2=A0 add a watchdog thread that detects a stub which=
 stops reporting
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 back (e.g. blocked SIGALRM) and =
SIGKILLs it, letting the monitor
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 recover via the existing teardow=
n.
> >=20
> > That also seems like an odd solution to me. Architecturally, UML first
> > receives the SIGALRM and forwards it to the child. It would seem much
> > easier to set a flag and clear it again when the process reports back
> > that it received the SIGALRM. Then, when the kernel receives the next
> > SIGALRM, just kill the child immediately if the flag is still set.
>=20
> The flag-and-recheck scheme matches the ptrace path (wait_stub_done), whe=
re
> the monitor is the tracer: it sees the stub's SIGALRM as a waitpid()
> signal-stop and PTRACE_CONTs it, so "monitor receives, then deals with th=
e
> child" is accurate there. This patch is on the seccomp path
> (wait_stub_done_seccomp), which is architecturally different.
>=20
> Or am I missing anything?

The fact that it is not actually different from an architectural
standpoint. In both cases SIGALRM is reported back to the kernel. It
obviously has to be reported back, otherwise scheduling would not work.

Benjamin

>=20
> Thanks for your review.
>=20
> Regards,
> Cong
>=20

