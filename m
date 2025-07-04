Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54093C83F03
	for <linux-um@archiver.kernel.org>; Fri,  4 Jul 2025 12:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8pqk9sQ1hk+evyB3Xq8g8PnevbuWCcnCHVK2r5AtxWU=; b=z227Iw9QizOmBgLobQy7Y7tqNW
	ZVrPGS1veE5FyFWtEXhmwHjoQzrzh5C+sD8HFTWKXdbACTCtic9NbOSNTCkmlV2DcktJub3Z3xtHs
	zZgHFllZckihizOV6DLrju8boKFJCClttUP6rwnk5VoRlGZTWlWuLlB8L/qk6Kkqe7spPhoqy5h0b
	cQt/YMhjk+ZJowAKZO1MkQIajreWw7wvSKK/b71Ji/DZttXKDwoiTH3hgW7+8zUPcukUHqClpxDI8
	an4MwNvssnmJnGeE7Do3eAlNFgdjMuUvJ4v/yTNWjGcrechEl9wBV3HTbfF6hoJENMZ1A43Lcjhf9
	8NNrwMVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXf5V-0000000EKzX-49if;
	Fri, 04 Jul 2025 12:00:17 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXf5T-0000000EKz3-2quC
	for linux-um@lists.infradead.org;
	Fri, 04 Jul 2025 12:00:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8pqk9sQ1hk+evyB3Xq8g8PnevbuWCcnCHVK2r5AtxWU=;
	t=1751630415; x=1752840015; b=QrK/wW9MBBVh6/MxaB4/p1CX3QHlwFgGUWxiZ6WvBbP1fv8
	FeX3X1PsIcMTJ0Dcb+lGz4WcvG3aOIxz7oUYGUxtkgSDlLMpb2It1j/okOtfJO6oZ2dRDv4LzfZSD
	Rt+m3NoBE/jIAzsevdNdUTiF7EXOnWHEAeBnvGOmoU0lwHb1kuylvHMZXpxPKaHC6XgURMpadjsW/
	WdDbFI+DTvpssKlBmVBlr09jRZ1JiWuPGLP5MHpDHkwpBFGhABU8DR//GWtekqm5Ht9DJEycegTob
	aUBex0xfVPZnx8+yBwv3aP9lkSdPl2nA0G0OvjUUElSYuKBzDb4Y7wmwBjCF6gxQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uXf5Q-00000006oSv-2AZi;
	Fri, 04 Jul 2025 14:00:12 +0200
Message-ID: <a8ba7df9d797a6aacb0500457ba6c5490d998591.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/1] um: virt-pci: Switch to
 msi_create_parent_irq_domain()
From: Johannes Berg <johannes@sipsolutions.net>
To: Thomas Gleixner <tglx@linutronix.de>, Nam Cao <namcao@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 04 Jul 2025 14:00:11 +0200
In-Reply-To: <87plehtei3.ffs@tglx>
References: <cover.1751266049.git.namcao@linutronix.de>
	 <5f0bd8e877e7bfdfb1a7e99d6b126caf6a7eea48.1751266049.git.namcao@linutronix.de>
	 <e64a4c40b0234fc265a74cb60633117dc6911518.camel@sipsolutions.net>
	 <20250630070249.oVVkmFZg@linutronix.de> <87plehtei3.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_050015_716837_BE49E023 
X-CRM114-Status: GOOD (  12.80  )
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

On Thu, 2025-07-03 at 18:39 +0200, Thomas Gleixner wrote:
> Johannes,
>=20
> On Mon, Jun 30 2025 at 09:02, Nam Cao wrote:
> > On Mon, Jun 30, 2025 at 08:55:54AM +0200, Johannes Berg wrote:
> > > On Mon, 2025-06-30 at 08:51 +0200, Nam Cao wrote:
> > > > Move away from the legacy MSI domain setup, switch to use
> > > > msi_create_parent_irq_domain().
> > > >=20
> > >=20
> > > Do you want this to go through the UML tree, or is it a dependency
> > > somewhere else? In the latter case, I suppose you can add
> >=20
> > Please take it into the UML tree.
> >=20
> > > Acked-by: Johannes Berg <johannes@sipsolutions.net>
> > > Tested-by: Johannes Berg <johannes@sipsolutions.net>
>=20
> are you picking this up or want me to queue it?

I've picked it up for uml-next now:

https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git/commit/?h=3Dn=
ext&id=3D1528fd400c62b84b9c0e368a62b83fbd9d6fb92b

johannes

