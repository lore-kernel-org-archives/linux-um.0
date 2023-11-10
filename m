Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302ACC4332F
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 18:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y9jipEBCcF/WnfEazoiZ1sD0aOI2i1NUAxGdqQIz8dM=; b=pM8Ic76/OiTAxE
	ezyNunLKf8ArqrS9yOF2wLLKRK0tXxV5Q1cWBXvmIYAMKdChrH7zb0DSACw4DiYNhLH4cAAAgmRid
	yEXXU+kpvpkUIwgcdpkZCkr5l4SocGdc4NbNGfZdGqpY0H9O8E5iDXKZsilfiTT4u33dy6xLp9oX9
	sCQtwlCNvaJva/qqyais2W1Bw2MVcD8ImMhTRrfrpuyaitLTKSsw9/HU5AQNN7uwxtIZtm4MLaUp9
	6+BI92+3NvFQVWJRgfJe0RazEfGquvBaROUtxlWarXPJFZXvkU8Ql4AncWZ1qig6JK/kWzIFY8yDu
	jKwr5NvZcA+VGcUaDOow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1WSM-009Fda-0d;
	Fri, 10 Nov 2023 18:42:14 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1WSI-009Fcd-1X
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 18:42:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/K8QXTulra+klmhku7IMDjV1b0a+orC3IMvjF1nDZ2k=;
	t=1699641711; x=1700851311; b=DYD/Wij4IBzYckqrH6vYPVeKz45dON/ruWP5/ZIcnXwp0gc
	ahpJJD/50NLg+vby8yu0eOceuH/wNM+x8ph54bE63DvNfnAigLQieVBXqXGes5a4lLtDCrALMSO9p
	tL8Cp1ofQnwuy9ndfsWv5HVfpxKpA0WYRMGI5TyqelQM24WhHzQJ86BEgq8+eQehwKlvQIPgTGcoI
	YQptRz20IbVspchv8U78TG8SYMQkzygciDBBGbuL3goe71SUmG3YnE/IXc4cTVX+z/uWpDEndYgtc
	qQXwQCZebtlhRyVqiWMWk0hWPwkfHE8mlu/Nu8E59fH8pe/FvLk7pNclmH1htmGA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r1WRx-0000000390b-13kL;
	Fri, 10 Nov 2023 19:41:49 +0100
Message-ID: <434592a91c1c7def768d6986ef263e65b8fb1241.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 04/11] um: Handle UM_TIMETRAVEL_RUN only in idle
 loop, signal success in ACK
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Date: Fri, 10 Nov 2023 19:41:48 +0100
In-Reply-To: <20231103-bb-timetravel-patches-v1-4-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
	 <20231103-bb-timetravel-patches-v1-4-e2c68efcf664@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_104210_691492_8806DD01 
