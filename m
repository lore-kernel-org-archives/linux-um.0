Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5EFC4332F
	for <linux-um@archiver.kernel.org>; Mon, 13 Nov 2023 21:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wW0lDeZEKoPMkXVrxtKmBlidquli3H6PmSBPMIvlmtE=; b=2ebR4cGFifSSBZ
	l1zd2CVfdehPlm8dQtYVzOxzm9N3ZNQ35/XGuluKFJ9wOKcH2AqU2bQCLLDOIkO2iWrX8aeipKQJE
	GYfcpPxPjHvC7LCSBKoyosKU65AYUJ49r+MaCPPoRyxNgXQ+YHVmHFOOMsR9R86PZDV2LHbHVoJ3Z
	0FolbdkToaVb79DNxbogVe4pW5jaumFTS4pm+ofU4ODY3ip4sXZ7bFGfskinwPF1UsDxOaFzsLV7r
	5wcLvrAJbpsJaxuH77YjZsYREW076FwUbtJbK8/NmKnrXzg1cUw2oE+j3/gPgBd2bolm2F2rokwcl
	TxiCeEIKIeTsYEwQOfow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2ewR-00Elkc-1m;
	Mon, 13 Nov 2023 21:57:59 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2ewN-00ElkB-2R
	for linux-um@lists.infradead.org;
	Mon, 13 Nov 2023 21:57:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SPbaalgEQf1Fi/hrTKf/0PhPtvH1kQO5KywV7hB1tAc=;
	t=1699912675; x=1701122275; b=QQkL4EaFni3PCRXhSOhRAjf3QzhBwDCqm4S7VD+IJo//kqx
	NvdiX/s8UaA8kGh5+qxgtTyMXdFWc1CmlUn/4wul2vbswUUfw8ER7t1/0qcePmRIyXvKuLvSZYy4i
	MxIyfXw7TL3P3RynS9yBno/clHXKgiAj3lHo3Cgd3C7bKxT9gRu65KJ5pjhoSA7ARVAHJYmYvsuAo
	Lx329sMooB4GYQlXd2K/9NmbS25UD1wm6BPyDKQok1oBUfVFyBDklwdsQezNTACrjk36GX6gZUsPw
	qImrH6bjcNvNid/k8pGEyzv1r92BC9UEiDWfsPHMJvG1qHoJ38wjKX3jhNpGF4jQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r2ewL-00000006wwS-0ZXI;
	Mon, 13 Nov 2023 22:57:53 +0100
Message-ID: <9cdce089539f8f41d01c8ca8097a6e37aab81927.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 03/11] um: Use a simple time travel handler for line
 interrupts
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Date: Mon, 13 Nov 2023 22:57:51 +0100
In-Reply-To: <9c7f83b15bd2c293c7ee0933d33fd9f294f11c87.camel@sipsolutions.net>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
	 <20231103-bb-timetravel-patches-v1-3-e2c68efcf664@uni-rostock.de>
	 <71657ebd4a582b1a3c876de4d778ff67bd29c49d.camel@sipsolutions.net>
	 <15d63c81-9e41-4965-b988-c4a934aecc52@uni-rostock.de>
	 <9d7509efed4292891b4ffbf063ae58f11af8b742.camel@sipsolutions.net>
	 <c83d1520-277f-45a9-beff-3c65e63dfc7c@uni-rostock.de>
	 <9c7f83b15bd2c293c7ee0933d33fd9f294f11c87.camel@sipsolutions.net>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231113_135755_945693_7D94932F 
X-CRM114-Status: GOOD (  39.68  )
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

On Mon, 2023-11-13 at 22:22 +0100, Johannes Berg wrote:

> > My suggestion was to add the virtual interrupt line 
> > state change as a message to the calendar.
> 
> Yes but it doesn't work unless the other side _already_ knows that it
> will happen, because it broke the rule of "only one thing is running".
> 
> Again you can argue that it's fine to return to the calendar even if the
> receiving process won't actually do anything, but because the receiving
> process is still thinking about it, you end up with all the contortions
> you have to do in patch 4 and 7 ... because even the _calendar_ doesn't
> know when the request will actually come to it.
> 
> Perhaps one way of handling this that doesn't require all those
> contortions would be for the sender of the event to actually
> _completely_ handle the calendar request for the interrupt on behalf of
> the receiver, so that the receiver doesn't actually do _anything_ but
> mark "this IRQ is pending" in this case. Once it actually gets a RUN
> message it will actually start running since it assumes that it will not
> get a RUN message without having requested a calendar entry. If the
> calendar entry were already handle on its behalf, you'd not need the
> request and therefore not need the special handling for the request from
> patch 4.
> You'd need a different implementation of patches 2/3, and get rid of
> patches 4, 6, 7 and 8.
> 

So maybe for my future self and all the bystanders, I'll try to explain
how I see the issue that causes patches 4, 6, 7 and 8 to be needed:


