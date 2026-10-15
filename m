Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85F8CC6B34
	for <linux-um@archiver.kernel.org>; Thu, 15 Oct 2026 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zL4P1buyUO0HTa8tz5fIfgHMxvjhBM1cuXeP1N+bW10=; b=3pPg6Fx/3KVLE2x1rWzBllQzos
	huB9bcGSJhc2H0QHX0Kmt3OEVRmVWL/863CplXyqfEUfIOgWKNta7toyxS+VeUHynSIv/8bx1PbTX
	rER+srmyXg3QZ94122uKGDyGY2DUPq+8KWA0+CCutghrNXDBbz8HIIQ2hApUz2X9T3lje6ySdR/jT
	BWIOXfbJIuVgSrrXnDVlom/m2aIVwgOqR0A25oeLaF8uV03K+R5U4HCloE5XFanduu8HcpRvELtBp
	H8AnWqtit8R9asSTMK8dnhXKR8BMS6FsI9alH1mfu0iaC6CclWQFJ8rwDS/1jsyTcVV5yYoHiY2hy
	CF4/E/5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHKzo-00000000B5v-1OTY;
	Thu, 15 Oct 2026 12:55:44 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHKzi-00000000B1u-2EIX
	for linux-um@lists.infradead.org;
	Thu, 15 Oct 2026 12:55:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zL4P1buyUO0HTa8tz5fIfgHMxvjhBM1cuXeP1N+bW10=;
	t=1792068938; x=1793278538; b=MSxZMje/+/N806TMUUEsQ5myBXcDW2WUnP5w47srPrCICJ5
	mMTLqWgvhnk/FtladFoMBFSxysoe+XA+yvjRgJ+rVvDlITh9Pnaio2fGAvjU8nPAvfZpXSSZ7L2KX
	/X3VS71p1X33tUpUNNNU+jxnGV2YERTWRJWrUKz8QaXvJhHWM/5muIzIrSMRyZArnsH7S0mUq+JWN
	tCBzFBGIP1e/77YVt3m82mGdqwanqLaGW2mO7mJEME/4DhnxSTWclwfd6GFp24GaII2rSldv0L/To
	bVva6yRsnpzPEH4q9ot0agNHax6HBnMZ0LMae0M1Wv2oEUcf/ryhUtj+XtJZyNZg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xHKzU-00000003bXE-0Kyl;
	Thu, 15 Oct 2026 14:55:24 +0200
Message-ID: <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
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
Date: Thu, 15 Oct 2026 14:55:23 +0200
In-Reply-To: <20261015085119-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
	 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
	 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
	 <20261015085119-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_055538_625409_EC9CF70C 
X-CRM114-Status: GOOD (  21.74  )
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

On Thu, 2026-10-15 at 08:52 -0400, Michael S. Tsirkin wrote:
> On Thu, Oct 15, 2026 at 02:47:01PM +0200, Johannes Berg wrote:
> > On Thu, 2026-10-15 at 08:41 -0400, Michael S. Tsirkin wrote:
> > > virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> > > it cannot make sense of, but the vector raw transport ignored
> > > its return value: rejected packets went on into the stack with
> > > their metadata unvalidated.
> > >=20
> > > Propagate the failure.
> > >=20
> > > Assisted-by: LLM
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  arch/um/drivers/vector_transports.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/ve=
ctor_transports.c
> > > index e1fb2a76fdff..8b7548458663 100644
> > > --- a/arch/um/drivers/vector_transports.c
> > > +++ b/arch/um/drivers/vector_transports.c
> > > @@ -210,7 +210,9 @@ static int raw_verify_header(
> > >  		return 1;
> > > =20
> > >  	skb_set_network_header(skb, ETH_HLEN);
> > > -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian(=
));
> > > +	if (virtio_net_hdr_to_skb(skb, vheader,
> > > +			virtio_legacy_is_little_endian()) < 0)
> > > +		return -1;
> > >  	return 0;
> > >=20
> >=20
> > Seems it'd be simpler to just
> >=20
> > 	return virtio_net_hdr_to_skb(...);
> >=20
> > As far as I can tell, the function only returns -EINVAL or 0 (never a
> > positive value), and the caller only cares about negative (error) or
> > positive (no checksum needed), so that'd be equivalent?
> >=20
> > johannes
>=20
> if raw_verify_header can safely return any errno - i did not want to
> audit it.

You already used an LLM and still didn't want to? ;-)

I checked briefly (by hand) and it seems fine, it's assigned to the
function pointer, which only has two callers on the _kern.c side.

johannes

