Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB7FD10C11
	for <linux-um@archiver.kernel.org>; Mon, 28 Oct 2024 13:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fcU2d0/Xx0gnXHHXkURo4RgM0ahjsNMFeGTCSyyOiCQ=; b=J+uaSp3ZLTba0x02/R9tBxeSCe
	YGFngTGX0uOzK/kls6jeiO4WljETpjpozLOQBHkGSi2hkirSjMPUmO0+aCOrRc4pMylF5AnWKp4FH
	zo4uZulnckIW1qsfqASFACr2JxGQxh+lDhYw/xcwFcHIW9mhgWKqStPvc52URYrn+8MkGb4LZh+w8
	M8/sClP2d9+lIM6u2Xu43VKRQUICNjeFV0MsryMnTK/LaQVtmOYEAibEYHFMTKvoefMyjgTvmCvD9
	UXnnIt3+aXF2ea63PMtyhWXbuWuZSWSrrdCqtCs846Uhdhx4Y9mLtDSe0eYVbYarfEU3lgJswpYXe
	zl0Um4bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Psj-0000000AwjJ-0zUl;
	Mon, 28 Oct 2024 13:34:05 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Prb-0000000AwdZ-1Qoh
	for linux-um@lists.infradead.org;
	Mon, 28 Oct 2024 13:32:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fcU2d0/Xx0gnXHHXkURo4RgM0ahjsNMFeGTCSyyOiCQ=;
	t=1730122372; x=1731331972; b=DzNO7xVQMDkZViTnKl1mOr2FT74PuZRFnoEEi0fFvPrxP93
	2XGBYN3UsHnTKsHzlqpq5HG8k7EFfr2Zj+JS38GlfoQTa9sUWPIAzpsjIHhkxl881deuUAwRbbD+a
	oDOK4UXc6/m2ymt3aUjPol5BYu/xG3uoIIdeGdhxeqRsliatm1jYFtWVD0jh3yTU1XSCYVUgXS4br
	xjaxs2/b91vf2/XbTHSiqdR8HRTHEXEnYnUbCV/PLnrAbrcnjGLzlMz5Vxnu3Xt+UFH9vXqoaAeSw
	kP7eBC92XJSEBxr07FS6PUWKYkKNj7YYbrEbxwLlZiZpIeXA7J8qOWMXorgytiPA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t5PrT-00000007CDa-0LRs;
	Mon, 28 Oct 2024 14:32:47 +0100
Message-ID: <1246523a29aeca3d727a359ebf8ccd931631e1ef.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 00/13] nommu UML
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, 
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 ricarkol@google.com
Date: Mon, 28 Oct 2024 14:32:43 +0100
In-Reply-To: <m2y129hpx5.wl-thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <f482739aa05abd80479804054e4affe23f0dc6c5.camel@sipsolutions.net>
	 <m2y129hpx5.wl-thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_063255_414420_AA12EC64 
X-CRM114-Status: GOOD (  47.01  )
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

Hello Hajime,

On Sun, 2024-10-27 at 18:10 +0900, Hajime Tazaki wrote:
> thank you for your time looking at this.
>=20
> On Sat, 26 Oct 2024 19:19:08 +0900,
> Benjamin Berg wrote:
>=20
> > > - a crash on userspace programs crashes a UML kernel, not signaling
> > > =C2=A0 with SIGSEGV to the program.
> > > - commit c27e618 (during v6.12-rc1 merge) introduces invalid access t=
o
> > > =C2=A0 a vma structure for our case, which updates the internal proce=
dure
> > > =C2=A0 of maple_tree subsystem.=C2=A0 We're trying to fix issue but s=
till a
> > > =C2=A0 random process on exit(2) crashes.
> >=20
> > Btw. are you handling FP register save/restore? If it is not there, it
> > probably would not be too hard to add (XSAVE, etc.), though it might
> > add a bit of additional overhead. Especially as UML always saves the FP
> > state rather than optimizing it like the x86 architectures.
>=20
> The patch handles fp register on entry/leave at syscall; [07/13] patch
> contains this part.

