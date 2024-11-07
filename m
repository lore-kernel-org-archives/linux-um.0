Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEC7D43352
	for <linux-um@archiver.kernel.org>; Thu,  7 Nov 2024 13:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dhtxfJh1FLPzvT4jT0S+jmUarJJ1hUeU8sCCjAP29B0=; b=mSnn5kOwSQEounMSh/ZMevUUe3
	N1nPF+19AYNFFii3U3ojLMYHuQq/HEUijZEwqyOUJYgjUxGWNyWIrKYq6ttcDLWFWdAtIF86f+txz
	lDZm++NGEHnBtLlklrJo+XJ+GGkzqz2BCKX+ChsADRbRvR3wlxmDXHx+KSx1MO7CbfZTHPXjwIWfM
	zhq8s2gskhMKpuGr1QRVlwai6mj6qrJqh/+qCKKHnggFX8tmhqAtrRal0mQc9akc2G+4xuTZHIduv
	h0EXDMEM0bw7DP/W542XmHz/U7W6Nmh/VPBFFqMcELlhBc5Zvz/NBBgmEcM0Lp9zPRIWxAniGTbaf
	UTlt6Rpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t92GL-0000000738c-00qT;
	Thu, 07 Nov 2024 13:09:25 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t92GI-0000000735u-3d2D
	for linux-um@lists.infradead.org;
	Thu, 07 Nov 2024 13:09:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dhtxfJh1FLPzvT4jT0S+jmUarJJ1hUeU8sCCjAP29B0=;
	t=1730984960; x=1732194560; b=qdVUQqi23Eda4aO8sxCkqcpwWNtuVRJ8qQkqdGo3P+W0OZH
	h9QWQvCpMpK9LJzKtjs/gRFbbLmOxUufr86ZaqfPDd67C76WDtueC0mWexutO1fkgxPlACD/NTsHL
	f62fg3iJoCI7sXS86xMGD/GlJTcUmdqZ3XEVDIAhSAuHKCxk8K05+HChJ6QnuYAets6QLMf5xAD3f
	jX6ZqnU++AmbxvQZ1VExIqeaEmfxv++/ndopLzR6jdFIzr8bIjO476I0u0kYpe2gHqek9U6hbNCMw
	ZR4A/50mYBXQsbkGLi4pb9N+c26tTKmNTCikZy2P7+KFdcXLgm1s9NkT5uP/FmSA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t92GA-0000000GQ5w-1n2O;
	Thu, 07 Nov 2024 14:09:14 +0100
Message-ID: <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
Subject: Re: UML mount failure with Linux 6.11
From: Johannes Berg <johannes@sipsolutions.net>
To: Hongbo Li <lihongbo22@huawei.com>, rrs@debian.org, Benjamin Berg
	 <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, Christian
 Brauner <brauner@kernel.org>
Date: Thu, 07 Nov 2024 14:09:13 +0100
In-Reply-To: <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
References: <857ff79f52ed50b4de8bbeec59c9820be4968183.camel@debian.org>
	 <2ea3c5c4a1ecaa60414e3ed6485057ea65ca1a6e.camel@sipsolutions.net>
	 <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
	 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
	 <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_050922_923996_D68EC75E 
X-CRM114-Status: GOOD (  15.15  )
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

Hi,

So took me a while to grok the context, and to understand why it was
working for me, and broken on another machine...


> I have read the context in [1]. It seems your tool has already used new=
=20
> mount api to mount the hostfs.

Yes, however, that's a default that's entirely transparent to the user.
This is why I wasn't seeing the errors, depending on the machine I'm
running this on, because the 'mount' tool either uses the old or new
style and the user can never know.

> It now rejects unknown mount options as=20
> many other filesystems do regardless of its earlier behavior (which=20
> treats any option as the root directory in hostfs).

And that's clearly the root cause of this regression.

You can't even argue it's not a regression, because before cd140ce9f611
("hostfs: convert hostfs to use the new mount API") it still worked with
the new fsconfig() API, but with the old mount options...

> I'm not sure it is reasonable in this way. If we accept unknown option=
=20
> in the hostfs, it will be treated as root directory. But which one=20
> should be used (like mount -t hostfs -o unknown,/root/directory none=20
> /mnt). So in the conversion, we introduce the `hostfs` key to mark the=
=20
> root directory. May be we need more discussion about use case.

There's only one option anyway, so I'd think we just need to fix this
and not require the hostfs=3D key. Perhaps if and only if it starts with
hostfs=3D we can treat it as a key, otherwise treat it all as a dir? But I
guess the API wouldn't make that easy.

Anyway, I dunno, but it seems like a regression to me and we should try
to find a way to fix it.

johannes

