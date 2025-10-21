Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5827CCD1A7
	for <linux-um@archiver.kernel.org>; Tue, 21 Oct 2025 13:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AkHBvluqEAhBVuY5qakHEhb8DpY+qUwXRRCxYI3Rcw4=; b=EjO1CmZcuOfyQxBSbvRj1XS+6r
	Y7sHYOw/1umtjJUiCwNpGJ+RanVT5Xw+rGLUMTOyh494+imv+663er5uTam/NZgukQCy5bWdyYWO6
	qHIvCwizTuYmatJmAk4/J6eX0MWEDbh+v2vRa3ylOu3vGuAk8lgX/HBUg3ntZr/zePYXCAAAv04QR
	Y/641djnFNtQEJUQxN3cuqsVJ+uhV06j0sgJZHp65c0jOepYfA1KV57D+TTlXufWYU8BEs93RgQvt
	5826wh+0FNd7akn+uTiKqkHAfM6J6B396vCtl3WgevO0GdzN+aOgyJy4lUUJ+VD2LzgbFBsnGLoZy
	RXUxEZPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBCIa-0000000H87j-3wgJ;
	Tue, 21 Oct 2025 13:21:12 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBCIW-0000000H86l-0fD6
	for linux-um@lists.infradead.org;
	Tue, 21 Oct 2025 13:21:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AkHBvluqEAhBVuY5qakHEhb8DpY+qUwXRRCxYI3Rcw4=;
	t=1761052868; x=1762262468; b=b/8+plw+ya5Y/2dlMHkLQD9wDlYFjbFBhlilc4VbJ+3FAj3
	0bubXolxbRLqrq4SQISUhVYSmBFTAZ8sqmS/fAVV9Fyhbvk09HGf8/jyX+kzN4f/s1/syW0DEiYhM
	C3micdDv46MTZohoa+GDaLrNjAV7q962f/nIw2IjhHOxCeJ2EjG9jVo29RK+c3iyXVrgKxbo6batG
	cB69I1IXVcbseQg9bfQoU97onDVWFwOflZ83WRjRPBQt55WTdNFC3XoMWZLTTBdn0fO6zKH0WPfxi
	j/HwJsRRgPrym6afg5lycEXlBW99UByuWUaAuiFknqo9FAuQjO1XxyZazcUXC4zA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vBCII-0000000BrDl-3dF6;
	Tue, 21 Oct 2025 15:20:55 +0200
Message-ID: <fc93795ff03dc767a800a18a6ef33ff778f13b5d.camel@sipsolutions.net>
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
From: Johannes Berg <johannes@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, benjamin@sipsolutions.net, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tiwei.btw@antgroup.com
Date: Tue, 21 Oct 2025 15:20:54 +0200
In-Reply-To: <96ae8e726480a36a37d472106b761a141394e845.camel@sipsolutions.net>
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
		 <20250922045020.48158-1-tiwei.bie@linux.dev>
		 <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de>
		 <76b5ba35f864764100c9a5a00d50d8fa4276cd98.camel@sipsolutions.net>
		 <21755635-74d4-4fa4-8ffd-371c17630fdf@t-8ch.de>
		 <366bb558c3fd23b9a80008d923f29ed0234e17b9.camel@sipsolutions.net>
		 <61ae09df-d65b-4c9d-a0c1-7de915246590@t-8ch.de>
		 (sfid-20250922_180452_263852_EC16D5FF) <96ae8e726480a36a37d472106b761a141394e845.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_062108_193367_25952534 
X-CRM114-Status: UNSURE (   9.44  )
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

On Mon, 2025-09-22 at 19:07 +0200, Johannes Berg wrote:
>=20
> I actually have half a patch somewhere that rejiggers the UM vDSO to be
> more like normal architectures, using lib/vdso/gettimeofday.c and making
> the build more regular etc. Maybe I should dig that up and try to make
> it work entirely - it was part of a previous attempt of adding the time-
> travel thing I mentioned.

So that patch is almost 5 years old and with all the VDSO rework since
then, there's no way I can make that work again right now ... I guess
it'd be better to start from scratch and make a real VDSO for UML.

I'll take a look at your cleanups though.

joahnnes

