Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808C6C7115C
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 16:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mu+JBFMxFcmkWvemWRejcBfCpbK0S9r03CkeNyEZeTc=; b=ygqLc6zDV686yyggbdrXRq40rx
	1+2FNVZUB+4JgkBF6CPL4Wfb2YcbHJrcLB/qqSrozgiR/91tX+iS8EEjqZAUITliqBPp9uRZBdTc9
	ouubo/c0//GXcQPRRxCDYrms20mYu8s/a3MdUF3OYhLTmDMezPfEHWmHgz/hF9QJLkmSjH9DFT9QF
	5aiX2/iim3/Uyi4MptpFK7imBSmDk6Mv6vafCcrRM9BDx+HHi2igxIxPOg0f0wwwTCIkbAWEMu8vb
	efVCLnAoDQBlyBBIADERw0Ci+DcLTWy2FKVQyrNC0sRiNTbw3zrve/CEURo6r3cd0CcOdcBRJ6daa
	ZOHdsL1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUT3E-00000009JfG-17ig;
	Wed, 25 Jun 2025 16:32:44 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUPHm-00000008dDX-1Frk
	for linux-um@lists.infradead.org;
	Wed, 25 Jun 2025 12:31:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mu+JBFMxFcmkWvemWRejcBfCpbK0S9r03CkeNyEZeTc=;
	t=1750854689; x=1752064289; b=YFdEqIEfUFVrRyS6gnWtJoLjPywmMi1AH0sBS7RYki7sAv3
	Uqtu0kapvr9DouIqDsOoswlD/+AW0EdXkFVel/Asr6k0JFkkh0FtpH+g4smRUEBW6B395BkQefwXJ
	6hNhCGO/IGgeg4aVuCtlCYMKLyiE8DKdW+Ouyu9imKmw8zvOClrlG2qgZW0TepbrgHoatF4TMqxRw
	yktiMwKH5XzCQPYEtFjEYbN2uPGni6gjkCBAvKgtzC6ZMXD1yXVi1V51LkjMZQIFP7QNbp65ryDvQ
	aVdsHhBlg/5IAOo4fYNeO+CO1ZxU8hdiSijzYyiVC3GQ6gZH4cAJ+wGV1/T05Njg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uUPHh-00000009yMk-3tw7;
	Wed, 25 Jun 2025 14:31:26 +0200
Message-ID: <0e5eeb22a56e92ff377fcfb0cc0e768d71ed4ae9.camel@sipsolutions.net>
Subject: Re: [PATCH RFC] um: time: fix userspace detection during tick
 accounting
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Richard Weinberger	 <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg	
 <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Meyer
	 <thomas@m3y3r.de>, Anton Ivanov <aivanov@brocade.com>
Date: Wed, 25 Jun 2025 14:31:24 +0200
In-Reply-To: <20250617-uml-tick-timer-v1-1-01aab312f56b@linutronix.de>
References: <20250617-uml-tick-timer-v1-1-01aab312f56b@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_053130_335403_0826164E 
X-CRM114-Status: GOOD (  24.95  )
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

On Tue, 2025-06-17 at 15:52 +0200, Thomas Wei=C3=9Fschuh wrote:
> The cpu usage timekeeping triggered by the tick credits passed time to
> either the kernel or the currently running userspace process.
> On UML, tick interrupts firing while userspace is running are not marked
> correctly so this bookkeeping is broken and always credits the idle task.
>=20
> The rootcause is the following callchain always passing user_tick=3Dfalse
> to account_process_tick():
>=20
> um_timer()
> =C2=A0 -> handle_irq_event()
> =C2=A0=C2=A0=C2=A0 -> tick_handle_periodic()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> tick_periodic()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> update_process_times(user_t=
ick=3Duser_mode(get_irq_regs()))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> account_process=
_tick(task, user_tick=3Dfalse)
>=20
> As a result CPUCLOCK_VIRT does not advance,
> breaking for example signal(SIGVTALRM).
>=20
> The issue can be reproduced easily with the selftest
> tools/testing/selftests/timers/posix_timers.c,
> which hangs in the ITIMER_VIRTUAL/SIGVTALRM testcase.
>=20
> Fix up the IRQ regs by correctly setting is_user in the IRQ registers.

So, in principle, this looks like the right thing.

What I am not sure about is accounting if the userspace task is
currently executing a syscall inside the kernel thread. The current
code will incorrectly interrupt the userspace process in that case and
you are now adding CPU time accounting on top of the same logic that is
already not quite right.

Said differently, need to think about it a bit more. I suspect we might
need to set/clear a flag in the userspace function for this.

Benjamin

>=20
> Fixes: 2eb5f31bc4ea ("um: Switch clocksource to hrtimers")
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
> I'm not familiar with UML, so this is probably not the right fix.
> Feel free to treat it as a bugreport instead.
> ---
> =C2=A0arch/um/kernel/time.c | 7 ++++++-
> =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
> index ae0fa2173778f43273fd0550f77fc99bbb1c3e3a..a6c17302403aeb3170a110411=
7c4e713e3afdfe0 100644
> --- a/arch/um/kernel/time.c
> +++ b/arch/um/kernel/time.c
> @@ -856,6 +856,7 @@ static struct clock_event_device timer_clockevent =3D=
 {
> =C2=A0
> =C2=A0static irqreturn_t um_timer(int irq, void *dev)
> =C2=A0{
> +	struct pt_regs *regs;
> =C2=A0	/*
> =C2=A0	 * Interrupt the (possibly) running userspace process, technically=
 this
> =C2=A0	 * should only happen if userspace is currently executing.
> @@ -864,9 +865,13 @@ static irqreturn_t um_timer(int irq, void *dev)
> =C2=A0	 */
> =C2=A0	if (time_travel_mode !=3D TT_MODE_INFCPU &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 time_travel_mode !=3D TT_MODE_EXTERNAL &&
> -	=C2=A0=C2=A0=C2=A0 get_current()->mm)
> +	=C2=A0=C2=A0=C2=A0 get_current()->mm) {
> =C2=A0		os_alarm_process(get_current()->mm->context.id.pid);
> =C2=A0
> +		regs =3D get_irq_regs();
> +		regs->regs.is_user =3D true;
> +	}
> +
> =C2=A0	(*timer_clockevent.event_handler)(&timer_clockevent);
> =C2=A0
> =C2=A0	return IRQ_HANDLED;
>=20
> ---
> base-commit: 9afe652958c3ee88f24df1e4a97f298afce89407
> change-id: 20250617-uml-tick-timer-82ea89495cc6
>=20
> Best regards,


