Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A203FC001DF
	for <linux-um@archiver.kernel.org>; Fri, 20 Oct 2023 12:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CXLXDEtFLlsbZtL5eItADfdM3vwqW1UiIlov+DhNwLA=; b=NRNuPthv+FxcjDdnImtRL4oKEb
	D5Rs7N71AgShmH7Vsy5vHJTmbJoXEiRlF/keM4+yA7trzs8T1Q0Yg4kSGfli28dhDdfSrzug0SNlo
	8WG5vRKRZ8P6w0ywhvUnrpgtOi4s+EfdiRRm3qd5C9HRgsjP7rLbXSqFO8YxFYUjbaMxTw3tGuH3Q
	FV6s3wBCiGfgKheIPwm1WyGJS0Z9e6rCaVKOizQ8zLApLh4cKAQas6BTHXJlKgab2WwOyYLnIXpUb
	OLTc0mO4qy5mSTb8+ACtXcRb8INtNel6nEAh4zJYooy8/mpAEJFmlM/23V+iYWxWmy83KgYEFdt45
	LdMglMSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtp5b-002ILw-0L;
	Fri, 20 Oct 2023 12:58:55 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtp5X-002IKB-1J
	for linux-um@lists.infradead.org;
	Fri, 20 Oct 2023 12:58:53 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 20 Oct 2023 12:58:48 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1697806728; bh=AxLYUDCmrtp9OooCBsUohoGXGBXkeObOujxS8td13Eo=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 SmFAmGijPPEPXMkNv7NLA9oJRdDdBPyAqJHgwREcKBV5wgHnEAqiS8s9siiNpNkyxlolvuGJIfjeX1zyeoorDg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1697806728; bh=AxLYUDCmrtp9OooCBsUohoGXGBXkeObOujxS8td13Eo=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 k6CJw7FwKgmjdvnKwWdyLA3wfxH6Kjwb+tFHmnD80DVEkQ0DUy4Bq7P/97iokXPNWPWhn4R6qWswRTfCw1BSWvcmTINuNE9HKcOutp5Ys7q7Mji8Jp+AxeNFNd5aNSYEXSHCh5vifeZHiCUzce6lxQTz8tfdvSwxak+q1eEfHK4=
Received: from [139.30.201.32] (139.30.201.32) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 20 Oct
 2023 14:58:47 +0200
Message-ID: <93c958e1-a0ed-4787-adad-12c6f96c9999@uni-rostock.de>
Date: Fri, 20 Oct 2023 14:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
Content-Language: de-DE
To: Johannes Berg <johannes@sipsolutions.net>, <linux-um@lists.infradead.org>
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
 <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
 <11ab4d47dd8fdcdc2148e00618cc496866016883.camel@sipsolutions.net>
 <549de9c0-05f8-437e-8460-5b013b0cd87b@uni-rostock.de>
 <348de3de5cbd6df96ac51bb07d6e485b2ecc5cc8.camel@sipsolutions.net>
 <d77b66af-249d-4dd1-b78f-730d252bcf84@uni-rostock.de>
 <10c4e61c2e62ba12cf88ddecd84271c5788c1e6b.camel@sipsolutions.net>
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=C3=A4t_Rostock?=
In-Reply-To: <10c4e61c2e62ba12cf88ddecd84271c5788c1e6b.camel@sipsolutions.net>
X-Originating-IP: [139.30.201.32]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 0906B6D2359AD22B92441A905F1E46E5175302BA3CE66E740434161E9B0ED99C2000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_055851_778551_64F5C432 
X-CRM114-Status: GOOD (  31.57  )
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

> On Fri, 2023-10-20 at 14:06 +0200, Benjamin Beichler wrote:
>> Am 20.10.2023 um 13:39 schrieb Johannes Berg:
>>> On Fri, 2023-10-20 at 12:38 +0200, Benjamin Beichler wrote:
>>>> Can you explain, why a time travel handler for stdin may be bad? It
>>>> sounds like you want to avoid it, but I see no immediate problem.
>>>>
>>> I need to read the thread, but this one's easy ;-)
>>>
>>> The thing is that on such a channel you don't send an ACK when you've
>>> seen that there's something to handle. As a result, the sender will
>>> continue running while you're trying to request a new schedule entry
>>> from the controller. As a result, it may run past your new schedule
>>> entry because it didn't know about it yet (this would likely bring down
>>> the controller and crash the simulation), or the relative order of the
>>> two entries is undefined, in the sense that it depends on the process
>>> scheduling of the host.
>> Sorry, but I did not get this. What may run past the schedule entry? Is
>> your assumption, that the "thing" connected to stdin is always totally
>> unaware of the time travel mode?
> No, I'm not assuming that, if that's done all bets are off anyway. I'm
> assuming that both are connected to the controller.
>
>> When our (to be published) simulation send something on serial lines (I
>> think it does not matter whether it is a socket or a pipe), we expect
>> that the uml instance needs to be run as long as it changes back to
>> idle/wait state before the simulation time is advanced. Since the basis
>> model of the time travel mode is, that you have infinite amount of
>> processing power, the interrupt needs to be always handled at the
>> current time.
> Yes but you need to schedule for the interrupt, and you don't
> necessarily know what 'current time' is at interrupt time.
>
> So let's say you have "something" that's scheduled to run at times
>   - 1000
>   - 2000
>   - 3000
>
> and free-until is 10000 or something high.
>
> Now it sends a message to Linux stdio at 1000.
>
> But it doesn't have a way to wait for ack. So it continues, checks the
> schedule and free-until, and can advance time to 2000 since it doesn't
> yet know Linux requested time to run at 1000.

Do I get it right, that you anticipate that all parts of the simulation 
may run at different paces and the controller is only needed for 
synchronization?

My mind model is, that simulation time advances in the controller are 
only done, If all parts of the simulation reached the current simulation 
time and are at the event processed/idle/wait state. Therefore, the 
thing connected to stdio will not advance to some other time, if some 
other component has outstanding events (i.e., an interrupt at this 
case). Of course free-running is a problematic in this mind model, but 
in this mode you willingly sacrifice the precision of events for 
performance.

>
> This gives you something not predictable - it depends on the host
> scheduling, whichever ran first (Linux started next or the other
> continued, or both and it gets messed up).
>
>> Maybe my think-model only holds for "smaller" amounts of data (maybe one
>> page or something?) or not the free-running mode, but I'm not completely
>> convinced. :-D
> Nah it doesn't really matter how much data there is.
>
>> Maybe we need to define, a bit more formally, how the (designed)
>> processing model of interrupts in time travel mode is.
> That's probably a separate Master's thesis ;-)

It could, but some basic definition for a common understanding might help.

However, do you like to have a look at my current state of time travel 
changes in github or do you think an RFC to the mailing list is better? 
I like github for a quick dive into patches, but your whole workflow is 
maybe different ;-)



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
