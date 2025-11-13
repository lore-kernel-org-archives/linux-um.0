Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E946ECD8C96
	for <linux-um@archiver.kernel.org>; Thu, 13 Nov 2025 15:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uxRT5z3+ifPoZ0211AWdMWgnKEBvwJ3HVrBmgq2vp/0=; b=uBTJBjNj8HggL4J41GSMCn67ec
	vGq3YbtcNJ6RkzvIPl+pH9rNn+8Iq6Q2KIUAjX2ZUf/G7bu5+FvSfHSTu8LWrIFcxV7775Bml8JdG
	Lx+Kl/PNICyrjNf6h5Xw3y9A/wUV7OYEKYVyUH4dezod4Cx0VgfdohuxF5LWiQBly1zenOdNu8MFe
	TCeR6OlfZV9VgSYE2TxiXJA7s01ElxfT5ISXikUDHWma+PGFgXkgA1fXP1LupA5l6lSMb3ed64pY4
	wOqVmG6pqkMap3fHrZHLji4zPzw2NKlYAwK1bk5YPgKxT7LdNL/pfuc9GiaypBICmbQ6qESnvC4kh
	slWS9kxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJZjO-0000000Akxr-2R1p;
	Thu, 13 Nov 2025 15:59:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJZjK-0000000AkxF-4C2g
	for linux-um@lists.infradead.org;
	Thu, 13 Nov 2025 15:59:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763049564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uxRT5z3+ifPoZ0211AWdMWgnKEBvwJ3HVrBmgq2vp/0=;
	b=NqDjKf5ar7c3kjH48HV3lW9yhW72yqX9gMR9hDbafz3nhzKc3uC8gpjSb+OvCyoH9K1N8i
	Jpr7AMLmh/o6POrCyV0GHxBCWbERRYrr99w6TQxRmJUm+u6cDoIsJL1eqUKvigh08Ft5bI
	QeBB+HfkiKTGNtKYEIXlyQlj+sujj4g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-Mli9sjUGPsGy1ANeOIyuvw-1; Thu, 13 Nov 2025 10:59:22 -0500
X-MC-Unique: Mli9sjUGPsGy1ANeOIyuvw-1
X-Mimecast-MFC-AGG-ID: Mli9sjUGPsGy1ANeOIyuvw_1763049561
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477632ce314so6068125e9.3
        for <linux-um@lists.infradead.org>; Thu, 13 Nov 2025 07:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049561; x=1763654361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxRT5z3+ifPoZ0211AWdMWgnKEBvwJ3HVrBmgq2vp/0=;
        b=uh15EwkvTh3mss5vkm2y+Ecmmt3xibhxyLGcQvlTHP6/onOYfIgUVbpOPYlq3YM9tv
         lI/MnC4HXFeBB/4bso878gaALExoJZfNkZsFTGDBSpeeaYD2AJugSX76HrNdt1nn4xxq
         5+Cz4NETQOd2IwKTlYFzKWCFhYtqUnRp5QqtTl6APhByTs6nh/B5VnKRvSnLG85WrEUI
         v3S4secRD7YX+BjhEUWSN9L5lR0+fWcmuAOSP0KChMEJNCFO0Ef9x7j2gdNHow8JZPAj
         TxQ+K61GxAMxjuAN656s6HRRZEpKVQNh0fBK4JB/iQlDEzh+9GZoEjuZPg2lxqh9jnpM
         Urkw==
X-Forwarded-Encrypted: i=1; AJvYcCX4Tx/JskMdndrnHqijayCUM5jaJJem/bqigTIkzXmfGusgPEkQ6PXnQe6zppByte/rGFfRNqiZ2g==@lists.infradead.org
X-Gm-Message-State: AOJu0YydH6iS6gb2Lbeelmc0XnLjPDoEjP71Q9qt9tBmx/2vIxp6QUJI
	ediqClJ2xTnSEUg9B5DYSYNSwSg6swYqmAvZdyo6A09r/pnf+NuZ20Q0rRTrI6eedoQ7wMg4uEA
	wuVbooq8nAaIyeiHTxaj0sCcG/7sfiJQII8LGx7ubNqPTNfdVKqiCwKEhlSTEdVjUeg==
