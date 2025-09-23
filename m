Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BF6CAC5AC
	for <linux-um@archiver.kernel.org>; Tue, 23 Sep 2025 17:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vjZeveKFzDPAEd4GCEqvLjhW0pC9krDO5tPa8N+ao6c=; b=4GWPfliQsOjJ7stDeHXPWHEvU7
	SJRVuw2QcUsC1OmqnDlwOeM11XlOXUUXDx1tO1iFAog3tB4Wax9fwhrJwbidAiaGoIaNvHL48vrlv
	Yhs4JoulX1pBE25EliKmOXW0WVMVhsRt532f0kGHKdhaHYuSquEdXTFlVB4Kk3gTLRRNRr7pAuEzL
	9vRthyOtdi+IyCUodN4m2OIXxJXjzlTdD+FqjHockD+gmJXMV4D1acveabU9AyWh+6edan+iUd/AH
	OO1WRSwWhraKHi0/4i/jbuCuJ+L5b/AsRybIeVjD59cG4YkfnhRpKVx6qgarxA7dizW3W8MC2WesY
	ilC1xHRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v16aS-0000000EMVn-0BlN;
	Tue, 23 Sep 2025 17:13:56 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v16aP-0000000EMVM-3mkU
	for linux-um@lists.infradead.org;
	Tue, 23 Sep 2025 17:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vjZeveKFzDPAEd4GCEqvLjhW0pC9krDO5tPa8N+ao6c=;
	t=1758647633; x=1759857233; b=RULJAGCSQAMqNz76S9Mp0KlqA5LluL5pbV7RCuTA16h4b7A
	JYlUNStKagrWDtluxE8zylLfwHCxJaZ/rS/vQbeixq2JusiNMH6OtxN1FAlbVne2+xv4i6E7/oDsl
	BkqLOXa4uNhaPc1n3XBy7pZ3kjwHJbykpjT9IkDf51+L3gQECPOQFmHItCi38LHfi94XHATlv1K7I
	6jzWAcAI8iAKZbyT9XXI1jmy2xAwx2IT5fKrDWj6dclFXoqD5qSVZ/JXSHRQphPfVindWf2dV45Ek
	DgjIe9LDczrr7vwMFoxLNGwrhXt0PA1LdMlswrzqMWAmaYNe6Nkv2BJmeBA4jTMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v16aK-00000006pCz-1JN8;
	Tue, 23 Sep 2025 19:13:48 +0200
Message-ID: <23adb61e95275251e459513a03ab7d2bcf1f2e07.camel@sipsolutions.net>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Hajime Tazaki
	 <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	linux-kernel@vger.kernel.org, Arnd Bergmann
 <arnd@arndb.de>
Date: Tue, 23 Sep 2025 19:13:47 +0200
In-Reply-To: <CAMuHMdWAdhiY=MiG5JtboffSo_=D7TD5vFM6Ui5E8eS_VJiJ=g@mail.gmail.com> (sfid-20250923_174311_655140_04935269)
References: <cover.1758181109.git.thehajime@gmail.com>
	 <4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
	 <a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
	 <m28qib8g1r.wl-thehajime@gmail.com>
	 <6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
	 <m27bxu949d.wl-thehajime@gmail.com>
	 <CAMuHMdWAdhiY=MiG5JtboffSo_=D7TD5vFM6Ui5E8eS_VJiJ=g@mail.gmail.com>
	 (sfid-20250923_174311_655140_04935269)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_101353_966275_B5C2E78D 
X-CRM114-Status: UNSURE (   8.94  )
X-CRM114-Notice: Please train this message.
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

On Tue, 2025-09-23 at 17:42 +0200, Geert Uytterhoeven wrote:
> >=20
> > currently, drivers/pci/Kconfig (CONFIG_PCI) marks as depends on MMU,
> > so we cannot select it when CONFIG_MMU=3Dn.
>=20
> That is a fairly recent change, see commit 8fe743b5eba0abfb ("PCI:
> Add CONFIG_MMU dependency") in v6.16-rc1.  As this is not a "hard"
> dependency, perhaps it should be reverted, iff you are willing to take
> care of the casual breakage?

Why though? UML with PCI can't really be a functional thing, only a
testing thing, and testing PCI on !MMU when that is actually impossible
in non-simulation is pointless?

johannes

