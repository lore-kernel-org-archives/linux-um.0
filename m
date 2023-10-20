Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E920C001DF
	for <linux-um@archiver.kernel.org>; Fri, 20 Oct 2023 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=biK5w/MjogsjQ9IywVQqhc8MjHu6JWgYNt35HE+yBMc=; b=DKpZ5CSWlQ7i1W
	G0dimLye3u63O2UvKf7y6cB3xQwevcF0D+04gsblRi9L3Ro9Sr2OaxUa1a5TwL7lzePtuuNMWkhF5
	6puaq0Y6oTKnBmtBopk/VCZToZpXcNDTyQQTonKOPCHLh4rZ6k/kc/vd4JX2JJF0UsZuFAgBmEsLK
	7jUcxsNbEm1notJUjiGfuB9VuPqK4u+wTcseFi5wPSIPipiGXPVDSAr80Llg+2CQf2qAwyVAzg/D4
	EjH1IJgLdde8Ic2A35UuQdWAxZpsj/yUrxRRh6fnwR1pW4dd2RUKshAaquTLmqjE+84AyjR/XX/bg
	YwYhwhVEScPzBj19uRrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtoUR-002EMd-1K;
	Fri, 20 Oct 2023 12:20:31 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtoUO-002EMG-2U
	for linux-um@lists.infradead.org;
	Fri, 20 Oct 2023 12:20:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gMFssfVIVBHC8pXuR6atNctjIzV9uf6caaNabibbA6o=;
	t=1697804428; x=1699014028; b=KJvggMLX2EmUXwsdimKMLHdPFG09PL6Nz5t15aUhMeeXj8D
	5yJNEsI77iZgo1EL7wOtZOOhUz0c5soJrD/xLsJAPmudPE8bclT8x6RJG7yXjxmxomvvNZ8VYqC8d
	lg+zDxAAKSYA+bCcGyKYtIA5wZVAHmR9OAfuBW5WxYHf3Vg9/599ILcko48amkoRkbvnCrlTzJpbe
	B6Sx++I6QKwDLTajHmI0lRNvl1vFq5hCnecuo0y1n8oPcUnuotMD1if4oMQx4fnc3LvFyTS1h2h1s
	nzMtRhZ2gfyXcTQoR8Xo9OfgTXOKy4NgW3TsHva/4cz75oo3n8Gn1se/Z0sFCxnQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qtoUM-0000000EXSv-3HD4;
	Fri, 20 Oct 2023 14:20:26 +0200
Message-ID: <10c4e61c2e62ba12cf88ddecd84271c5788c1e6b.camel@sipsolutions.net>
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>, 
	linux-um@lists.infradead.org
Date: Fri, 20 Oct 2023 14:20:25 +0200
In-Reply-To: <d77b66af-249d-4dd1-b78f-730d252bcf84@uni-rostock.de>
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
	 <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
	 <11ab4d47dd8fdcdc2148e00618cc496866016883.camel@sipsolutions.net>
	 <549de9c0-05f8-437e-8460-5b013b0cd87b@uni-rostock.de>
	 <348de3de5cbd6df96ac51bb07d6e485b2ecc5cc8.camel@sipsolutions.net>
	 <d77b66af-249d-4dd1-b78f-730d252bcf84@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_052028_812524_884D4B60 
X-CRM114-Status: GOOD (  26.75  )
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

On Fri, 2023-10-20 at 14:06 +0200, Benjamin Beichler wrote:
> Am 20.10.2023 um 13:39 schrieb Johannes Berg:
> > On Fri, 2023-10-20 at 12:38 +0200, Benjamin Beichler wrote:
> > > 
> > > Can you explain, why a time travel handler for stdin may be bad? It
> > > sounds like you want to avoid it, but I see no immediate problem.
> > > 
> > 
> > I need to read the thread, but this one's easy ;-)
> > 
> > The thing is that on such a channel you don't send an ACK when you've
> > seen that there's something to handle. As a result, the sender will
> > continue running while you're trying to request a new schedule entry
> > from the controller. As a result, it may run past your new schedule
> > entry because it didn't know about it yet (this would likely bring down
> > the controller and crash the simulation), or the relative order of the
> > two entries is undefined, in the sense that it depends on the process
> > scheduling of the host.

> Sorry, but I did not get this. What may run past the schedule entry? Is 
> your assumption, that the "thing" connected to stdin is always totally 
> unaware of the time travel mode?

No, I'm not assuming that, if that's done all bets are off anyway. I'm
assuming that both are connected to the controller.

> When our (to be published) simulation send something on serial lines (I 
> think it does not matter whether it is a socket or a pipe), we expect 
> that the uml instance needs to be run as long as it changes back to 
> idle/wait state before the simulation time is advanced. Since the basis 
> model of the time travel mode is, that you have infinite amount of 
> processing power, the interrupt needs to be always handled at the 
> current time.

Yes but you need to schedule for the interrupt, and you don't
necessarily know what 'current time' is at interrupt time.

So let's say you have "something" that's scheduled to run at times
 - 1000
 - 2000
 - 3000

and free-until is 10000 or something high.

Now it sends a message to Linux stdio at 1000.

But it doesn't have a way to wait for ack. So it continues, checks the
schedule and free-until, and can advance time to 2000 since it doesn't
yet know Linux requested time to run at 1000.

This gives you something not predictable - it depends on the host
scheduling, whichever ran first (Linux started next or the other
continued, or both and it gets messed up).

> Maybe my think-model only holds for "smaller" amounts of data (maybe one 
> page or something?) or not the free-running mode, but I'm not completely 
> convinced. :-D

Nah it doesn't really matter how much data there is.

> Maybe we need to define, a bit more formally, how the (designed) 
> processing model of interrupts in time travel mode is.

That's probably a separate Master's thesis ;-)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
