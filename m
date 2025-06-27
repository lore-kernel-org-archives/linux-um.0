Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22885C77B7F
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 09:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jxFNMSQkrNEtRVuIRp7hIx1RFh1qNBxN8vMI7LDNO08=; b=vD0yoeNYjgdFe78cEDxVNm0I+f
	4sq5fS0kBj4NGrDDfzy2+Bnf2JwOwjvF+dy4bKAdR4N0dV8ucLzK5k2lHwT3cfPSwcHSwzKpLk0vz
	TTiEATUrjebX0i54iLjKr2Y4gYzn+ak1mU2wJvJN2pEx5X9RmnuOdlASymgn1i/ab7T8X3jpoxLgA
	3o0twpTBpsSj7lQ8mxFCag2zFJ4JDQWGQuAaSmipmX381LWbmxIRwklS+mHbhxGU9ruQBRS7NrqIL
	/tHgBYwP5HkVRKMJ1BdqLaJlxVsXaFj+hhjz33VEST6Hp8XWiF8tjmEXBMGTaH/MUGwRdAV7HkXnA
	MjqFAWAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV5Og-0000000E7XA-1yWc;
	Fri, 27 Jun 2025 09:29:26 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV5Oe-0000000E7WL-19W0
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 09:29:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jxFNMSQkrNEtRVuIRp7hIx1RFh1qNBxN8vMI7LDNO08=;
	t=1751016561; x=1752226161; b=w5+38s2JMJLc6y7Oa8htrCZpl1XDdiNgvadwNcmUL0Lbc9/
	Ea9Hg0Kac5eYcAeQuIYQzUH3NN34AqfUksqW6Va1onH2JiiWpwUkAzbv5Vq12XEXfFNr1Dtd0aCzu
	gMoORUSIzFvDtgccX3oLTNR47qBfAoUnC33tQ0I/kYUbXES7yBRMpfvrp8fn7hAks6AkGq3VT+ClU
	f9sX1LY0WOYO6qdT9wYqVCH/Ay75j8X2b7Xjp3XZ1HZu233vEDQN0X0nh8q333D3OAMG0bCJlkz9T
	IkW8zOWnKUa3uk6Y2lq0DEF7dMo+TmxaYUTc6lKUSMUw5CJFBQznlD20e1qvv2ww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uV5OJ-0000000DSbY-2w7H;
	Fri, 27 Jun 2025 11:29:07 +0200
Message-ID: <ebd2e1ffcd9f11c4032be50d9cafd19f3a3fb104.camel@sipsolutions.net>
Subject: Re: [RFC 0/2] Experimental kunit test for signal context handling
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: kunit-dev@googlegroups.com, linux-um@lists.infradead.org
Date: Fri, 27 Jun 2025 11:28:58 +0200
In-Reply-To: <20250627111257-53a9219c-af39-4596-aaca-9b8806302ee4@linutronix.de> (sfid-20250627_112312_332848_8C738F05)
References: <20250626195714.2123694-1-benjamin@sipsolutions.net>
	 <20250627062337-a67a262d-5957-42cf-8bc0-69388f4ae078@linutronix.de>
	 <4e5a205eee41abf84c3d3340275833c20b7d7050.camel@sipsolutions.net>
	 <20250627103520-c7f8d4cd-9c85-4e87-b7de-b6d9fb1310e3@linutronix.de>
	 <89cbc0bdb9b4894ca073dac56406b02eeee3ece5.camel@sipsolutions.net>
	 <20250627111257-53a9219c-af39-4596-aaca-9b8806302ee4@linutronix.de>
	 (sfid-20250627_112312_332848_8C738F05)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_022924_312293_305A66FA 
X-CRM114-Status: GOOD (  17.52  )
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

On Fri, 2025-06-27 at 11:22 +0200, Thomas Wei=C3=9Fschuh wrote:
> On Fri, Jun 27, 2025 at 10:48:30AM +0200, Benjamin Berg wrote:
> > Hi,
> >=20
> > On Fri, 2025-06-27 at 10:43 +0200, Thomas Wei=C3=9Fschuh wrote:
> > > On Fri, Jun 27, 2025 at 09:29:12AM +0200, Benjamin Berg wrote:
> > > > > > [SNIP]
> > >=20
> > > Or we gate the testcases behind BROKEN/EXPORT on UML in the beginning=
.
> > >=20
> > > Does this sound reasonable?
> >=20
> > Not sure how to gate them, but I do like the idea of being able to
> > enable them using only minor modifications or even a Kconfig option to
> > see what happens on UM.
>=20
> With my WIP x86 enablement commit as example [0].
>=20
>=20
> Possibility 1, I *drop* these two hunks, you can readd them:
>=20
> diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
> index 986045d5e63854..f2aeaf1e8e6d9a 100644
> --- a/arch/x86/um/Kconfig
> +++ b/arch/x86/um/Kconfig
> @@ -3,6 +3,7 @@
> =C2=A0menu "Host processor type and features"
> =C2=A0
> =C2=A0source "arch/x86/Kconfig.cpu"
> +source "arch/x86/tests/Kconfig"
> =C2=A0
> =C2=A0endmenu
> =C2=A0
> diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> index b42c31cd2390cb..e71bb244afac9d 100644
> --- a/arch/x86/um/Makefile
> +++ b/arch/x86/um/Makefile
> @@ -13,7 +13,7 @@ obj-y =3D bugs_$(BITS).o delay.o fault.o \
> =C2=A0	ptrace.o ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal.o =
\
> =C2=A0	stub_segv.o \
> =C2=A0	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
> -	mem_$(BITS).o subarch.o os-Linux/
> +	mem_$(BITS).o subarch.o os-Linux/ ../tests/
> =C2=A0
> =C2=A0ifeq ($(CONFIG_X86_32),y)
>=20
>=20
> Possibility 2, the kconfig looks like this:
>=20
> config X86_UAPI_TEST
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "x86 UAPI tests" if !=
KUNIT_ALL_TESTS
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on KUNIT_UAPI
> 	depends on !UML || BROKEN
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default KUNIT_ALL_TESTS
>=20
> You enable CONFIG_BROKEN and can run the tests.

I think I prefer option 2. Not a strong opinion, but it shows that they
should be working just fine UML.

Benjamin

>=20
> Of course as soon as all tests work on UML, this all goes away and they
> stay enabled.
>=20
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/lin=
ux.git/commit/?h=3Dkunit-kselftests-integration&id=3D14bf93f09eaa328a18e919=
0f46fa4ee697378617
>=20


