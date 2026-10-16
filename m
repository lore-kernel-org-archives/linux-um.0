Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35201CCA462
	for <linux-um@archiver.kernel.org>; Fri, 16 Oct 2026 09:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jEPuNhSxsbUvh+PW3O30AyJYlH++sXV5pTbl3odzk7E=; b=cOFFnC8qtJELsOS1MvmumZ8ot2
	n+2gC14Forr8VEYIrPZ++YRPbHA4nKNIatEpIzsyPz9uebW2lKNfxfzA4vv3mx+t2mhjZ1dgXHlLA
	PweDUcXNEmFbS/t4SQo2aaSXbTw1HOVDoJhvgCdd78CRRRCWBwNOjyY03KNOygspXDIH3CnRvsxAd
	o0VPdx1GEsnHEa6S6YMHCbZy01tQbjGHgkoYm8eEaVnBXAKDHnxXeXFQfkT2yeWDL/mHb2u3MnS8p
	2LLjIsu/xBXk2IVeZRuSaqKOmQRIntyuEoEKN6oM63MuYJ3ouZ11FgEJtgGoKr3vEuvkAh/BJhow4
	yPEW1eXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHeNk-00000002VEu-2EMq;
	Fri, 16 Oct 2026 09:37:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHeNh-00000002VEH-3Hxt
	for linux-um@lists.infradead.org;
	Fri, 16 Oct 2026 09:37:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792143460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEPuNhSxsbUvh+PW3O30AyJYlH++sXV5pTbl3odzk7E=;
	b=XqxYI4DH8gD1zWiiceV4GYWN5vqXxNZW3MUaeoAksja61e1oxNvvYh6l/elkWy0ibMlQ6T
	KEIJkh4h9f7sYd3hbQCHiFvhc8MRN/YzBipqt6dtldGydlkQYTyK//JQKOhILjaHnfh5Nn
	m/ZTCjAI6Ir49oiY6GTDQyojRxrKbNs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-7E6xW4SNO-We-MBB_XAFkg-1; Fri, 16 Oct 2026 09:37:38 +0000
X-MC-Unique: 7E6xW4SNO-We-MBB_XAFkg-1
X-Mimecast-MFC-AGG-ID: 7E6xW4SNO-We-MBB_XAFkg_1792143457
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c7fe9736eso5039915f8f.0
        for <linux-um@lists.infradead.org>; Fri, 16 Oct 2026 02:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143457; x=1792748257;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jEPuNhSxsbUvh+PW3O30AyJYlH++sXV5pTbl3odzk7E=;
        b=MCQROpcFo9gI3aG+/QYIlSfOQgQ8LvMfqg6OyI9pj5FuZ3Vwi/mxwqN3rdhOmWaqNb
         iNrm9MSrzQRtTvjukpm2LRet6b0Vg9g+Pvqr5IXzxDmFdeG3iCXbUNWMgHfPfJU5Abky
         WWTIW+c/9exU4fOq7dihqyrT8tj/jkOQ5u3x77cLYqszbB9Ad0ObHI+XV2Q52On9uBgh
         jZKxHCYulP7nPkBDRS2+QNMtXb8enbspesUfAiI5wWqn0zJKQ0YAMsrKpJYpQXp9nnh/
         VMkdaU0p4Lw9n7mUrO1NlLzcoqIhW3I+1aYAYRppj7f1s8340Hmzr/Xd4RDso1c8u6p5
         XoxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpWspP636QdabmIzUKomzCE5t3w3RPZomWoULOeYFe4a6+KHmSL9aAW3yrydE4+FpRclkOf0dQEA==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ3sX3wuOka3Ky9rVXOnin2BHkEizg7FraW54dFEceF9TPB5GTO
	/IK8tjSbW5yyt3PTGwxmK6aX0LPrvp4LJ4Di5ZFXkaDMnDr2z7F99BTNSKO21rhcs13Jlpsfas5
	1jl3UqqwK1yRgzTb8icXVcFXWxd5H65SuVyE2lL/oCjf3Jf9ovuiyXCqbGuzVEHYH6Q==
