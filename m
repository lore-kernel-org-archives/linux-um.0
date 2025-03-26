Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2ECC3600D
	for <linux-um@archiver.kernel.org>; Wed, 26 Mar 2025 07:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wvd0OJ44K5w+np0/QivAVSUvw4m6lF/nF2H0AyTchyY=; b=kaKAafI5WLgGW4L8BVsHVQAOz9
	ZZ3wQeTflslxzbRb6yzfZ2XwupWguCWaP6fDWsMJ5xIFqmwR2o+QQ/OWRdOcaACJ5WrYaQvi12zYO
	AqKqBNKuHe4skgSypRoZHCjeH1wVUxTcG08i6bNBPi9nePP+8BxzOXZfP2NqU4+12YlD0RIjCRqeb
	G7CVkF6QyPpxHNxapW7ma5ulMR3OK7HEz+HzsyX3+jLsgO3Mx9aH7Wa0X9mb2UALt4jZCqgOaZoMV
	b+Io24Mji3P9+Sm2xaJtE3vMYgjqFvFEPt3YhEDQQglcLF4KBqvI0BhOjS88LT12qg24Kl3H+io+/
	ESDoiyOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txL12-00000007l8h-0cbg;
	Wed, 26 Mar 2025 07:17:32 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txKy3-00000007ksg-0yVW
	for linux-um@lists.infradead.org;
	Wed, 26 Mar 2025 07:14:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wvd0OJ44K5w+np0/QivAVSUvw4m6lF/nF2H0AyTchyY=;
	t=1742973263; x=1744182863; b=LdtipaUG5AY1IMm0X6QYwtByjbKAmpXK/Yc0teEFvUHfNUa
	jXRe2X7U5TB79xeh9H+eViSZNO4oudm7odz/YUQx18At271T0BPgDMyZO+/g414Ej/otXWZIvoZIe
	N5fFkqdQ0laYYBANdeXKjoUJQAiV0ColL4R61Gcb7g/BYWdF07JzQe0z0CtxwNu58d0yDK/PwrC5t
	PYLUSIo9r51gVCWbRyR40pHWWzFQzYTv3/cLWAlznXBQXKSE90gXJqi2Xexv0AZKZAkhjWA5/Nq6K
	6jJMCvezSNFuT7vDaNCQgdou5VXo7GhpisZMI0CHaobZ1nMaz6ZgEdPl80KsmHRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1txKxk-000000060qg-16cB;
	Wed, 26 Mar 2025 08:14:13 +0100
Message-ID: <55789848dc2367f3cfe09d7c89635ab218c53658.camel@sipsolutions.net>
Subject: Re: [PATCH v3 4/4] um: Prohibit the VM_CLONE flag in
 run_helper_thread()
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org
Date: Wed, 26 Mar 2025 08:13:58 +0100
In-Reply-To: <22d09a9d-d00a-40ca-80e1-86fb07caa0a6@antgroup.com>
References: <20250319135523.97050-1-tiwei.btw@antgroup.com>
	 <20250319135523.97050-5-tiwei.btw@antgroup.com>
	 <495e4b66edcc65ba9630cf1bbbb119b971af2df6.camel@sipsolutions.net>
	 <22d09a9d-d00a-40ca-80e1-86fb07caa0a6@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250326_001427_545656_0D89F4E5 
X-CRM114-Status: GOOD (  13.16  )
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

On Wed, 2025-03-26 at 14:54 +0800, Tiwei Bie wrote:
> On 2025/3/20 16:32, Johannes Berg wrote:
> > On Wed, 2025-03-19 at 21:55 +0800, Tiwei Bie wrote:
> > > Directly creating helper threads with VM_CLONE using clone can
> > > compromise the thread safety of errno. Since all these helper
> > > threads have been converted to use os_run_helper_thread(), let's
> > > prevent using this flag in run_helper_thread().
> > >=20
> >=20
> > I notice that now there's only one user left, the SIGWINCH handler,
> > maybe we could change that too? Anyway not related to this patch, of
> > course.
>=20
> After taking a closer look, changing the SIGWINCH handler seems to
> be tricky. It requires setting itself up as a session leader and
> configuring the controlling terminal. So it seems that it can't be
> turned into a real thread..
>=20

Fair enough. Thanks for checking!

johannes