That looks like FS/GS registers which are for thread-local storage. I
was talking about floating point registers. Maybe you meant another
patch?

> I'm not familiar with that but what kind of optimizations does x86
> architecture do for fp register handling ?

The kernel does not usually need the FP registers. So it optimizes the
pretty common case of a userspace -> kernel -> userspace switch that
happens for a syscall by simply not saving/restoring these registers at
all.

Obviously, it then still needs to do the work when the task is switched
or in the rare case that the kernel wants to use floating point itself.

> > I am a bit confused overall. I mean, zpoline seems kind of neat, but a
> > requirement on patching userspace code also seems like a lot.
> >=20
> > To me, it seems much more natural to catch the userspace syscalls using
> > a SECCOMP filter[1]. While quite a lot slower, that should be much more
> > portable across architectures. For improved speed one could still do
> > architecture specific things inside the vDSO or by using zpoline. But
> > those would then "just" be optimizations and unpatched code would still
> > work correctly (e.g. JIT).
>=20
> I'm not proposing this patch to replace existing UML implementations;
> for instance, the patchset cannot run CONFIG_MMU code in the whole
> kernel tree so, existing ptrace-based implementation still has real
> usecase.=C2=A0 and ptrace based syscall hook is not indeed fast and the
> improvements with seccomp filter instead clearly has benefits.=C2=A0 I
> think it's independent to this patchset.

Of course. nommu mode is a completely independent feature.

I am still wondering a bit about the users for such a mode. It is not
interesting for us as we use it for testing. Of course, speed is nice
but it is not the primary objective.

I understand that it can be an approach for a small "container", but
then you would need a very strict SECCOMP filter for the kernel itself.

> So I think while your seccomp patches are also in review, this
> patchset can exist in parallel.
>=20
> btw, though I mentioned that JIT generated code is not currently
> handled in a different reply, it can be implemented as an extension to
> this patchset; the original implementation of zpoline now is able to
> patch JIT generated code as well.
>=20
> https://github.com/yasukata/zpoline/pull/20/commits/c42af16757ad3fcdf7084=
c9f2139bb9105796873
>=20
> it is not implemented for the moment.
>=20
> in terms of the portability, the basic idea of syscall hook with
> zpoline is applicable to other platform, like aarch64
> (https://github.com/retrage/svc-hook).=C2=A0 so I believe it has a chance
> to expand this idea to other architectures than x86_64.

Right, aarch64 is probably the most interesting one in general. At
least there was some interest in a UML port.

> > For me, a big argument in favour of such an approach is its simplicity.
> > I am mostly basing that on the fact that this patchset should properly
> > handle other signals like SIGFPE and SIGSEGV. And, once it does that,
> > you will already have all the infrastructure to do the correct register
> > save/restore using the host mcontex, which is what is needed in the
> > SIGSYS handler when using SECCOMP. The filter itself should be simple
> > as it just needs to catch all syscalls within valid userspace
> > executable memory[2] ranges.
>=20
> I agree with your observation that the approach is simple.
> I don't have a good idea on how to handle SIGSEGV, but will try to see
> with your inputs.

You can probably use "[RFC PATCH v2 5/9] um: Add helper functions to
get/set state for SECCOMP" for getting the registers and also writing
them back if you want to restore using rt_sigreturn.

> > [1] Maybe not surprising, as I have been working on a SECCOMP based UML
> > that does not require ptrace.
>=20
> yes, I'm aware of it since before.=C2=A0 I have also conducted a benchmar=
k
> with several hook mechanisms, including seccomp with simple getpid
> measurement.
>=20
> https://speakerdeck.com/thehajime/netdev0x18-zpoline?slide=3D16

Sure! I saw that :-)

> > [2] I am assuming that userspace executable code is already confined to
> > a certain address space within the UML process. Obviously, the kernel
> > itself and loaded modules need to be free to do host syscalls and
> > should not be affected by the SECCOMP filter.
>=20
> I think our !MMU UML doesn't break this assumption.=C2=A0 But did you see
> something to our patchset ?

I also assume that is fine. One just needs to understand this when
writing a SECCOMP filter for syscall emulation in nommu mode.

Benjamin

