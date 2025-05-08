Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1796FC3ABC6
	for <linux-um@archiver.kernel.org>; Thu,  8 May 2025 17:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ViC3Vp7dErVibjpIJ8GsP8Af1EHoNwDVFisWnZ+tltY=; b=xMpcQfWjA82NwHe8kP7vdYdkD2
	sGm6j0wQlnl6xtFUA22+bRBLaVHOCrLJBpKirc9kG5A7XuUHwPJKBIzm57jOVd30SFFSPq/tjevQ+
	LjwuY0orMmANi4bmXL28EY/nP4rUwiHReWNMHM1SSTBcy5Kc/EZyIYlDeM3IUUADJeBbRNHBkYM9i
	aUHnVgTa4gBG+wXODmPWfEIUWIk9QZBlo0dhX9XKXW7MN/hefFFGLPgv217a9yB4z6auCTvgPRj7X
	vPp0v/OOZynz9USK4WmOr/RXLSLbgr3LlTzRwyaV9jKDAiqV4Q5LG3KEE4XtguhuRRHnN9C3cLzfO
	0MMJjgvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD4wE-00000001Nu2-3BLf;
	Thu, 08 May 2025 17:21:38 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD4nv-00000001Lsy-3zc4
	for linux-um@lists.infradead.org;
	Thu, 08 May 2025 17:13:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ViC3Vp7dErVibjpIJ8GsP8Af1EHoNwDVFisWnZ+tltY=;
	t=1746724381; x=1747933981; b=wQwa0nQ7y7+ZEa7e+yKTGyb8d8U9LJMCpEQ75b7NJCGTy8o
	2STuzvx+REXrizIfvBXwK2GaOhvTZnnjcsqhc9gjg8KIDgFnVh0MBz7AHAu+sGlXrdo0azgU/vLP3
	r5EUlR5zCJb6dJzNklgMip0OAfr0ZPi/66s5ILrcKSGNNho/eK1qoEipuB6qZBmGO4jyZNOPp/+50
	z1DOf5pOBu0kcPx+VQUQDGTD8/JlhoNsNQZKvKc1QPZgBAgkFYLg6KuI1xorYTkhpWzkOWv9vhKj9
	R61caaCwerzEdTSUYR9tKav+0OiygE6VOFTbXh6/Lwin3/OrEgmA2lJUQCCht4Jw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uD4nq-0000000Apcs-3tlu;
	Thu, 08 May 2025 19:12:59 +0200
Message-ID: <8ce0b6056a9726e540f61bce77311278654219eb.camel@sipsolutions.net>
Subject: Re: Missing patch in 6.12.27 - breaks UM target builds
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>, 
	linux-um@lists.infradead.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 08 May 2025 19:12:57 +0200
In-Reply-To: <0df8de9f-d24a-4ffb-8234-7d7bbe1660a4@isd.uni-stuttgart.de>
References: <20250314130815.226872-1-benjamin@sipsolutions.net>
	 <0df8de9f-d24a-4ffb-8234-7d7bbe1660a4@isd.uni-stuttgart.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_101304_012581_4EB8E280 
X-CRM114-Status: GOOD (  36.52  )
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

