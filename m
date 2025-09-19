Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB71CAC59A
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 07:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Z4perxsP8d9vCjAkHxZUXQ59H6PCtwERdPNDJe/SyI=; b=aVzH6cgWjyI4qQatFjhYDxMKgN
	MrXjlCDKD56XKBKGIV1UWEKauaGg4U8WwRU8ybB+zAHuVXeq3Rp1HSpRIIqj5b5Xtv4O4sq3LRnuF
	jO54L0VCc6sbrJ/LyGOcfacSvY8sRgc8xISj1cyDRiI1Bnqb+pmfWNwVGi/1irD5uqPpywlMX88tk
	DZWTKTqDc/mEsdZ/0CP8REICrPd/mcu07zujqjeEAQuNaxQlrDeUGYgZuF6oFTwcy5dle+rEjlneC
	Lsd0EdjlLG/3xoWyB5dR3El3WRWY0zIcDn3Z6hP7KZzNpckQbPauwdtSuZ65oBxT6sTlNbUiXwqQz
	4uXFff5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzVTb-000000023Ci-0f1l;
	Fri, 19 Sep 2025 07:24:15 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzVTY-000000023C3-19OD
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 07:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3Z4perxsP8d9vCjAkHxZUXQ59H6PCtwERdPNDJe/SyI=;
	t=1758266652; x=1759476252; b=pwRnurXalnn0WnENLO4nbzS0sdcK6c0BXiCIM6cAEG8631R
	ww276NHuXy4jt49VSFTfe1RYTB3xtNm6qMmWGY2tIoKRTqEGbfwAN2lxI6zWeNW1mO2/W7rm698Ju
	QgKn0F724lJ1+qRFG00PT2YUsp8xkCrD5f3+E84QN8VOMgWYUHJhG212jTskXAO17hdHaGVmbbBEL
	bs52NuPLsgGliaZLAsxdxFqcBpk1R80qJTWomSz5t9uLOktpEJF02RfTmQmZ00DFkGqssmmSjy93d
	iCj/Eur1WCZu/VIsTLDXzVdjCjufTI9PkBcZDewVOGBgD8xW6MNUyozvmaikKkvQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzVTU-0000000FTLC-196i;
	Fri, 19 Sep 2025 09:24:08 +0200
Message-ID: <6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	linux-kernel@vger.kernel.org
Date: Fri, 19 Sep 2025 09:24:07 +0200
In-Reply-To: <m28qib8g1r.wl-thehajime@gmail.com> (sfid-20250919_020320_735898_47C8CCD7)
References: <cover.1758181109.git.thehajime@gmail.com>
		<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
		<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
	 <m28qib8g1r.wl-thehajime@gmail.com> (sfid-20250919_020320_735898_47C8CCD7)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_002412_335288_387EF5D0 
X-CRM114-Status: GOOD (  13.31  )
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

On Fri, 2025-09-19 at 09:03 +0900, Hajime Tazaki wrote:
> > This doesn't make a lot of sense to me. Why would we even want to build
> > PCI on NOMMU-UML if PCI in general is dependent on MMU now?
> >=20
> > It's not like ARCH=3Dum with PCI and NOMMU has any value even for testi=
ng
> > if such a configuration cannot exist in reality?
>=20
> totally understand your point.
>=20
> now I see that we don't have to have this work around by using
> --kconfig_add option to kunit.py.
>=20
> # like --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=3Dn (in addition to
>   --kconfig_add CONFIG_MMU=3Dn).

That's not what I mean. I think it should be made impossible to build
the broken code.

The problem is probably UML_PCI_OVER_VIRTIO selecting UML_PCI selecting
various PCI code, but nothing depends on PCI in the first place. Which
it should, then?

johannes

