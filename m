Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903ABC02183
	for <linux-um@archiver.kernel.org>; Sun, 19 Jan 2025 13:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0rQQjjGLP1l7cST3uxKf9fm7yd12+ESXQyXo9+Ero1Y=; b=z5PVJSCWttJDtiqWf0YhH1OjGy
	9KPQRu3X3iaFHBT9VyfqH/NbmW5Bl/lftpi29o4XF5+V1eCfyqbac7uujLI3JzJN68b/oYuuLtX9o
	Ea1i8l9Pdm57DfVrBFLbjcBq3atG/y9aZDkaCuA7auou1a5YhgzwCb/y7PS0XjjXQGyjMhXmbrQ7J
	DK3ZoI0ayBaUN1OsB0Z3b0pjtEaREtSDtyA03E6do7mEnbvwo4yyOWs2lwD0i6r66okDkLJ5603tR
	E7BlGUtO/khPjS5P+w8pzj77HjjgResFfOKkk6w8hlKaWNu7p2g9cJwRD06B7xcgmS9f8AjaLqCS0
	0vAqu+zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZVTf-00000003xBM-01aw;
	Sun, 19 Jan 2025 13:36:35 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZVTZ-00000003x9y-1Utg
	for linux-um@lists.infradead.org;
	Sun, 19 Jan 2025 13:36:31 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E47CA2B8740;
	Sun, 19 Jan 2025 14:36:17 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id AwCqhX2vHDqG; Sun, 19 Jan 2025 14:36:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 13E192B8741;
	Sun, 19 Jan 2025 14:36:17 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zE0df5_FnQC8; Sun, 19 Jan 2025 14:36:17 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id E971D2B8740;
	Sun, 19 Jan 2025 14:36:16 +0100 (CET)
Date: Sun, 19 Jan 2025 14:36:16 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-um <linux-um@lists.infradead.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <1595202043.249250399.1737293776824.JavaMail.zimbra@nod.at>
In-Reply-To: <20250117230913.GS1977892@ZenIV>
References: <20250117230913.GS1977892@ZenIV>
Subject: Re: [PATCH] hostfs: fix string handling in __dentry_name()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF133 (Linux)/8.8.12_GA_3809)
Thread-Topic: hostfs: fix string handling in __dentry_name()
Thread-Index: wPeoYBxf0bRbYOKou83hfnIuiIUm6A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_053629_567455_82FD5BDE 
X-CRM114-Status: UNSURE (   3.73  )
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

----- Urspr=C3=BCngliche Mail -----
> Von: "Al Viro" <viro@zeniv.linux.org.uk>
> An: "richard" <richard@nod.at>
> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-fsdevel" <linux-fsd=
evel@vger.kernel.org>
> Gesendet: Samstag, 18. Januar 2025 00:09:13
> Betreff: [PATCH] hostfs: fix string handling in __dentry_name()

> [in viro/vfs.git#fixes, going to Linus unless anyone objects]
>=20
> strcpy() should not be used with destination potentially overlapping
> the source; what's more, strscpy() in there is pointless - we already
> know the amount we want to copy; might as well use memcpy().
>=20
> Fixes: c278e81b8a02 "hostfs: Remove open coded strcpy()"

Hmm, AFAICT the open coded strcpy() was also never safe wrt. overlapping st=
rings.

Beside of that:
Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

