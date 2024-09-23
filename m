Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA42BCF9C69
	for <linux-um@archiver.kernel.org>; Mon, 23 Sep 2024 14:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YECKKtlAy3Pg1i9mLl7uusvaThb2Vh4tstBvoc1fzcU=; b=XesibT7OrwNkN9p76iNqCI0KX0
	S9U/iCu200nujU5LnZ598nGo6Tx0xDdEoRp7YqYlIEPmkvpfYdVIb+Aow2spQsv8/dN19o735C6AM
	+fzksgvmhaDLGM2fs6nwJ8xAJ0IXlNV8XUm9wrlEQSZ7jDQyG2Epr3/E/7oJRdujnqISuGNqp6gXZ
	XI2CfuwycAPaKswqTXHtkv2HxSJp4FyaHSqfm9ZTp0pR6AvA3Ef2ZdpSsWi1eYQpvNZUT41rZhtAV
	YxYH1U/wevYsMbi/S/9Gc/lhVvsDSOZbLidmH6ASj8d9oUye/vWD78Lj9MwXuAUj057KNJZvp7tCA
	484tQgpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sskMt-0000000HPfo-02Py;
	Mon, 23 Sep 2024 14:48:51 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sskMW-0000000HPeM-2zjm
	for linux-um@lists.infradead.org;
	Mon, 23 Sep 2024 14:48:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YECKKtlAy3Pg1i9mLl7uusvaThb2Vh4tstBvoc1fzcU=;
	t=1727102906; x=1728312506; b=mSYQguy/RjQH9NbsrrznbgKYj1ISxMzasnBEANV6p4nBZOa
	P6PL8FvF1rP/DwAe1IMzhCNNygwx8kcmPh2sXqq1meuyjiRid7gEKwgtKH4eN3ohC6QNZzVYsCOmK
	YhsDzs6oy0z040xv7zGNm2DyEekZx1k+igDMfsQ2TFvhrGZBc/1wTlxv0UjDhmwdecs4u9yZmMk84
	lFn9fhI19EVkwqSU0qpioHcuPT2Nd6Z9TReTEEf4kVM+K34AHmHcWBRB7RvdTaXf7NuPoAzvhP0CB
	w4zR/2ad/TsejgcroOxSzQVZXKk55skVlX5K6mGOwZsqYjhOz/DNlVuy8PlZ1E1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sskMQ-0000000ER6M-3iFm;
	Mon, 23 Sep 2024 16:48:23 +0200
Message-ID: <0b7adfea0a3f24963c2baf22f0d6762ad3d82a09.camel@sipsolutions.net>
Subject: Re: [PATCH] um: insert scheduler ticks when userspace does not yield
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>, 
	linux-um@lists.infradead.org
Date: Mon, 23 Sep 2024 16:48:19 +0200
In-Reply-To: <a10197a3-e185-4f74-a35c-8f7cb3f43014@uni-rostock.de>
References: <20240913201756.1223327-1-benjamin@sipsolutions.net>
	 <3ea4c557-df8f-4312-84f6-8dc0b2c2a5f1@uni-rostock.de>
	 <b9e99c84ec953cc1459928c103fc4789eacce486.camel@sipsolutions.net>
	 <5f2de09a-0af6-46b7-9e9e-6dc0a5d0b885@uni-rostock.de>
	 <071d74214d6b2f58e0ea92d8b1cb0381a78304b0.camel@sipsolutions.net>
	 <a10197a3-e185-4f74-a35c-8f7cb3f43014@uni-rostock.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240923_074829_050448_A914105F 
X-CRM114-Status: GOOD (  32.31  )
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

On Mon, 2024-09-23 at 15:56 +0200, Benjamin Beichler wrote:
> > > For "clean" semantics of a simulative execution of the kernel, it fee=
ls
> > > erroneous to advance time even if this value is only read once.
> > >=20
> > > In my experiments timer_read was called much more often than I
> > > anticipated (e.g., filesystem code).
> > Yeah, that does not really sound like something we would want (and it
> > will also not help with performance with time-travel=3Dext).
> >=20
> > Looking at the old discussion, it doesn't seem that Johannes was
> > against the idea of doing the time insertion only in more specific
> > scenarios. So, we "just" need a reasonably elegant solution.
> >=20
> > If we accept writing a list of syscalls, then maybe we could just do it
> > within handle_syscall and do a um_udelay(1) for any syscall that takes
> > a timeout parameter (select, pselect6, poll, ...)? It is going to be a
> > pretty long list, but could still be reasonable.
>=20
> That's actually not what my "hack" did. I filtered out all syscalls,=20
> that give some information about the current timestamp of the system.

Yes, I know.

> Actually, I think, timeouts are no problem, if we can assure, that a=20
> timeout is never rounded down to 0. Mostly a direct input of 0 have=20
> special meanings, or provokes wrong behavior in the first place from=20
> user space program.

I don't think that is a problem. The kernel should guarantee that a
timeout never fires too early.

I believe in the case of the linked python code, the timeout fires at
exactly the correct time. And then the python code (incorrectly)
detects that the timeout has not passed and tries to "select" again
with a timeout of exactly zero.

Really, that implementation is just buggy in subtle ways. It could
probably just trust the kernel to not wake up early. And, if it does
check whether the timeout has passed, then it should just accept the
exact time.

(Note that e.g. python asyncio explicitly takes into account the clock
resolution to avoid this type of issue.)

> Since time-travel mode has a very limited niche, I would not try to=20
> prevent every possible dumb behavior that bad user space programs could=
=20
> have. I think busy-waiting on a system clock advancement is not the best=
=20
> style, but acceptable.
>=20
> So my list was:
>=20
> sys_getitimer
> sys_gettimeofday
> sys_time
> sys_timer_gettime
> sys_clock_gettime
> sys_timerfd_gettime
>=20
> While overthinking it, I see the possibility to read the access=20
> timestamps of a file to create an endless loop, so maybe the stat=20
> syscalls may be included, although this makes me a bit uncomfortable=20
> again. I tend to say, this "bad" behavior of asking the same information=
=20
> over and over again, should only be punished, if it happens multiple time=
s.
>=20
> I was thinking about, storing the PID of a busy-looped process, and only=
=20
> increase time, if the same PID is "suspicious".=C2=A0 However, this "hack=
"
> becomes more and more costly, which is on the other hand not important=
=20
> for timetravel mode.

Maybe a stupid question, but aren't we overthinking this in general?

While I think that Johannes' solution to make reading the time cost
time is kind of ingenious, I really wonder how much of an issue this
actually is. Because if this is just a few userspace applications and
libraries misbehaving, then we might as well fix the issue there
instead of doing anything special in UML.

> > One neat side effect is that if reading time does not actually cost
> > time, then we could implement clock_gettime in the VDSO.
>=20
> That would exactly not work, because of my comment from before.

Of course. It is just that I have always in the back of my mind that
syscalls and pagefaults (including minor faults) are really expensive
in UML. So if the hack is moved elsewhere then implementing
clock_gettime in the vDSO could be an easy win to speed up the
simulation.

Benjamin

