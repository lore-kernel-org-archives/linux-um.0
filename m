Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C29CF9C71
	for <linux-um@archiver.kernel.org>; Tue, 24 Sep 2024 10:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6hEJfIA2hheCXuQSZpItp1yI6txQw72lhtaP1djtnBk=; b=LQsX0BfwDz7giq8CGPj+alRS0u
	83JVXPX8MupzVUMgm8WL/2vembyu07WrMRb6r2R1pGA78TlJf/Doudp/91aSdf9W5+nQ7M48yl1oF
	G9OGVFVVPeocD51uxGSfwAo9Lj8heh2rlQwdvmRDnkTXOmJHguRzvQk8OQNU44k167b4W9KO1YGw6
	YGlvLDec7MHqSkm7bJ2Wgsr/eXsleeLybezVY04XWn6sefM2PKdA0sKpw0kJhU5ZE9i70Jik0Kzzm
	/DC7cbDDPzKn6uAyAp/02iqtxkJcza2DKzhnR+jWqPc3aUnzjVv0T4+sZhJQcfV5Tbzx55CmWbHTt
	1twbXsng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1st33u-000000023FS-09Cu;
	Tue, 24 Sep 2024 10:46:30 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1st33q-000000023DW-45p5
	for linux-um@lists.infradead.org;
	Tue, 24 Sep 2024 10:46:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6hEJfIA2hheCXuQSZpItp1yI6txQw72lhtaP1djtnBk=;
	t=1727174786; x=1728384386; b=DPWyIHY4POCA54hOnUBLBblAAIvkUTh+NnpOr0vLkvT4dAz
	G3r0YQW8b6qBUTMYDph74L9+ajm/ptoUiGUPpJ+PGnfAtBnHWgGwkBIsHS9U/46aHe+5dNtoSSwGf
	HFFcBFpmL6JzkmKukHca/52zASScS6fTB8sn+0+pZvm7p0SCKFjicwe0+wtxzf/o92RgcrEVUGpKb
	oKFUsG4ANNwaWCnIEGUq7aftkIGDvCPdOWqpqO2fh23SdDmecyQFO+xbZSSuz3m+DLZtwHSuwvnqC
	zDlHuQHqFIcXbMPCFCahbTf7jt/ePFYdOGGqXVG9eBwrvB7egmbNrnBu53xLB1UQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1st33n-0000000G4Oq-1KqF;
	Tue, 24 Sep 2024 12:46:23 +0200
Message-ID: <fda8141683d00d7468eb90476d1bcd26e40e30af.camel@sipsolutions.net>
Subject: Re: [PATCH] um: insert scheduler ticks when userspace does not yield
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>, 
	linux-um@lists.infradead.org
Date: Tue, 24 Sep 2024 12:46:21 +0200
In-Reply-To: <f8fce20b-5330-41ac-9020-3fa9149df581@uni-rostock.de>
References: <20240913201756.1223327-1-benjamin@sipsolutions.net>
	 <3ea4c557-df8f-4312-84f6-8dc0b2c2a5f1@uni-rostock.de>
	 <b9e99c84ec953cc1459928c103fc4789eacce486.camel@sipsolutions.net>
	 <5f2de09a-0af6-46b7-9e9e-6dc0a5d0b885@uni-rostock.de>
	 <071d74214d6b2f58e0ea92d8b1cb0381a78304b0.camel@sipsolutions.net>
	 <a10197a3-e185-4f74-a35c-8f7cb3f43014@uni-rostock.de>
	 <0b7adfea0a3f24963c2baf22f0d6762ad3d82a09.camel@sipsolutions.net>
	 <f8fce20b-5330-41ac-9020-3fa9149df581@uni-rostock.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_034627_530091_7FB07B35 
X-CRM114-Status: GOOD (  57.24  )
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

On Mon, 2024-09-23 at 23:50 +0200, Benjamin Beichler wrote:
> Hi,
>=20
> Am 23.09.2024 um 16:48 schrieb Benjamin Berg:
> > > Actually, I think, timeouts are no problem, if we can assure, that a
> > > timeout is never rounded down to 0. Mostly a direct input of 0 have
> > > special meanings, or provokes wrong behavior in the first place from
> > > user space program.
> > I don't think that is a problem. The kernel should guarantee that a
> > timeout never fires too early.
> >=20
> > I believe in the case of the linked python code, the timeout fires at
> > exactly the correct time. And then the python code (incorrectly)
> > detects that the timeout has not passed and tries to "select" again
> > with a timeout of exactly zero.
> >=20
> > Really, that implementation is just buggy in subtle ways. It could
> > probably just trust the kernel to not wake up early. And, if it does
> > check whether the timeout has passed, then it should just accept the
> > exact time.
>=20
> Maybe I'm doing a captain obvious here, but I had the impression this
> code was written this way, to handle interruptions by signals and not to=
=20
> doubt the time accuracy. Possibly I'm totally wrong, but it seems quite=
=20
> elegant to simply use time here to avoid that dance to mask signals or=
=20
> check for interruptions etc.

