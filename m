Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AD6EED63F
	for <linux-um@archiver.kernel.org>; Thu, 12 Sep 2024 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kRatey23ezzw1PAc3MjEGSreQODE5O3C2Hi7EnHffb0=; b=X0fuoro52u2Qa1lk86e2gYHTJW
	NcKJ0bDtNxKdoEXU0oeEiNjnjy4jgkoOF9sGHDriAXAGZODy2Ujl8054EFH1vG87As0S2i0Zrb0DA
	Ux6aJf+F3msG1oTDFbPyiIy27+UU7ytvSPm2Xfe//NgxLYIPTuLn4VESzsq0Tac/GIk8egrBacK7h
	zmh/0yGaepQHWdla9O34OzqUI1q8mcz8JV65UsxBKxgQrd3GX/RTZWKFVLT0zzhqX6taWkr2c0CvP
	E/2mp+r4UXmiJcEIPYoDsHt7D8VGk+gGGhEcheE4coQpvEVx+rQTvYchIE1Pezs+lvezy7quLVWIR
	eYJv5lJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soooM-0000000Dxgs-1E62;
	Thu, 12 Sep 2024 18:44:58 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sooT7-0000000DuL9-1NQm
	for linux-um@lists.infradead.org;
	Thu, 12 Sep 2024 18:23:04 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B502463CF3CE;
	Thu, 12 Sep 2024 20:22:49 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id wQSje5n0g5F7; Thu, 12 Sep 2024 20:22:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0420F63CF3E9;
	Thu, 12 Sep 2024 20:22:49 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3E5Un_6qz49c; Thu, 12 Sep 2024 20:22:48 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id D118F63CF3CE;
	Thu, 12 Sep 2024 20:22:48 +0200 (CEST)
Date: Thu, 12 Sep 2024 20:22:48 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Li Zetao <lizetao1@huawei.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, willy@infradead.org
Message-ID: <731546887.37035.1726165368713.JavaMail.zimbra@nod.at>
In-Reply-To: <20240820025045.13339-1-lizetao1@huawei.com>
References: <20240820025045.13339-1-lizetao1@huawei.com>
Subject: Re: [PATCH -next] hostfs: Convert hostfs_writepage to use folio
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF130 (Linux)/8.8.12_GA_3809)
Thread-Topic: hostfs: Convert hostfs_writepage to use folio
Thread-Index: Oc379SI6AfvPdJhPk8fAeiJLwgXW+w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_112301_675774_0A7B5713 
X-CRM114-Status: GOOD (  11.62  )
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
> Von: "Li Zetao" <lizetao1@huawei.com>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>
> CC: lizetao1@huawei.com, "linux-um" <linux-um@lists.infradead.org>, "linu=
x-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Dienstag, 20. August 2024 04:50:45
> Betreff: [PATCH -next] hostfs: Convert hostfs_writepage to use folio

> convert to use folio, so that we can get rid of 'page->index' to
> prepare for removal of 'index' field in structure page [1].
>=20
> [1]: https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/
>=20
> Cc: Matthew Wilcox <willy@infradead.org>

You patch submission didn't CC Matthew. Adding him now.

> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
> fs/hostfs/hostfs_kern.c | 13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index 6d1cf2436ead..e17e70f20fa1 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -411,18 +411,19 @@ static const struct file_operations hostfs_dir_fops=
 =3D {
>=20
> static int hostfs_writepage(struct page *page, struct writeback_control *=
wbc)
> {
> -=09struct address_space *mapping =3D page->mapping;
> -=09struct inode *inode =3D mapping->host;
> +=09struct folio *folio =3D page_folio(page);
> +=09struct address_space *mapping =3D folio->mapping;
> +=09struct inode *inode =3D folio_inode(folio);
> =09char *buffer;
> -=09loff_t base =3D page_offset(page);
> +=09loff_t base =3D folio_pos(folio);
> =09int count =3D PAGE_SIZE;
> =09int end_index =3D inode->i_size >> PAGE_SHIFT;
> =09int err;
>=20
> -=09if (page->index >=3D end_index)
> +=09if (folio->index >=3D end_index)
> =09=09count =3D inode->i_size & (PAGE_SIZE-1);
>=20
> -=09buffer =3D kmap_local_page(page);
> +=09buffer =3D kmap_local_folio(folio, 0);
>=20
> =09err =3D write_file(HOSTFS_I(inode)->fd, &base, buffer, count);
> =09if (err !=3D count) {
> @@ -439,7 +440,7 @@ static int hostfs_writepage(struct page *page, struct
> writeback_control *wbc)
>=20
>  out:
> =09kunmap_local(buffer);
> -=09unlock_page(page);
> +=09folio_unlock(folio);
>=20
> =09return err;
> }
> --
> 2.34.1

