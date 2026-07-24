Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC006C531C9
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 06:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r+/bsIhy2yXFidFq0A8KA9a+vlTLLBAx0HHeRFYX5w0=; b=E8t3qRaXNGV9m7oaUs4gaE1Q+N
	+RsM2aZM+RKsHLVBWA0IwwSvsjjwbbuokFDIQxOGOobKYbFeY2isw7w8bk4jkXFiUZuI87PolN0xR
	7icNzi5n5I87D3XS538wmGeLcEqPldXHZswPFgSzmy/l+4jDb/jLmzqsFO6eXbamUMUyiA4IOCV69
	zvCVCOfCMwjden78YoQty1LJeS/HHFRsLlciF8fO4jCR6CEe3mOqY3PUe9BDsrUu2XD0zRIReI8l2
	ymOxsBf+2cjnwFU9c2e4GrGOJ0wpsnbRaMkhTBK5ZO5tIUiBZKTwgvLT/XBCm2yxt138oG4a1youf
	qm4SOtgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn9nr-0000000Fdss-1CtX;
	Fri, 24 Jul 2026 06:54:39 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn9no-0000000FdsV-0Upq
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 06:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=r+/bsIhy2yXFidFq0A8KA9a+vlTLLBAx0HHeRFYX5w0=;
	t=1784876076; x=1786085676; b=mLKsImQ6qDNeLxsEj5QLC2vtt4eHPhUco5Pk4X89fU+YgpD
	cbMCoBfHy/Eq5iwscwci6iqOdzEdpYQSPirQmZr1POp30B1lsaGSm2YGvOMhni5/X0/e57cPGzDs1
	2Jpj23QfVdxqcC7bx0KPURimJoQyGkvyOh2yF4zk9YKfz4ne6XfiJISjHpgrufs4eU9OTVOf39ML4
	DVXOng19ch5aR+ZiL6/KWZJqwS5SoUPvzUIZgCkLJleqPb/S+YnbfU6h4ZeBNe2A6EmVIMinmPszW
	9Hke7TY5j3NR3v/0F/fH+pFG5LtvTYVdyPpNX6iaM8jjCS2nPGkIg6UhLPwxGlPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wn9nj-000000021Bd-08zx;
	Fri, 24 Jul 2026 08:54:31 +0200
Message-ID: <c5c1a16d1be4658e2f797b21fdfe5f4dc3d9a168.camel@sipsolutions.net>
Subject: Re: [PATCH v2 04/10] um: change machine name for uname output
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, liam@infradead.org, ljs@kernel.org, 
	ricarkol@google.com
Date: Fri, 24 Jul 2026 08:54:30 +0200
In-Reply-To: <m1ecgs9908.wl-thehajime@gmail.com> (sfid-20260724_085023_563999_FBEF52CC)
References: <20260723093633.140989-12-johannes@sipsolutions.net>
		<20260723113633.bcaf234695c5.I226381aaaf6dd46c559b0e694b29370d0102ce3f@changeid>
	 <m1ecgs9908.wl-thehajime@gmail.com> (sfid-20260724_085023_563999_FBEF52CC)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_235436_176375_775FE38F 
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

On Fri, 2026-07-24 at 15:50 +0900, Hajime Tazaki wrote:
> On Thu, 23 Jul 2026 18:35:45 +0900,
> Johannes Berg wrote:
> >=20
> > From: Hajime Tazaki <thehajime@gmail.com>
> >=20
> > This commit tries to display MMU/!MMU mode from the output of uname(2)
> > so that users can distinguish which mode of UML is running right now.
> >=20
> > Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> > [remove / to fix regression with systemd userspace]
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > ---
> > v2: regression fix
>=20
> I'd like to know what kind of regression did you see.

With your original change, systemd doesn't boot, it asserts here:
https://github.com/systemd/systemd/blob/main/src/basic/architecture.c#L136

> with only this diff, there is no visible changes with uname command on
> UML (both mmu/nommu), as setup_machinename() overwrite this.

Oops. I never tested it, sorry. Just saw the boot failure with my
standard 64-bit (and maybe 32-bit as well?) boot test filesystems.

> maybe we could drop this patch if we cannot put a name 'um' in the
> machine name ?

Sure, we can drop it. Or arrange so only nommu is different? Or even
call it SUBARCH-nommu?

johannes