Yeah, you are right. I wasn't sure what python does in case of EINTR.
But it does look like it'll stop the select in that case after handling
the signal.

> I believe this code was written in mind that time() will advance, so=20
> this will never be an endless loop, so even the corner case that timeout=
=20
> was 0 would be covered by this

Dunno, it feels to me like someone just didn't think much about whether
it should be a "<" or "<=3D" operator there. Simply changing the
    if timeout < 0:=20
to
    if timeout <=3D 0:
will resolve the problem and is more correct in my view. A specific
"time" is valid in the interval from the clock tick until the next
tick. So the only sensible thing is to assume that you are somewhere
within the interval *after* the tick, which means the timeout has
passed already if it is exactly zero.

Trying to do a zero length sleep to wait for the next clock tick does
not make sense. Especially as a zero length sleep is defined to not
sleep.

> > > Since time-travel mode has a very limited niche, I would not try to
> > > prevent every possible dumb behavior that bad user space programs cou=
ld
> > > have. I think busy-waiting on a system clock advancement is not the b=
est
> > > style, but acceptable.
> > >=20
> > > So my list was:
> > >=20
> > > sys_getitimer
> > > sys_gettimeofday
> > > sys_time
> > > sys_timer_gettime
> > > sys_clock_gettime
> > > sys_timerfd_gettime
> > >=20
> > > While overthinking it, I see the possibility to read the access
> > > timestamps of a file to create an endless loop, so maybe the stat
> > > syscalls may be included, although this makes me a bit uncomfortable
> > > again. I tend to say, this "bad" behavior of asking the same informat=
ion
> > > over and over again, should only be punished, if it happens multiple =
times.
> > >=20
> > > I was thinking about, storing the PID of a busy-looped process, and o=
nly
> > > increase time, if the same PID is "suspicious".=C2=A0 However, this "=
hack"
> > > becomes more and more costly, which is on the other hand not importan=
t
> > > for timetravel mode.
> > Maybe a stupid question, but aren't we overthinking this in general?
> >=20
> > While I think that Johannes' solution to make reading the time cost
> > time is kind of ingenious, I really wonder how much of an issue this
> > actually is. Because if this is just a few userspace applications and
> > libraries misbehaving, then we might as well fix the issue there
> > instead of doing anything special in UML.
>=20
> Your point is right, and such bugs may be fixed in user space. On the
> other hand, what about software we can't or don't want to fix, which in=
=20
> the wild simply works. For my future use cases, I will run code, that
> I'm not able to compile myself. I would even consider to have a runtime=
=20
> switch to change the behavior of this hack, to reduce the overhead in
> simulations that behave nicely, but have some quick workaround for=20
> misbehaving code.

Sure. But we could still decide to not support that in the upstream
kernel. How you solve the problem in your application would be up to
you. You can apply a simple patch or find another solution in
userspace.

> And sorry for repeating myself, but I believe, that busy waiting on an=
=20
> increasing timer value is not the best style, but considered okay/normal=
=20
> for some use cases. So I think it would be helpful to be able to execute=
=20
> such user space code.

Right, it is just that I have not actually seen anyone wanting to do a
busy wait on a time. The python example explicitly tries to sleep and
just gets the rounding wrong.

> But I want to bring in another idea: Could we use an ebpf program to=20
> dynamically hook into syscalls and do a timetravel_update or something=
=20
> similar? Actually, I do not know whether ebpf works normally in UM, but=
=20
> that way it would be flexible and moving the dirty hacks into small=20
> portions outside the kernel. From what I understand, we would need to
> add an ebpf callable wrapper for the time travel update function, isn't i=
t?

Hmm, possibly. I am not familiar with what is possible to do when
tracing syscalls using eBPF.

That said, I wonder if we should be inserting a clock_nanosleep()
conceptually. If you want to force a process to continue running after
the next clock tick, then you might want to schedule all other runnable
tasks *before* letting the clock tick.

> > > > One neat side effect is that if reading time does not actually cost
> > > > time, then we could implement clock_gettime in the VDSO.
> > > That would exactly not work, because of my comment from before.
> > Of course. It is just that I have always in the back of my mind that
> > syscalls and pagefaults (including minor faults) are really expensive
> > in UML. So if the hack is moved elsewhere then implementing
> > clock_gettime in the vDSO could be an easy win to speed up the
> > simulation.
>=20
> Mhh I did only a quick look into "arch/x86/um/vdso/um_vdso.c" and from=
=20
> my understanding, currently every vdso call is converted into syscalls=
=20
> of the host. So we need much more code to use here the time travel=20
> clock, isn't it? Of course, my proposed ebpf hook would not work here
> either...

Yeah, but I don't expect it to be that complicated. If the clock
doesn't actually change, then it would be trivial to just return a
constant value.

It gets more complicated if reading time should take time. But even
then, we can probably hide some (writable) bookkeeping data on the stub
page (as the vDSO data should be read-only). And outside of time-travel
a SECCOMP execution model would allow us to do direct host syscalls.

Anyway, I suppose vDSO improvements are not necessarily a short term
project.

Benjamin


