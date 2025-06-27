Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075CEC8300F
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 08:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=imuHrA4bmT5m0pSESNrCv0j8K1pnRCcac5EUDK9VNDY=; b=Enjilb5Exgm/yi077ZKjCw6qTj
	+WrJQ++QKVDfNhivmdSZSVtbFQI6QfpeiIfrmIUip/qKLJtgySHoDA++JvBn2EG+4At17MNtIKi8p
	GiPurCU+fdNHsZNEDurE05OOhHLpKQjDCDZ7Js/MekkGYr4ncaFI6mLgUgRJzam4Om+HrNXYGEy8t
	h2O3aM1Vn+bE5RC9pET7rsCFnBqUZWroBufeLiz9q3Pt4Rz31auNeYBWZsEpIfFb6eig4L6kEGuj4
	IANtQKPir4s4yE1RN901KvOWCTQAMETZV0QzJ+qhjlMTWK6G2F/NANwNR0jTXej0E3nOnKGgDUxc/
	kkY+nbOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV4gn-0000000DzCU-1ndq;
	Fri, 27 Jun 2025 08:44:05 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV4gP-0000000Dz9t-2LmY
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 08:43:42 +0000
Date: Fri, 27 Jun 2025 10:43:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751013817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imuHrA4bmT5m0pSESNrCv0j8K1pnRCcac5EUDK9VNDY=;
	b=HhaQdw1d7XkpVyjuh7ywC7fGt6PTNF5bLxfal0Ale735njW1nuR9DDAp9iQfVp4/irLtQ/
	lt1srjMPV/0eiwUp9/6HdLIZNo0I3tY2ORtB7ZzCMKf5U+xbDNou+d1rpofpzviWA6CnyP
	swW9xFwTqiDm9O/4JwgwXg4EjHn/QG/kNWo7Z/AAIJZoS9RNUHBZoux4faBb0u8HC8iLGt
	sOZz8drj83x65TpsLkYxOsrBeS+mE8ms+F6rZzksB7MZyuIFHCNNRfXLe6rcsLvhRR/ImC
	ejDDfm39ZPf1X7Ohuh1npmJTvay+or0li7vKJ+GKU7ladRbfWxNwk45jnE0w1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751013817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imuHrA4bmT5m0pSESNrCv0j8K1pnRCcac5EUDK9VNDY=;
	b=B+U4PFdzbyGpe+j31AbVvzYQPadHeHzBYbcUOavYIQVZN/GDYVcpmV5Hqbsv7iS2Ldf2zh
	R7A6s8D1eEYeFaAw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: kunit-dev@googlegroups.com, linux-um@lists.infradead.org
Subject: Re: [RFC 0/2] Experimental kunit test for signal context handling
Message-ID: <20250627103520-c7f8d4cd-9c85-4e87-b7de-b6d9fb1310e3@linutronix.de>
References: <20250626195714.2123694-1-benjamin@sipsolutions.net>
 <20250627062337-a67a262d-5957-42cf-8bc0-69388f4ae078@linutronix.de>
 <4e5a205eee41abf84c3d3340275833c20b7d7050.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e5a205eee41abf84c3d3340275833c20b7d7050.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_014341_779238_CF4FAC78 
X-CRM114-Status: GOOD (  29.54  )
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

On Fri, Jun 27, 2025 at 09:29:12AM +0200, Benjamin Berg wrote:
> On Fri, 2025-06-27 at 06:33 +0200, Thomas Weißschuh wrote:
> > On Thu, Jun 26, 2025 at 09:57:12PM +0200, Benjamin Berg wrote:
> > > so I saw the UAPI testing framework patches and wondered whether I could
> > > hack up a kunit test for userspace signal mcontext handling. I already
> > > had some code, but never knew where to include it. Having it as a kunit
> > > test in this way seems nice as it makes running the test really simple.
> > 
> > Nice to hear that you find it useful.
> > 
> > > This is a very rough attempt with an extra patch to add sigaction
> > > support as that is needed by the test.
> > > 
> > > Note that this type of test could possibly be shared with the x86
> > > architecture (though UM does not support all features).
> > 
> > Can the expected feature detection be performed at runtime?
> > If so I would write the test as x86 kselftest in tools/testing/kselftests/x86/
> > and then also hook it up for kunit on UML and x86.
> > This gives you the advantages of all worlds.
> > 
> > For an example see [0]. That is still based on an old version of the framework,
> > so can't be used as-is. But you should get the idea.
> 
> That looks nice, and you do support both x86 and um there!
> 
> Many of those checks should be simple as syscalls will return an error
> (modify_ldt should return -ENOSYS for example). For more arcane things
> one could e.g. add "(um)" into AT_PLATFORM or just disable the kunit
> test for the um architecture.

Sounds good.

> This is a nice development, I absolutely expect to find some bugs in um
> this way.

I do so, too :-)

https://lore.kernel.org/lkml/20250617-uml-tick-timer-v1-1-01aab312f56b@linutronix.de/

To be honest if there are going to be a bunch of issues on UML,
I'd prefer to drop the UML bits from my submissions.
I'm not familiar with UML and can't really fix the fallout.
Then you can wire up the tests with a few lines and handle the fallout at
your convenience.

Or we gate the testcases behind BROKEN/EXPORT on UML in the beginning.

Does this sound reasonable?

<snip>


Thomas

