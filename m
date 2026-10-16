Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFBECCA464
	for <linux-um@archiver.kernel.org>; Fri, 16 Oct 2026 09:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gKAEMOgSpCC5WNfMnsDV7LsCcJsKMz8C9HIBbCyHHMs=; b=EydMLMH5qRKvU7/HRjdWH6XsTX
	htkW2oIKSSW73TWFMB1wqnTmv+bKtwDBhpOHPBVDeMhDzpW2ZICQzaT28Mk0Hi4je1Ng6wHt4/sJY
	b1XFNfiZiCU9eagnnf8xw2N9n80FXTLKddvwzKkcEw78RHB4dNquSZZcl8ua7yQugizGMd3ljfD0t
	4Xz+a+otx/TjVhzFbzw1qnTcnf7hQ8Why+fxrIhwwC2Wa+jW5Thv77b01loBOVZKF2EC+D2BaiXqF
	tMVOlihVHlaxp4WlUletkodFHxV8Mp3FYiowcbQ+8lH8kVwJ4ba0IdFqniXDfb9VijtW+nAjZOZqI
	4MUyLGfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHeZD-00000002XN0-19gZ;
	Fri, 16 Oct 2026 09:49:35 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHeZB-00000002XM7-0NGV
	for linux-um@lists.infradead.org;
	Fri, 16 Oct 2026 09:49:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gKAEMOgSpCC5WNfMnsDV7LsCcJsKMz8C9HIBbCyHHMs=;
	t=1792144172; x=1793353772; b=XgIxhHMD4eOO2Lb/ixTqTh6ebvgXN/Q2Lf1agb8FQX7cS7Z
	sFpViX+9c/W/3OSFgMEwNsf/y92i2KaehB/aL8yU4Vfnfkwow+8rgQrdXzsWZBENZB13Dauv48yd9
	kojehciqKeJ72c+bcBefatLdMfbdo/p1DLYvxVc4b/1qC6fOT7Od8/DAdM4n+t64XlB5b80oJpVzu
	7nVP7K6yllrtYsW55hMR90FP6SGtHw8DKIzxl/ZZcPm6gkjSo/RiZrF6pL0oKw0co0TUU5daqAMig
	Bxn1W6A4YEUttnkNQQZUybHvaKcyau2UJtDCl/6rNmZ23HD8RsW2kBu3vGHtKWaA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xHeYu-00000005fFz-1IMS;
	Fri, 16 Oct 2026 11:49:16 +0200
Message-ID: <77e9eb61d0e81ead5d5840abb95ffbd695a4e513.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
From: Johannes Berg <johannes@sipsolutions.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Willem de Bruijn	
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>, 
 Eugenio =?ISO-8859-1?Q?P=E9rez?=	 <eperezma@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Andrew Lunn	 <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,  Rusty Russell
 <rusty@rustcorp.com.au>, Max Krasnyansky <maxk@qualcomm.com>, Richard
 Weinberger <richard@nod.at>,  Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Date: Fri, 16 Oct 2026 11:49:14 +0200
In-Reply-To: <20261016054558-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
	 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
	 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
	 <20261015085119-mutt-send-email-mst@kernel.org>
	 <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
	 <20261016054142-mutt-send-email-mst@kernel.org>
	 <18ba10ec7aa6659ee4711f8dd3f3138e314e4af6.camel@sipsolutions.net>
	 <20261016054558-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_024933_125492_6B66FC51 
X-CRM114-Status: UNSURE (   8.74  )
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

On Fri, 2026-10-16 at 05:47 -0400, Michael S. Tsirkin wrote:
> > >=20
> > Right, but virtio_net_hdr_to_skb() cannot return 1, only 0 on success
> > and -ERROR on failure?
>=20
> After this patchset, it can, to signal slow path software checksum.
> I'm changing callers first so that changing the function itself
> does not break bisect. I should mention this in the commit log.

Oh, OK, that I clearly missed, but also was only CC'ed on patches 2 and
3 :)

johannes

