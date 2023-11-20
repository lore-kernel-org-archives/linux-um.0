Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD6EC2BB3F
	for <linux-um@archiver.kernel.org>; Mon, 20 Nov 2023 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C+8XdKPHTSK2oDxcwxtM2XIvXSg65ayIY133vHlFBwc=; b=Z7MzspBrh8jsHM
	wrvJt4R4vGzAq00e3dt6OnlsXSvFykoq2oXlEe9DzRNHfu6HytSlCtharrNe/XmP5WSJhEblIbJVL
	ikC6IbhiizvTRGJcPM7B4k46VKKqkDFPe5JoWHBK8dP1chT97J2sZzztYOsHTf4u0R8KssVIVxSrF
	Qvgi0HPdvsT2lIvkSnAqDAwlHg5SX5ckj49b1JPV+WVVKWm/UGrOdnIu1shzXXI5OkRX5ohe6UXBn
	38wO4bv6P4VOfBCp/daoVexDnRlfzgbyScZJC2E3EoA1SIVlVTTbyqVtc0WZRaivXmGuDHUJnVeKx
	2n6cjFl9ZN6O7kBLfaOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r54Xl-00CAsy-26;
	Mon, 20 Nov 2023 13:42:29 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r54Xa-00CAot-20
	for linux-um@lists.infradead.org;
	Mon, 20 Nov 2023 13:42:27 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Mon, 20 Nov 2023 13:42:07 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1700487727; bh=YnSd9WKnuZfPIGf8UsSBHOgp1qS0p16N3wn9TXWdkTw=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 2XPX69o3U79fOFV4mc2XcR8I2AmZk2/IjK3i0KwJQZ9x+5kLw2lQQwzA7+GuJfq7bruioKD68Al0vL6mFHXWAA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1700487727; bh=YnSd9WKnuZfPIGf8UsSBHOgp1qS0p16N3wn9TXWdkTw=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 PLYNh0qvw6ZlhhMaVFvual58Xd9bhZpaSZSpeXmW4fhni7HU49JnimybqKcvd9UlmgCJ5kg0iPV0EnkYJi+FDHT36+R3VHEt5oUOboXC49UEviRvp9AO5afGwvxifa0vdPpchcHRx+p8Db+8qcz1aSRB02x+UJXD0+bNobCNeC8=
Received: from [139.30.201.32] (139.30.201.32) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 14:42:03 +0100
Message-ID: <59c73b3c-a86a-41a5-b84a-10522f22c2bb@uni-rostock.de>
Date: Mon, 20 Nov 2023 14:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/11] um: Use a simple time travel handler for line
 interrupts
Content-Language: de-DE
To: Johannes Berg <johannes@sipsolutions.net>, Richard Weinberger
	<richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
