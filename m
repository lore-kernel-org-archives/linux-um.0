Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EE7C77B7F
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 08:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2F8l/JQvMi6MHAIpC0wbKLAkkHxDe6ObHh4C45f6cI=; b=D/Uz9DBLLQyPVS9tYhdEDybI6P
	F5wCKKuJdkWL0E4COftvk14BdFiVDerpB3seyEpDJoJn7Ev17wtn8+2xojZsTfC0dxLw4tWVnugOX
	pm6IRf1mjLBOQgCauHKlVF3cKpvEcMILW1xZsiS7raKQ+Z/M907p2jZKyYNE4Au8Ne3/k+GYy6xTh
	bPs29BITcKj3ySOsZ2tAAvOpA8KngfEhu+gQGzTNEX4bc/Lgznyi8zsLOlj+a/P14rObtu1YE+FpI
	3Sy31NnPDMuKG/guEozJAz1Y8dt/FXX+i7yIUeP23P9VjGPIOOulQ6Q6Fur2/nJzQqpfLQSQXmIyh
	EXuAxryg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV4mF-0000000E053-1N4v;
	Fri, 27 Jun 2025 08:49:43 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV4lI-0000000E01s-476N
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 08:48:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=r2F8l/JQvMi6MHAIpC0wbKLAkkHxDe6ObHh4C45f6cI=;
	t=1751014124; x=1752223724; b=IhoEAHjUiwizSMuMhWHNZjr0A2BU7kiTvNQzzQbb7lM39we
	N3DzofttVMpzVssRkywXBVROXDu1Dcwv3erkhFYBRLjLcKVLqlmeED0JVQL5RyaU8N+n267P0ab4L
	WtWnLe8t1N555m+GzupRWB4ypfDcd0gTerrtYKT+a5kZ/eoYB9t66h95pdH+lbHtyu7maRVDHqfny
	inIP1VRHk9DKQ+08P+b/IVbQFTZ9uD13iw4KWGR1EYp76jRSPV92mTCj4TyqlK4ltwH6zCbgbRcKu
	3o3PNvhHxxfX//ZSSShObjsAp4ddvGby9aw53Hui+cEcTUSC5AU5P90YZztSGk6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uV4l7-0000000DOpt-1u5W;
	Fri, 27 Jun 2025 10:48:34 +0200
Message-ID: <89cbc0bdb9b4894ca073dac56406b02eeee3ece5.camel@sipsolutions.net>
Subject: Re: [RFC 0/2] Experimental kunit test for signal context handling
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: kunit-dev@googlegroups.com, linux-um@lists.infradead.org
Date: Fri, 27 Jun 2025 10:48:30 +0200
In-Reply-To: <20250627103520-c7f8d4cd-9c85-4e87-b7de-b6d9fb1310e3@linutronix.de>
References: <20250626195714.2123694-1-benjamin@sipsolutions.net>
	 <20250627062337-a67a262d-5957-42cf-8bc0-69388f4ae078@linutronix.de>
	 <4e5a205eee41abf84c3d3340275833c20b7d7050.camel@sipsolutions.net>
	 <20250627103520-c7f8d4cd-9c85-4e87-b7de-b6d9fb1310e3@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_014845_023170_8A809082 
X-CRM114-Status: GOOD (  34.83  )
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

On Fri, 2025-06-27 at 10:43 +0200, Thomas Wei=C3=9Fschuh wrote:
> On Fri, Jun 27, 2025 at 09:29:12AM +0200, Benjamin Berg wrote:
> > On Fri, 2025-06-27 at 06:33 +0200, Thomas Wei=C3=9Fschuh wrote:
> > > On Thu, Jun 26, 2025 at 09:57:12PM +0200, Benjamin Berg wrote:
> > > > so I saw the UAPI testing framework patches and wondered whether I =
could
> > > > hack up a kunit test for userspace signal mcontext handling. I alre=
ady
> > > > had some code, but never knew where to include it. Having it as a k=
unit
> > > > test in this way seems nice as it makes running the test really sim=
ple.
> > >=20
> > > Nice to hear that you find it useful.
> > >=20
> > > > This is a very rough attempt with an extra patch to add sigaction
> > > > support as that is needed by the test.
> > > >=20
> > > > Note that this type of test could possibly be shared with the x86
> > > > architecture (though UM does not support all features).
> > >=20
> > > Can the expected feature detection be performed at runtime?
> > > If so I would write the test as x86 kselftest in tools/testing/kselft=
ests/x86/
> > > and then also hook it up for kunit on UML and x86.
> > > This gives you the advantages of all worlds.
> > >=20
> > > For an example see [0]. That is still based on an old version of the =
framework,
> > > so can't be used as-is. But you should get the idea.
> >=20
> > That looks nice, and you do support both x86 and um there!
> >=20
> > Many of those checks should be simple as syscalls will return an error
> > (modify_ldt should return -ENOSYS for example). For more arcane things
> > one could e.g. add "(um)" into AT_PLATFORM or just disable the kunit
> > test for the um architecture.
>=20
> Sounds good.
>=20
> > This is a nice development, I absolutely expect to find some bugs in um
> > this way.
>=20
> I do so, too :-)
>=20
> https://lore.kernel.org/lkml/20250617-uml-tick-timer-v1-1-01aab312f56b@li=
nutronix.de/

Ah, yes, that one :-)

> To be honest if there are going to be a bunch of issues on UML,
> I'd prefer to drop the UML bits from my submissions.
> I'm not familiar with UML and can't really fix the fallout.
> Then you can wire up the tests with a few lines and handle the fallout at
> your convenience.
>=20
> Or we gate the testcases behind BROKEN/EXPORT on UML in the beginning.
>=20
> Does this sound reasonable?

Not sure how to gate them, but I do like the idea of being able to
enable them using only minor modifications or even a Kconfig option to
see what happens on UM.

Benjamin

>=20
> <snip>
>=20
>=20
> Thomas
>=20


