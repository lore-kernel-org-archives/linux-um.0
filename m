Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B968C4332F
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 17:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6Xb+gW0FYKrO5adgs/UXJFvSwc/t2cVN7Gsm45jfqX4=; b=rsYqEV3sB+h1lX
	gE5DOfLXnkps78XBUnHFTfF6PovC4wiw19JtHVvCLVul/Bpp21noR891esm5gTLDCxXuTS0lLcewr
	yyiYGoUTo0dTmN99MqkmvtEv1zK0iTN9TL274BYwL8KGvketM+L5lFakjMTAoUZ0Qp25+MWMOaPIy
	4Kuy69n/HyUAf7bTyW9XQw40TewYMIiEH8cQKncnfGxdW5PyAWUwCW59FKaYxS0e7FkvKRM9AidJd
	fecXp2phQEgTJfqH7R/PmOB9YmgEMGY0aV2AvGsSzDvgFM1oc3Z0f39CRZZB8XYV+YtEQn9XTdigQ
	BlYdricYtjAqicaptFGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1V9w-0097oz-0J;
	Fri, 10 Nov 2023 17:19:08 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1V9s-0097od-24
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 17:19:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0qbioaToQ1kA8DSK6dQkE1gWOJr+2seZDL/dc32teNQ=;
	t=1699636744; x=1700846344; b=qXPUeRbdNtkNO3Wsf9eS46B6uDID3hg/H9mddJYb7XhFLRk
	lydnom3W0ln9cn0pEoEKeQfiySUqwLRwphJOuTHJndZ0L7cgjZRJZsWA0d3LGHjv4CNV0SeIVNJrP
	9ZseeLRpZYWgYyh0rgbLampzQ9v0PBcQPpNluEWeUE+SkojF5365OnXC12hvTaS903IhDsn2vzXKy
	tMCDL6ydGgtH0gXC9gMKEQDtjZ37RbhzpWouF3sJwOJ5yaILY3kbgALH6ntRFCVR3DbgbddJ5rVBu
	feTf6nXRBg6KVXgV2BgVmn4oc0jo5MvECJhu6kNso4QPtmDmA9k0WW3MFjhADC7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r1V9q-000000036ba-1ird;
	Fri, 10 Nov 2023 18:19:02 +0100
Message-ID: <de19c73da6a133f3d961ea60df5b6c2239d049f9.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 07/11] um: add TIMETRAVEL_REQUEST handler to request
 latest event
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Date: Fri, 10 Nov 2023 18:19:01 +0100
In-Reply-To: <f63d0965-5bea-4752-ba5c-d4b39b68e6d6@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
	 <20231103-bb-timetravel-patches-v1-7-e2c68efcf664@uni-rostock.de>
	 <883e7458a05db3ec4733c2cb3bf46f2ae4ec9ee6.camel@sipsolutions.net>
	 <f63d0965-5bea-4752-ba5c-d4b39b68e6d6@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_091904_698694_93DFAC66 
X-CRM114-Status: GOOD (  16.42  )
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

On Fri, 2023-11-10 at 17:23 +0100, Benjamin Beichler wrote:
> Am 06.11.2023 um 21:33 schrieb Johannes Berg:
> > ________________________________
> > 
> > On Fri, 2023-11-03 at 16:41 +0000, Benjamin Beichler wrote:
> > > Allow the so called Calendar (or simulation master) to request the
> > > latest timetravel event. This can be used in situations, where the
> > > former request message from UML to Calendar was missed.
> > How ... is it possible to _miss_ a message?! It must've even sent an ACK
> > to it...?
> I must admit, this patch is older than those for protecting the event 
> list. I think mostly I mean here, the UM-instance miss to send the 
> current request, not that the calendar missed it :-)

Oh. I think we should rather fix that bug though. I don't think we've
observed it.

I'm not entirely opposed to this, but relying on it for correctness
seems wrong.

Also, I've referred to it before, but with the shared memory the whole
thing kind of goes away anyway since we just write the (earliest)
request into the shared memory.

Maybe if not many kids come singing tonight I'll try to send out some
more patches ;)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
