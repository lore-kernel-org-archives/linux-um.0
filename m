Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A277CCAC59A
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 09:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UsEHoqpr4EKQ1m7trAZcJJ5OYUIK1jdUsKRYb7ptqtU=; b=J+9I8auim5z8l8p+121rNHSGbz
	Hfpib6mnYTcYDUzL6S7lPnqIBp7gxSa1Xdu+jyOB1WOH8aMgkBsCyt8hO3E+Llqy4G/4UEOanDRNr
	+fiBKhVlvQUuRP7PcKelPuUwb5TRgnI0VjvAZHkR3Q0BQysOr5cyei1jYOuc62dUZO5OG3AXfDZpn
	4scc74GDlQJlO5U/Hpk41Pl814cKypoh/8IViDiBTfQzZqimBo5QTiz41GE2jDwjMqHAuqYEKLjmz
	A4iLcKq9LLYQ63UktsWXluw/1aNLvzDGp8VAa0Qmkqnwi9tt2gFyJyfpOr9jyYyMdv4st2cQX2pZ6
	wf3WNh8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzXZF-00000002PlT-1QFp;
	Fri, 19 Sep 2025 09:38:13 +0000
Received: from s3.sipsolutions.net ([168.119.38.16] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzXZD-00000002Pij-1nV2
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 09:38:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UsEHoqpr4EKQ1m7trAZcJJ5OYUIK1jdUsKRYb7ptqtU=;
	t=1758274691; x=1759484291; b=qmtHD7sZXQDTBfvVZFazyVB4pT1GdAUYhioguCM5w4T5/aZ
	1k8ziGrfCffZ7pHtlcay/XvHTeIpkXtGrHmZYHSJ3sH5MR8AvdwLg+5neQdrSLl1NIz4hCp66brUv
	JB/EUHc3eXUnPVmZFV5m6TqSF6QJnFdBNAkn2vW7d0JP4gdwFltpAtsHwuE2vzUOuoYSo+3GtEIdY
	qVWyGTAsA1tj4+3aTlXzjLCeuDfh0EGn/lGd0jbUpsH3QPFc3izEorYiPZC/F+vrzq5fYUd5e3i4q
	RLH9f/5x0jGtM4cqBQYFGbmFdkWbb+Y1ZYFjsDl+Q6cp4mJj1hR+auEjG1zI1PnA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzXZ6-0000000Fde2-33vj;
	Fri, 19 Sep 2025 11:38:04 +0200
Message-ID: <da39f51b76cca54e5304064f7e34a8863442605d.camel@sipsolutions.net>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	linux-kernel@vger.kernel.org
Date: Fri, 19 Sep 2025 11:38:03 +0200
In-Reply-To: <m27bxu949d.wl-thehajime@gmail.com> (sfid-20250919_113237_926194_6AC3D71B)
References: <cover.1758181109.git.thehajime@gmail.com>
		<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
		<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
		<m28qib8g1r.wl-thehajime@gmail.com>
		<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
	 <m27bxu949d.wl-thehajime@gmail.com> (sfid-20250919_113237_926194_6AC3D71B)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_023811_467885_67E30C9D 
X-CRM114-Status: GOOD (  17.29  )
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

On Fri, 2025-09-19 at 18:32 +0900, Hajime Tazaki wrote:
> currently, drivers/pci/Kconfig (CONFIG_PCI) marks as depends on MMU,

Right.

> so we cannot select it when CONFIG_MMU=3Dn.

Actually, I believe that's not true, I think it *can* select something
even if you override the 'depends on' it has, it just causes a warning
in Kconfig.

But I don't think PCI is even selected, UML_PCI is selected, and then
that selects PCI_MSI which should really only be reachable when PCI is
enabled, so this perhaps does nothing? Not sure ...

> but it's different with kunit when using them via kunit.py config,

It really isn't, you just don't see everything because kunit.py hides
the build from you.

> it first adds
>=20
>  CONFIG_VIRTIO_UML=3Dy
>  CONFIG_UML_PCI_OVER_VIRTIO=3Dy
>=20
> via tools/testing/kunit/configs/arch_uml.config, and then add
>=20
>  CONIFG_MMU=3Dn
>=20
> via --kconfig_add CONFIG_MMU=3Dn.

Sure. But that should disable CONFIG_UML_PCI_OVER_VIRTIO, and it doesn't
now.

> and then execute make ARCH=3Dum olddefconfig, which in turn enables
> CONFIG_UML_PCI_OVER_VIRTIO.

Keeps it, let's say.

> if we append "--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=3Dn" to kunit.py,
> it will overwrite the arch_uml.config.

Yeah but that being required doesn't make sense - the Kconfig should
express the correct dependencies.

> # I don't know how kunit handles those appended CONFIG entries, though..

It just puts them into the file and runs oldconfig, I guess?

> my goal is simple; to test !MMU code via kunit.

Sure.

> my original patch or the additional kconfig argument (--kconfig_add)
> satisfies this goal.

Sure. But both are the wrong solution, as I said, the Kconfig should
express the correct dependencies.

> > The problem is probably UML_PCI_OVER_VIRTIO selecting UML_PCI selecting
> > various PCI code, but nothing depends on PCI in the first place. Which
> > it should, then?
>=20
> I don't understand the 'nothing depends on PCI...' part.  care to
> elaborate ?

See above, I think?

My gut feeling is that UML_PCI_OVER_VIRTIO should depend on PCI but I
don't know if that then doesn't end up in some kind of circular
dependency.

johannes

