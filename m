Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621C5CF3962
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 16:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p0SjKwYr5goYaHetc60auEN9JYEWul7GvVOWiVszYKo=; b=gtZtZfdLtFJc8HIjcVruxxfvNe
	Wg9q9hD75iqWQlC608uL4cST9nja5ghopBizof6fxgRxRJ+i896kreazb2qe4CqR7Bb1l1G5dprzH
	hepCo0HfRCWNSpgZ1Lt3zx3RXVkKqxiuUfquDbpZHx5pcZrWiBOEZ74fDpSfFdCRtrN+neGDhA05F
	unqqoJNhZNzeWwQy9lAe/2ReMyX8DpkB9ZjZpPbdBS/qA0SCPyXMQgd0UhuGSKQc1xd61FTbJ7w3N
	eDGKC2QAiRylWldkP43Pql8mQu/+ptwoc2Za0XR/iSJUuHcUQsoOOscfWlHdZekc74meQI2ZJ32Wl
	XgGSlodw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srKQw-0000000AijT-32Bm;
	Thu, 19 Sep 2024 16:55:10 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srKQt-0000000Aiiv-3WuO
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 16:55:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=p0SjKwYr5goYaHetc60auEN9JYEWul7GvVOWiVszYKo=;
	t=1726764907; x=1727974507; b=g8BtiOFegEzO9rGgotcSJrWcXamYDUFVtIP4ziWw09ogEgs
	9g3MCwtb/1hdFxGcFV5t/KVnohAJ2cM+7vghb0wGgKsH0xonv+bnx+HEVtB77lSOc8FSWP9kImECa
	xKzNZ0rCgz7vtYo7mHrtogJr98MYCH5rkL6JVR8uSG+Qc1ikPxPs74cMJaNhgJBHu6zmnPxhCcTLP
	OGWIhtx47J8jGbGuguPAHs6t5BboX1k8l9QkGJgvYUXI4Hmlvc3N0McJ/lhxY794gmmLpNxkfByWR
	SOgL31H+Yt5LAX5WQiB6yKfBVaU/9PreJ1npeTsjHHyUu2OKO0eNctsJiJL4B9MA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1srKQp-00000004dIt-1Dv8;
	Thu, 19 Sep 2024 18:55:04 +0200
Message-ID: <071d74214d6b2f58e0ea92d8b1cb0381a78304b0.camel@sipsolutions.net>
Subject: Re: [PATCH] um: insert scheduler ticks when userspace does not yield
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>, 
	linux-um@lists.infradead.org
Date: Thu, 19 Sep 2024 18:55:00 +0200
In-Reply-To: <5f2de09a-0af6-46b7-9e9e-6dc0a5d0b885@uni-rostock.de>
References: <20240913201756.1223327-1-benjamin@sipsolutions.net>
	 <3ea4c557-df8f-4312-84f6-8dc0b2c2a5f1@uni-rostock.de>
	 <b9e99c84ec953cc1459928c103fc4789eacce486.camel@sipsolutions.net>
	 <5f2de09a-0af6-46b7-9e9e-6dc0a5d0b885@uni-rostock.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_095507_910972_2AB94C61 
X-CRM114-Status: GOOD (  20.74  )
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

On Thu, 2024-09-19 at 16:37 +0200, Benjamin Beichler wrote:
> Am 19.09.2024 um 16:22 schrieb Benjamin Berg:
> > > Could this also eliminate/address the busy-loop hack in timer_read in
> > > time.c?
> > Hmm, I was considering changing the other hack in handle_syscall to
> > also use this approach.
> >=20
> > But, I don't think the timer_read hack can be removed. In the case of
> > userspace reading the time, it should not see the difference of the
> > sched_clock. So even though the process would start use CPU time, the
> > realtime clock should not change and python would continue to busyloop.
> > the actual clock ticks.
>=20
> Okay, I think you are right.
>=20
> Nonetheless, my proposal would be anyway to shift the advance of the=20
> realtime clock only into user space systemcalls and not every function=
=20
> in the kernel, that reads the timer.
>=20
> I made ages ago the mediocre proposal to check the syscall number here,=
=20
> to detect "malicious" user space programs doing busy loops.

And now here I am proposing another form of "malicious" userspace
detection =E2=80=A6

> For "clean" semantics of a simulative execution of the kernel, it feels=
=20
> erroneous to advance time even if this value is only read once.
>=20
> In my experiments timer_read was called much more often than I=20
> anticipated (e.g., filesystem code).

Yeah, that does not really sound like something we would want (and it
will also not help with performance with time-travel=3Dext).

Looking at the old discussion, it doesn't seem that Johannes was
against the idea of doing the time insertion only in more specific
scenarios. So, we "just" need a reasonably elegant solution.

If we accept writing a list of syscalls, then maybe we could just do it
within handle_syscall and do a um_udelay(1) for any syscall that takes
a timeout parameter (select, pselect6, poll, ...)? It is going to be a
pretty long list, but could still be reasonable.

One neat side effect is that if reading time does not actually cost
time, then we could implement clock_gettime in the VDSO.

Benjamin