X-Gm-Gg: ASbGncv65EWJM4kxJGUAw9gCfu1yk2EPCNLWr6iVx40MBZO2BQF1Soiys3vseQeIuoj
	Qmf5dQJoJhqJfayKXenMjcMKvObEymUQREnUK8uU8XdiriwP9dMXFKDmIXYIuzBhgPK4NzxFC1c
	3bh5ak/9A/2Ydv1nZZcGpWBvcBZyHhPGLACur+piaPPet1mJ6pdvc8e99DiCQ2mzBAPQkfDAGrX
	1foxv9s7WiVELcAy5dyJbDT4q8x+F1yMw1/YZmjgg40GeyBEqWVeUIgPvbPjk5/AcrJaSdo3mzD
	bEpzU4F3R3wSqIfgAVKVXnzKpPsLxBVTJsgWtGDoBoq4Xf2fxwleU1G5+5jhfHM15vyKyI1S/MH
	vv+yrgxfA9kWRwEeD5oY=
X-Received: by 2002:a05:600c:a44:b0:477:832c:86ae with SMTP id 5b1f17b1804b1-4778707ca20mr71013705e9.12.1763049561291;
        Thu, 13 Nov 2025 07:59:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHofPBYTP8F88iDpWUsKc8RAorynWUsDJxAs3/eKa1LXdZTVcuI1g6r5czDqfHcNjC7gedDcw==
X-Received: by 2002:a05:600c:a44:b0:477:832c:86ae with SMTP id 5b1f17b1804b1-4778707ca20mr71013415e9.12.1763049560788;
        Thu, 13 Nov 2025 07:59:20 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb30e3asm24606075e9.1.2025.11.13.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:59:20 -0800 (PST)
Date: Thu, 13 Nov 2025 10:59:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	linux-um@lists.infradead.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net v5 1/2] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20251113105844-mutt-send-email-mst@kernel.org>
References: <20251111111212.102083-1-xuanzhuo@linux.alibaba.com>
 <20251111111212.102083-2-xuanzhuo@linux.alibaba.com>
 <25b05194-63cd-4265-8d2c-e174d801fc3a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <25b05194-63cd-4265-8d2c-e174d801fc3a@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ERpyAhvJ1AFrIACqCjUpq-aeMDXAtj5wcO0ZCKMLz9c_1763049561
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_075927_113971_CA819308 
X-CRM114-Status: GOOD (  20.08  )
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

On Thu, Nov 13, 2025 at 03:39:35PM +0100, Paolo Abeni wrote:
> On 11/11/25 12:12 PM, Xuan Zhuo wrote:
> > The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > feature in virtio-net.
> > 
> > This feature requires virtio-net to set hdr_len to the actual header
> > length of the packet when transmitting, the number of
> > bytes from the start of the packet to the beginning of the
> > transport-layer payload.
> > 
> > However, in practice, hdr_len was being set using skb_headlen(skb),
> > which is clearly incorrect. This commit fixes that issue.
> > 
> > Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> IMHO this looks like more a new feature - namely,
> VIRTIO_NET_F_GUEST_HDRLEN support - than a fix.


I mean if guest negotiates VIRTIO_NET_F_GUEST_HDRLEN but the header
length is wrong then yes it is broken and this is a fix.


> [...]
> > @@ -2361,7 +2362,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
> >  	if (vnet_hdr_sz &&
> >  	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
> >  				    sizeof(struct virtio_net_hdr),
> > -				    vio_le(), true, 0)) {
> > +				    vio_le(), true, false, 0)) {
> >  		if (po->tp_version == TPACKET_V3)
> >  			prb_clear_blk_fill_status(&po->rx_ring);
> >  		goto drop_n_account;
> To reduce the diffstat, what about creating a __virtio_net_hdr_from_skb()
> variant (please find a better name) allowing the extra `hdrlen_negotiated`
> argument, define virtio_net_hdr_from_skb() as a wrapper of such helper
> withthe extra arg == false, and use the helper in the few places that
> really could use hdrlen?