Actors: UML, ES (Event Sender), Cal (Calendar)

In UML, we're using a line-based protocols as in drivers/line.c
The ES is connected to that line and can send it messages.
(The same scenario would probably apply the other way around, in theory,
so we might need to have a way to implement this with roles reversed.)

Let's start by sending a message to UML, that's the whole point of this
discussion:

    ES ---> UML
    // so far nothing happened, the host kernel queued SIGIO to UML
    ES: continues running until idle and returns to Cal

Now we already have a few options, and I don't know which one got
implemented.

A. Perhaps ES also told Cal to expect that UML is running:
    Cal ---RUN--> UML

B. Perhaps Cal just asks everyone what their current request is
    Cal ---GET--> UML

C. Perhaps something else?

In any case, we already see a first race here, let's say A happened, and
now:

    ! SIGIO -> UML
    UML calls simple_timetravel_handler -> time_travel_add_irq_event
    UML ---REQUEST--> Cal
    UML <----RUN----- Cal
    // UML really confused -> patch 4

Or maybe:

    UML <-- RUN ----- CAL
    UML: starts running, starts manipulating time event list
    ! SIGIO -> UML
    UML calls simple_timetravel_handler -> time_travel_add_irq_event
        manipulates time event list
    // UML corrupts data structures -> patch 8

Or:

    UML <-- RUN ------ CAL
    UML runs only really briefly, sends new request,
        time_travel_ext_prev_request_valid = true
    ! SIGIO -> UML
    UML calls simple_timetravel_handler -> time_travel_add_irq_event
        time_travel_ext_prev_request_valid == true
    // no new request, Cal confused -> patch 6, and maybe 7


Not sure if that's really all completely accurate, and almost certainly
there are more scenarios that cause issues?

But in all cases the root cause is the asynchronous nature of doing
this; partially internally in UML (list protection etc.) and partially
outside UML (calendar doesn't know what's supposed to happen next until
async SIGIO is processed.)

In contrast, with virtio, you get

    ES -- event ----> UML
    // so far nothing happened, the host kernel queued SIGIO to UML
    // ES waits for ACK
    ! SIGIO -> UML
    UML calls simple_timetravel_handler -> time_travel_add_irq_event
    UML ---REQUEST--> Cal
    UML <--ACK------- Cal
    ES <---ACK------- UML
    ES: continues running until idle and returns to Cal
    Cal: schedules next runnable entry, likely UML

Note how due to the "// ES waits for ACK" nothing bad happens, because
even if the host doesn't schedule the SIGIO immediately to the UML
process, or that needs some time, _nothing_ else in the simulation makes
progress either until UML has.

IMNSHO that's the far simpler model than taking into account all the
potential races of which I outlined some above and trying to work with
them.



Now then I went on to say that we could just basically make it _all_ the
sender's responsibility on behalf of the receiver, and then we'd get


    ES -- event ----> UML
    // so far nothing happened, the host kernel queued SIGIO to UML
    ES -- add UML --> Cal
    ES <--- ACK ----- Cal
    ES: continues running u8ntil idle and returns to Cal
    Cal: schedules next runnable entry, likely UML

Now the only thing we need to handle in terms of concurrency are two
scenarios that continue from that scenario:

1.
    Cal --- RUN ----> UML
    ! SIGIO -> UML

and

2.
    ! SIGIO -> UML
    Cal --- RUN ----> UML

Obviously 2 is what you expect, but again you can even have races like
in 1 and the SIGIO can happen at roughly any time.

I'm tempted to say the only reasonable way to handle that would be to
basically not do _anything_ in the SIGIO but go poll all the file
descriptors this might happen for upon receiving a RUN message.

We could even go so far as to add a new RUN_TRIGGERED_BY_OTHER message
that would make it clear that someone else entered the entry into the
calendar, and only then epoll for interrupts for this message, but I'm
not sure that's needed or makes sense (if you were going to wake up
anyway at that time, you'd still handle interrupts.)

In any case, that feels like a _far_ more tractable problem, and the
only concurrency would be between running and the SIGIO, where the SIGIO
basically no longer matters.



However ... if we consider this the other way around, we can actually
see that it's much harder to implement than it sounds - now suddenly
instead of having to connect the sockets with each other etc. you also
have to give the implementation knowledge about who is on the other
side, and how to even do a calendar request on their behalf! We don't
even have a protocol for doing a request on someone else's behalf today
(though with the shared memory you could just enter one), and actually
changing the protocol to support it might even be tricky since it
doesn't have much space for extra data in the messages ... maybe if we
split 'op' or use 'seq' for it... But you'd need to have a (pre-
assigned?) ID for each, or have them exchange IDs over something,
ideally the socket that's actually used for communication, but that
limits the kinds of sockets you can use, etc. So it's by no means
trivial either. And I understand that. I just don't think making the
protocol and implementations handle all the races that happen when you
start doing things asynchronously is really a good idea.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
