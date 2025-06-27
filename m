Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288B5C7EE3A
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 07:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8HHxcDgXjqwO7FNMR4SgNRIAooBAEvxSRH/XZ+NSYY=; b=r9pr1J8R80p4+42r9uz/NY2VSv
	P1QtTHBf/JXejkpFPwimpD5E3umK6jD6AfJ5H6LXdzdtBDAr+BrNYCtq3y1LZqus911P4lee7yUpp
	Io/EEwVUPA5z4ANGGszfjeUIbqFrgxe6yxR0RQvEx4U0j+Ed/WxoLlLKKFr4P0tTwdOCforxmzdoy
	4qTxHJ6lGuvggzosnvnbzXgkCsX/mCTl7l9swbC2xnSiK6w4uGklA1MYW7MyFtrx0ByrCftF9wJoJ
	mm2ZGYApl9cH0Nhsh8bPQbJX74axS9iu+dfifkycCSNjm25kJcD9EQmg2030VMZ3WsxxI62h6HLjF
	tTk2KpNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV3gf-0000000Dqej-3At4;
	Fri, 27 Jun 2025 07:39:53 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV3Wf-0000000DpGZ-2Gi0
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 07:29:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=C8HHxcDgXjqwO7FNMR4SgNRIAooBAEvxSRH/XZ+NSYY=;
	t=1751009372; x=1752218972; b=pziETnA4+SsK5L/CFfVrKEJPxnRXEnArl5vmE7JTWtOXu7m
	/ALfLwuGQbqJ42fxqWyFr97EybjSDBGYzbQLHcLGhZUZtLA4tZFBSSMFYBiSalkgw0TIzTM7dgvDj
	BtAepRIiok696mwLHivpNKMLgvzNbO6J5h9/e0tkjxQuSn++L7sSlWRru2LYJ0QOvMvQQZUnuEaPY
	KgXmEhzaCCJr31hh9+91nPfS/sSN36pMimzAAgqDZ11fg2ZuF1gHOeZDJw2ARTHincepDjJDerrwf
	29XSSi3WMXi8QhYcD7yLiGwI0g9Y+zoUuBf76Y/vkfllvmuMHsk4ZHzXH0D694AA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uV3WQ-0000000DHoG-0ZNW;
	Fri, 27 Jun 2025 09:29:19 +0200
Message-ID: <4e5a205eee41abf84c3d3340275833c20b7d7050.camel@sipsolutions.net>
Subject: Re: [RFC 0/2] Experimental kunit test for signal context handling
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: kunit-dev@googlegroups.com, linux-um@lists.infradead.org
Date: Fri, 27 Jun 2025 09:29:12 +0200
In-Reply-To: <20250627062337-a67a262d-5957-42cf-8bc0-69388f4ae078@linutronix.de>
References: <20250626195714.2123694-1-benjamin@sipsolutions.net>
	 <20250627062337-a67a262d-5957-42cf-8bc0-69388f4ae078@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_002933_578639_FE313C16 
X-CRM114-Status: GOOD (  30.79  )
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

On Fri, 2025-06-27 at 06:33 +0200, Thomas Wei=C3=9Fschuh wrote:
> Hi,
>=20
> On Thu, Jun 26, 2025 at 09:57:12PM +0200, Benjamin Berg wrote:
> > so I saw the UAPI testing framework patches and wondered whether I coul=
d
> > hack up a kunit test for userspace signal mcontext handling. I already
> > had some code, but never knew where to include it. Having it as a kunit
> > test in this way seems nice as it makes running the test really simple.
>=20
> Nice to hear that you find it useful.
>=20
> > This is a very rough attempt with an extra patch to add sigaction
> > support as that is needed by the test.
> >=20
> > Note that this type of test could possibly be shared with the x86
> > architecture (though UM does not support all features).
>=20
> Can the expected feature detection be performed at runtime?
> If so I would write the test as x86 kselftest in tools/testing/kselftests=
/x86/
> and then also hook it up for kunit on UML and x86.
> This gives you the advantages of all worlds.
>=20
> For an example see [0]. That is still based on an old version of the fram=
ework,
> so can't be used as-is. But you should get the idea.

That looks nice, and you do support both x86 and um there!

Many of those checks should be simple as syscalls will return an error
(modify_ldt should return -ENOSYS for example). For more arcane things
one could e.g. add "(um)" into AT_PLATFORM or just disable the kunit
test for the um architecture.

This is a nice development, I absolutely expect to find some bugs in um
this way.

> > And, a 64 bit build might even want to include a second 32 bit binary.
>=20
> Indeed, for compat binaries we'll probably want some sort of common patte=
rn.
> Unfortunately it's not as easy as building a second binary when CONFIG_CO=
MPAT=3Dy,
> as some architectures have more than 2 supported ABIs. MIPS for example o=
r x86_64
> when counting x32.
> Or maybe we can just pretend that those don't matter.
> Something we can work on when the first series has been merged.

Yes, lets ignore that for now :-)

> > So, I suppose
> > one would ideally want the test to be in arch/x86/tests, with some way
> > to pick up it up in arch/x86/um/tests.
> >=20
> > Does this seem sensible in general?
>=20
> It does.

Nice!

Benjamin

>=20
> > Benjamin
>=20
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/lin=
ux.git/commit/?h=3Dkunit-kselftests-integration&id=3D14bf93f09eaa328a18e919=
0f46fa4ee697378617
>=20
> >=20
> > Benjamin Berg (2):
> > =C2=A0 tools/nolibc: add sigaction()
> > =C2=A0 um: add a mcontext FP register handling test
> >=20
> > =C2=A0arch/x86/um/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 2 +
> > =C2=A0arch/x86/um/tests/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +++
> > =C2=A0arch/x86/um/tests/registers.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 22 +++++
> > =C2=A0arch/x86/um/tests/test-fp-save-restore.c | 118 ++++++++++++++++++=
+++++
> > =C2=A0tools/include/nolibc/nolibc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> > =C2=A0tools/include/nolibc/signal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 34 +++++++
> > =C2=A06 files changed, 191 insertions(+)
> > =C2=A0create mode 100644 arch/x86/um/tests/Makefile
> > =C2=A0create mode 100644 arch/x86/um/tests/registers.c
> > =C2=A0create mode 100644 arch/x86/um/tests/test-fp-save-restore.c
> >=20
> > --=20
> > 2.50.0
> >=20
>=20


