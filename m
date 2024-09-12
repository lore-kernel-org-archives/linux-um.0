Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C294EEB59D
	for <linux-um@archiver.kernel.org>; Thu, 12 Sep 2024 19:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m4uVIsmRBCQS8wsoLOk+4cGG0ABaeIsPxjbzr7hkfCw=; b=ymWjDaD1FJnaF5vRm8RdJO69si
	7zYl+hBQNdbCLS/NFBIkEfaRFCgQOZtnLSUwL+tH9MSDMrqXYTkGUDEMfNzLEaq0xdEswg7/X6Ius
	v0S9AdKw7J38fh7UexHI7zgE3kFZkBQA6Rt+BEK4GVs3WwO0fYrfyEKbAfs15drBr9N622UdBU65q
	XR6uP9TabwXEpGC+4u7lz9ue02LEj5o8lITG6cjlME0ab1XJDMfRTASVpqlpdor495O3WkxdVgOur
	m6EAMMkwgIGHRRLS1Cxcl0fncDArXKbW3nWoTmJMl9PDK+cHL6jOQYAd9+xvtalQSoRox2tpUr3b5
	Va9IVfHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sopcs-0000000E56I-3uEM;
	Thu, 12 Sep 2024 19:37:10 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sopco-0000000E55a-2aQj
	for linux-um@lists.infradead.org;
	Thu, 12 Sep 2024 19:37:08 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3DC0C626FAF7;
	Thu, 12 Sep 2024 21:37:04 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id OTU2KmO2FZ4A; Thu, 12 Sep 2024 21:37:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id AD138626FB02;
	Thu, 12 Sep 2024 21:37:03 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0XU1_VBP06iE; Thu, 12 Sep 2024 21:37:03 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8B334626FAF7;
	Thu, 12 Sep 2024 21:37:03 +0200 (CEST)
Date: Thu, 12 Sep 2024 21:37:03 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Matthew Wilcox <willy@infradead.org>
Cc: Li Zetao <lizetao1@huawei.com>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <108225933.37250.1726169823389.JavaMail.zimbra@nod.at>
In-Reply-To: <ZuM0xHQqSpen_xxY@casper.infradead.org>
References: <20240820025045.13339-1-lizetao1@huawei.com> <731546887.37035.1726165368713.JavaMail.zimbra@nod.at> <ZuM0xHQqSpen_xxY@casper.infradead.org>
Subject: Re: [PATCH -next] hostfs: Convert hostfs_writepage to use folio
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF130 (Linux)/8.8.12_GA_3809)
Thread-Topic: hostfs: Convert hostfs_writepage to use folio
Thread-Index: RplTndW6NFIHyOhW2DjJoD9i6RjPoQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_123706_820879_4247F174 
X-CRM114-Status: UNSURE (   4.34  )
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
> Von: "Matthew Wilcox" <willy@infradead.org>
>> > -=09buffer =3D kmap_local_page(page);
>> > +=09buffer =3D kmap_local_folio(folio, 0);
>=20
> These two lines assume that hostfs remains a non-large-folio filesystem.
> I'm not sure what the plans are for hostfs.

Somewhere deep on my TODO are plans to remove hostfs and replace it
with something such as 9p or virtiofs.
Any volunteers? :-)

Thanks,
//richard