I think it is better to just not backport
0b8b2668f9981c1fefc2ef892bd915288ef01f33 ("um: insert scheduler ticks
when userspace does not yield").

Benjamin

On Thu, 2025-05-08 at 19:00 +0200, Christian Lamparter wrote:
> Hi,
>=20
> On 3/14/25 2:08 PM, Benjamin Berg wrote:
> > From: Benjamin Berg <benjamin.berg@intel.com>
> > =C2=A0=C2=A0=C2=A0 um: work around sched_yield not yielding in time-tra=
vel mode
> >=20
> > sched_yield by a userspace may not actually cause scheduling in
> > time-travel mode as no time has passed. In the case seen it appears
> > to
> > be a badly implemented userspace spinlock in ASAN. Unfortunately,
> > with
> > time-travel it causes an extreme slowdown or even deadlock
> > depending on
> > the kernel configuration (CONFIG_UML_MAX_USERSPACE_ITERATIONS).
> >=20
> > Work around it by accounting time to the process whenever it
> > executes a
> > sched_yield syscall.
> >=20
> > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
>=20
> =C2=A0From what I can tell the patch mentioned above was backported to
> 6.12.27 by:
> <
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commi
> t/arch/um?id=3D887c5c12e80c8424bd471122d2e8b6b462e12874>
>=20
> but without the upstream
> > Commit 0b8b2668f9981c1fefc2ef892bd915288ef01f33
> > Author: Benjamin Berg <benjamin.berg@intel.com>
> > Date: =C2=A0=C2=A0Thu Oct 10 16:25:37 2024 +0200
> > =C2=A0 um: insert scheduler ticks when userspace does not yield
> >=20
> > =C2=A0=C2=A0 In time-travel mode userspace can do a lot of work without=
 any
> > time
> > =C2=A0=C2=A0 passing. Unfortunately, this can result in OOM situations =
as the
> > RCU
> > =C2=A0 core code will never be run. [...]
>=20
> the kernel build for 6.12.27 for the UM-Target will fail:
>=20
> > /usr/bin/ld: arch/um/kernel/skas/syscall.o: in function
> > `handle_syscall': linux-
> > 6.12.27/arch/um/kernel/skas/syscall.c:43:(.text+0xa2): undefined
> > reference to `tt_extra_sched_jiffies'
> > collect2: error: ld returned 1 exit status
>=20
> is it possible to backport 0b8b2668f9981c1fefc2ef892bd915288ef01f33
> too?
> Or is it better to revert 887c5c12e80c8424bd471122d2e8b6b462e12874
> again
> in the stable releases?
>=20
> Best Regards,
> Christian Lamparter
>=20
> >=20
> > ---
> >=20
> > I suspect it is this code in ASAN that uses sched_yield
> > =C2=A0=C2=A0
> > https://github.com/llvm/llvm-project/blob/main/compiler-rt/lib/sanitize=
r_common/sanitizer_mutex.cpp
> > though there are also some other places that use sched_yield.
> >=20
> > I doubt that code is reasonable. At the same time, not sure that
> > sched_yield is behaving as advertised either as it obviously is not
> > necessarily relinquishing the CPU.
> > ---
> > =C2=A0 arch/um/include/linux/time-internal.h |=C2=A0 2 ++
> > =C2=A0 arch/um/kernel/skas/syscall.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 11 +++++++++++
> > =C2=A0 2 files changed, 13 insertions(+)
> >=20
> > diff --git a/arch/um/include/linux/time-internal.h
> > b/arch/um/include/linux/time-internal.h
> > index b22226634ff6..138908b999d7 100644
> > --- a/arch/um/include/linux/time-internal.h
> > +++ b/arch/um/include/linux/time-internal.h
> > @@ -83,6 +83,8 @@ extern void time_travel_not_configured(void);
> > =C2=A0 #define time_travel_del_event(...) time_travel_not_configured()
> > =C2=A0 #endif /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
> > =C2=A0=20
> > +extern unsigned long tt_extra_sched_jiffies;
> > +
> > =C2=A0 /*
> > =C2=A0=C2=A0 * Without CONFIG_UML_TIME_TRAVEL_SUPPORT this is a linker =
error
> > if used,
> > =C2=A0=C2=A0 * which is intentional since we really shouldn't link it i=
n that
> > case.
> > diff --git a/arch/um/kernel/skas/syscall.c
> > b/arch/um/kernel/skas/syscall.c
> > index b09e85279d2b..a5beaea2967e 100644
> > --- a/arch/um/kernel/skas/syscall.c
> > +++ b/arch/um/kernel/skas/syscall.c
> > @@ -31,6 +31,17 @@ void handle_syscall(struct uml_pt_regs *r)
> > =C2=A0=C2=A0		goto out;
> > =C2=A0=20
> > =C2=A0=C2=A0	syscall =3D UPT_SYSCALL_NR(r);
> > +
> > +	/*
> > +	 * If no time passes, then sched_yield may not actually
> > yield, causing
> > +	 * broken spinlock implementations in userspace (ASAN) to
> > hang for long
> > +	 * periods of time.
> > +	 */
> > +	if ((time_travel_mode =3D=3D TT_MODE_INFCPU ||
> > +	=C2=A0=C2=A0=C2=A0=C2=A0 time_travel_mode =3D=3D TT_MODE_EXTERNAL) &&
> > +	=C2=A0=C2=A0=C2=A0 syscall =3D=3D __NR_sched_yield)
> > +		tt_extra_sched_jiffies +=3D 1;
> > +
> > =C2=A0=C2=A0	if (syscall >=3D 0 && syscall < __NR_syscalls) {
> > =C2=A0=C2=A0		unsigned long ret =3D EXECUTE_SYSCALL(syscall,
> > regs);
> > =C2=A0=20
>=20
>=20


