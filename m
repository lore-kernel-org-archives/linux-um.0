Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BEFD43369
	for <linux-um@archiver.kernel.org>; Thu,  7 Nov 2024 14:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8sJYvbPR3ENy+PnI0ObCarRn8/QmOnSdBCDtO3hJbu4=; b=AcW6n8FVUVk90gVJ4XGk53rV0r
	XoRTNtqbKVDT5R/X9u3ZgyW/KQ6RZp5C4AytgDyObWlUoBIEXUigKuJtzFn176lFrIq/V8/KSlp2e
	hL1l06Pn5lQKU6tYK3mdNSgwW/x7KRxPRw4Q3Q3M/0+tEgrbBH3yRoe5UV+D8kXJ0iIRf23BOeBdt
	DMedlokft537dwJ356v5cBf+gC2IK+MYIPw/b9BfF1x4Ofap/ke6nat0A5ypyD++qXuRjrGd4Ok5d
	wQw+GlTEJZe9QQyYr/ESIWVYb9/dgnZrhzgIRwNMkWVpWBeHAQC0Q6O/Yu9CKAeUFwYulpvOpLGBf
	aBxB+Y9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t93g8-00000007J8C-1567;
	Thu, 07 Nov 2024 14:40:08 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t93bz-00000007IUe-13kx
	for linux-um@lists.infradead.org;
	Thu, 07 Nov 2024 14:35:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8sJYvbPR3ENy+PnI0ObCarRn8/QmOnSdBCDtO3hJbu4=;
	t=1730990151; x=1732199751; b=QyJ0Rekwy75CBw4Ng2be2WkJebgr1wNHowSB19gDYgG3eGU
	OckMuflGlv9wPF+QpwwzFy5jX17YdFS4GwrutFKDl+XTstUiVjXUtgUsj10WsAIXAByYtPNj29JpD
	/thuwf/CHM6tw9pmruu3b8iM6psDmGd5VCLazlsPkwwZWOtrk7tB+nT4DztIu6+M9bYzBHLgfuZ3R
	FQsA9W8jzMt3zK2CdTcpX7HVBcPJfbh6Js+wwsDx6Ql9JwwNx8WuXCmOOVgKzf9QGiFv8MxG6128z
	DlOavHSlAO5Nam1j7oainWi6pm1jaYrMY0619e+1VIogi5Yb6kQllwJK1XnirXVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t93bt-0000000GSI2-3sTO;
	Thu, 07 Nov 2024 15:35:46 +0100
Message-ID: <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
Subject: Re: UML mount failure with Linux 6.11
From: Johannes Berg <johannes@sipsolutions.net>
To: Hongbo Li <lihongbo22@huawei.com>, rrs@debian.org
Cc: linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, Christian
 Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>
Date: Thu, 07 Nov 2024 15:35:45 +0100
In-Reply-To: <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
References: <857ff79f52ed50b4de8bbeec59c9820be4968183.camel@debian.org>
	 <2ea3c5c4a1ecaa60414e3ed6485057ea65ca1a6e.camel@sipsolutions.net>
	 <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
	 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
	 <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
	 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
	 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_063551_321632_473DE926 
X-CRM114-Status: GOOD (  12.98  )
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

On Thu, 2024-11-07 at 22:17 +0800, Hongbo Li wrote:
> > There's only one option anyway, so I'd think we just need to fix this
> > and not require the hostfs=3D key. Perhaps if and only if it starts wit=
h
> > hostfs=3D we can treat it as a key, otherwise treat it all as a dir? Bu=
t I
>=20
> May be we can do that (just record the unknown option in host_root_path=
=20
> when fs_parse failed). But this lead us to consider the case in which we=
=20
> should handle a long option -o unknown1,hostfs=3Dxxx,unknow2, which one=
=20
> should be treated as the root directory? For new mount api, it will call=
=20
> fsconfig three times to set the root directory. For older one, if one=20
> path with that name exactly, may be it can mount successfully.

Technically, comma _is_ valid in a dir name, as you say ... so perhaps
the new mount API handling would need to be modified to have an escape
for this and not split it automatically, if the underlying FS doesn't
want that? Or we just revert cd140ce9f611 too?

I feel like perhaps we just found a corner case - clearly the new mount
API assumes that mount options are always comma-separated, but, well,
turns out that's simply not true since hostfs has only a single option
and treats the whole thing as a single string.

johannes