X-CRM114-Status: GOOD (  43.41  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

So I guess now you reminded me of this thread ...

> The Timetravel socket can be read from the SIGIO handler, which may
> catch a RUN message that was expected to be received in the wait loop.
> 
> It can happen that the device simulation only "created" one interrupt,
> but an uncertain (i.e., hard to predict by the calendar/device
> simulation) number of SIGIOs are emitted, with each SIGIO interrupt
> producing a GET message. The calendar might try to send a RUN message
> after the first GET message, which is then processed in the SIGIO
> handler, waiting for the response to a subsequent GET message. However,
> time is advanced by the received RUN message. Typically, this doesn't
> pose problems because the interrupt implies that the next RUN message
> should be at the current time (as sent by the calendar with the GET
> message). But there are corner cases, such as simultaneous other
> interrupts, which may desynchronize the current time in the UML instance
> from the expected time from the calendar. Since there is no real use
> case for advancing time in the SIGIO handler with RUN messages (in
> contrast to UPDATE messages), we logically only expect time to advance
> in the idle loop in TT-ext mode. Therefore, with this patch, we restrict
> time changes to the idle loop.

OK, that mostly makes sense, so far. Although IIUC now you lost the time
update, so you have to recover from that again somehow when you actually
do the RUN (which we don't do from the SIGIO handler).

> Additionally, since both the idle loop and the signal/interrupt handlers
> do blocking reads from the TT socket, a deadlock can occur if a RUN
> message intended for the idle loop is received in the SIGIO handler. In
> this situation, the calendar expects the UML instance to run, but it
> actually waits for another message, either in the SIGIO handler (e.g.,
> a second interrupt) or in a poll in the idle loop, as the previous
> message was handled by the signal handler, which returned execution to
> the main loop and ultimately entered the idle loop.

I'm not sure I understand this part. How can you get a RUN message when
someone else is still running and sending you interrupts? Or are you
sending interrupts (with time travel handlers because of patch 3?) from
_outside_ of the simulation?! I guess that'd be a case of "don't do that
then"? :)

Or ... I'm still wrapping my head around the system you built ... are
you saying that interrupts are actually delayed and we have something
like this:

Participant A   --- message ----------------> UML (socket)
Participant A   --- WAIT --> calendar
                                  SIGIO ----> UML
calendar        <-- GET --------------------- UML (time_travel_handler)
calendar        --- RUN --------------------> UML
                                              (reads "RUN" instead
                                               of GET response)

But then that's again just because "you're doing it wrong", Participant
A should be waiting for an ACK message? At least that was the intent.
You're not using it that way with the line interrupts.

But honestly, I think that's just another reason not to do things the
way you're doing in patches 2 and 3.

> Therefore, this patch also allows checking whether the current RUN
> message was handled by the idle loop or by the signal/interrupt handlers
> in the ACK of the RUN.
> 
> With the information in the ACK of the RUN message, the calendar knows
> whether the RUN was answered in a signal handler and can act
> accordingly.

TBH, I don't like this at all. If I'm not completely off with my
analysis above (or it's a similar situation), this just puts workaround
requirements on the calendar because you don't synchronise communication
in _other_ parts of the system properly.

In the simulation that we had intended to build, the exact timing of the
SIGIO wouldn't matter because UML would _always_ be in WAIT state when
getting SIGIO, and would always have to fully process the SIGIO (and
send an ACK on the respective socket) before the other side continues
and we can get to any other part of the system.

That's a pretty fundamental rule of the system because it allows us to
reason how information flows, which part can be doing what at which
time, and (mostly) ignore the inherently asynchronous nature of today's
computing in the system, since things are always locally serialised.

You broke that rule, and the system is coming apart at the seams. You
already found - as I pointed out in the other email - that you now have
to some assumptions on the sender side of the message about how the
interrupt processing will be done on the receiver (although that
assumption is perhaps not more than "may be immediate so I need to
return to the calendar").

You also found that when you broke that rule, you got other asynchronous
things going on, and now need to handle that suddenly you can get a RUN
message inside a SIGIO handler, because that's async and nothing waits
for it to have finished.

I honestly don't believe that removing this rule will do the system good
in the long term. You'll almost certainly find other corner cases - we
still find corner cases in the system _with_ the rule, and that's a
_much_ simpler system.

I also tend to think that the more complex system (without that rule)
will be much harder to optimise. For example, the shared memory table of
run requests (yes yes, I'll send it in a bit), you don't even have a GET
message in time_travel_add_irq_event() any more. In fact you have no
messages at all there! That maybe makes this part easier? But it also
means now you have to reason about why that's actually still OK to not
get the RUN message where you previously expected it, etc.


Or if we consider further optimisations we've been thinking about (but
not implemented yet) - one of them is to use signals for wait/run so we
can hand off running between processes without going through the
calendar (with the calendar still maintaining the new distributed
protocol on behalf of clients that don't participate in a distributed
protocol yet.) Not having the ACK would actually _defeat_ this
optimisation, because you wouldn't actually know who to hand it off to,
only the calendar would be able to do the handoff, since it's the only
one communicating with everyone. With the ACK you know that as soon as
you have the ACK, the shared table must be updated, and you can make the
hand-off decision locally instead of going to the calendar.


So ... I think all of this is an even longer-winded way than the last
discussion over on patch 3 of saying I don't like your simulation model
that doesn't require an ACK, and I don't think we should support it.


FWIW, it really shouldn't be that hard to replace the 'lines' with
virtio serial consoles or so. We've actually done that, we have a
device-side implementation of this:

#define VIRTIO_ID_RPROC_SERIAL          11 /* virtio remoteproc serial link */

(which is really just a virtio console, shows up as /dev/vport*p0 inside
the virtual system, rather than /dev/ssl* or whatever you have there
now.

With the usfstl vhost device abstraction [1] it's less than 150 LOC, and
much of it is boilerplate/struct filling...

[1] https://github.com/linux-test-project/usfstl/blob/main/include/usfstl/vhost.h


Although our implementation only supports a single connection and is
built into whatever generates the messages, if you want multiple UML
instances to communicate you'd have to have an implementation that has a
socket for each and a config file which is connected to where.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