CC: <linux-um@lists.infradead.org>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
 <20231103-bb-timetravel-patches-v1-3-e2c68efcf664@uni-rostock.de>
 <71657ebd4a582b1a3c876de4d778ff67bd29c49d.camel@sipsolutions.net>
 <15d63c81-9e41-4965-b988-c4a934aecc52@uni-rostock.de>
 <9d7509efed4292891b4ffbf063ae58f11af8b742.camel@sipsolutions.net>
 <c83d1520-277f-45a9-beff-3c65e63dfc7c@uni-rostock.de>
 <9c7f83b15bd2c293c7ee0933d33fd9f294f11c87.camel@sipsolutions.net>
 <9cdce089539f8f41d01c8ca8097a6e37aab81927.camel@sipsolutions.net>
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=C3=A4t_Rostock?=
In-Reply-To: <9cdce089539f8f41d01c8ca8097a6e37aab81927.camel@sipsolutions.net>
X-Originating-IP: [139.30.201.32]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 56BE444B4445F1F0B268DFF46AADB9954A402EF5EBC7972E478AAD6A1BB881D92000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_054220_530049_1015BC63 
X-CRM114-Status: GOOD (  30.96  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Am 13.11.2023 um 22:57 schrieb Johannes Berg:
>
> So maybe for my future self and all the bystanders, I'll try to 
> explain how I see the issue that causes patches 4, 6, 7 and 8 to be 
> needed: 
--- snip ---
Hello Johannes,
Sorry for my delayed response to your detailed email. I find it quite 
hard to discuss such a complex topic via mailing lists without it 
sounding impolite.

Maybe also as some basis for my reasoning: I'm quite familiar with 
discrete event-based simulation, with a special focus on SystemC 
simulation.There are
some common (old) principles of DES that map perfectly to the time 
travel mode, so my mental model has always been shaped around those 
constraints.
- Every instance/object/element in a DES has some inputs/signals that 
activate it either at the current moment or at some later point in time.
- Every instance/object/element in a DES will run, starting from its 
activation time until it has "finished", without advancing the global 
simulation time.
- Events (or activations) occurring at the exact same point in 
simulation time would happen in parallel. Therefore, the actual order of 
execution in a
sequential simulator is more or less unimportant (though some 
implementations may require a deterministic order, ensuring simulations 
with the same
parameters yield the exact same output, e.g., SystemC). The parallel 
execution of events at the same time in the simulation is an 
optimization that
may be implemented, but is not always utilized.


After reviewing all your analyses, I believe the most significant 
difference in my implementation lies in the last point. I did not 
enforce the order
of message processing when they occur exactly at the same simulation 
time. Consequently, I modified my implementation to eliminate the 
synchronous
(and, to be honest, quite hacky) read operation with special handling on 
the timetravel socket. Instead, I implemented a central epoll routine, which
is called by my master simulation kernel (NS3). My rationale was that if 
I haven't received the request from the TT-protocol, I cannot advance time.


In conjunction with running not a single UML instance but many (my 
current use case consists of a 10-node pair == 20 UML nodes), this can 
create all
sorts of race/deadlock conditions, which we have identified.
For me, the ACK of vhost/virtio seemed somewhat redundant, as it 
provides the same information as the TT-protocol, assuming my device 
simulation
resides within the scheduler. I must admit my assumption was incorrect, 
primarily because the implementation of the TT-protocol in the kernel is
somewhat fragile and, most importantly, your requirement that 
***nothing***is allowed to interfere (creating SIGIOs) at certain states 
of a time-traveling
UML instance is not well-documented. We need the ACK not for an 
acknowledgment of registering the interrupt but to know that we are 
allowed to send the
next TT-msg. This very tight coupling of these two protocols does not 
appear to be the best design or, at the very least, is poorly documented.
The prohibition of interference in certain TT-states also led to my 
second mistake. I relaxed my second DES requirement and allowed 
interrupts when
the UML instance is in the RUN-state. This decision was based on the 
impression that UML was built to work this way without TT, so why should it
break when in TT-Mode (which you proved was wrong). Whether this is 
semantically reasonable or not can be questioned, but it triggered technical
problems with the current implementation.

With this realization, I tend to agree that maybe the whole patches to 
ensure thread-safe (or reentrant-safe access) of the event list might be 
dropped.
Still, we should ensure that the SIGIO is simply processed synchronously 
in the idle loop. This aligns with my last DES constraint: since everything
happens at the same moment in simulation time, we do not need "real" 
interrupts but can process interrupts (SIGIOs) later (but at the same 
simulation time).
I think this approach only works in ext or cpu-inf mode and may be 
problematic in "normal" timetravel mode. I might even consider dropping 
the signal handler,
which marks the interrupts pending, and process the signals with a 
signalfd, but that is, again, only an optimization.
Additionally, to address the interrupt acknowledgment for the serial 
line, I'd like to propose this: why not add an extra file descriptor in the
command line, which is something the kernel could write to, such as an 
eventfd or a pipe, to signal the acknowledgment of the interrupt. For 
example, the
command line changes to ssl0=fd:0,fd:1,fd:3. If somebody uses the serial 
line driver with timetravel mode but without that acknowledgment fd, we 
can emit
a warning or an error.

I believe all these changes should work well with the shared memory 
optimization and should make the entire time travel ext protocol a bit 
more robust,
easier to use, and harder to misuse. ;-)

However, even after the lengthy discussion on "when" interrupts should 
be processed, I still hold the opinion that the response to raising an 
interrupt
should be immediate to the device simulation and not delayed in 
simulation time. This only makes the device simulation harder without 
real benefit. If
you want to delay the interrupt handling (ISR and so on), that's still 
possible and in both situations highly dependent on the UML 
implementation. If
we want to add an interrupt delay, we need to implement something in UML 
anyway. If you want to delay it in the device driver, you can also always do
it, but you are not at the mercy of some hard-to-determine extra delay 
from UML.

Overall, if you think that makes sense, I could start on some patches, 
or perhaps you feel more comfortable doing that.


Benjamin



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