X-Gm-Gg: AYBFou2aCO56Ej5and/+4xDeX2zeCx3KhlWOM0bV/M9RIqU2TjpRvAUVo6CV6kgZkBl
	tbsfcA29af/JROkZTzAezM9MEgFCm6tVljze2OLl2+q8uDe/gzjyIC34KdupoFlv4bcl1dJrQoF
	DnJrqITV/rIHP9UYtpdLGJMrNOvATLoWXwWYxH/TSlaMvbVjCCU9aMJKSDHawuGh9RuZ9kROF3u
	lLjXIJb1tEFT9NBLFpQjoTwBU1tL/4czeVHgNQYJc9zZSdiZw7M+nT9uWSor7VZmpZMCNVI0FZK
	g0io/FYZ6l46zIna+WjBGcXK09iHjSTB+ygNUDNsbtHKijitZlrcAz64A/QJConA7tbQuA==
X-Received: by 2002:a5d:64e3:0:b0:48d:fd48:86c0 with SMTP id ffacd0b85a97d-48dfd48878dmr4550996f8f.47.1792143457359;
        Fri, 16 Oct 2026 02:37:37 -0700 (PDT)
X-Received: by 2002:a5d:64e3:0:b0:48d:fd48:86c0 with SMTP id ffacd0b85a97d-48dfd48878dmr4550928f8f.47.1792143456859;
        Fri, 16 Oct 2026 02:37:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5008e7sm3899434f8f.43.2026.10.16.02.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:37:36 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:37:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
Message-ID: <20261016053633-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
 <20261015085119-mutt-send-email-mst@kernel.org>
 <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
MIME-Version: 1.0
In-Reply-To: <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IaTxHi7haONfInckJjnGdrlry3y1Ei943d1jKzKhovU_1792143457
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_023741_972196_12117485 
X-CRM114-Status: GOOD (  26.28  )
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

On Thu, Oct 15, 2026 at 02:55:23PM +0200, Johannes Berg wrote:
> On Thu, 2026-10-15 at 08:52 -0400, Michael S. Tsirkin wrote:
> > On Thu, Oct 15, 2026 at 02:47:01PM +0200, Johannes Berg wrote:
> > > On Thu, 2026-10-15 at 08:41 -0400, Michael S. Tsirkin wrote:
> > > > virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> > > > it cannot make sense of, but the vector raw transport ignored
> > > > its return value: rejected packets went on into the stack with
> > > > their metadata unvalidated.
> > > > 
> > > > Propagate the failure.
> > > > 
> > > > Assisted-by: LLM
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  arch/um/drivers/vector_transports.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> > > > index e1fb2a76fdff..8b7548458663 100644
> > > > --- a/arch/um/drivers/vector_transports.c
> > > > +++ b/arch/um/drivers/vector_transports.c
> > > > @@ -210,7 +210,9 @@ static int raw_verify_header(
> > > >  		return 1;
> > > >  
> > > >  	skb_set_network_header(skb, ETH_HLEN);
> > > > -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> > > > +	if (virtio_net_hdr_to_skb(skb, vheader,
> > > > +			virtio_legacy_is_little_endian()) < 0)
> > > > +		return -1;
> > > >  	return 0;
> > > > 
> > > 
> > > Seems it'd be simpler to just
> > > 
> > > 	return virtio_net_hdr_to_skb(...);
> > > 
> > > As far as I can tell, the function only returns -EINVAL or 0 (never a
> > > positive value), and the caller only cares about negative (error) or
> > > positive (no checksum needed), so that'd be equivalent?
> > > 
> > > johannes
> > 
> > if raw_verify_header can safely return any errno - i did not want to
> > audit it.
> 
> You already used an LLM and still didn't want to? ;-)

I don't really trust it to do code audits especially in code I
do not test.

> I checked briefly (by hand) and it seems fine, it's assigned to the
> function pointer, which only has two callers on the _kern.c side.
> 
> johannes

Thanks, will make the change.

-- 
MST


