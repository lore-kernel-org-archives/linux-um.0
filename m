Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EDDC9830E
	for <linux-um@archiver.kernel.org>; Thu, 24 Sep 2026 17:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E8FD4iT6RJg3BgIUMg1u6lq1AX2COPGo3VlgxX8d3j4=; b=e3qSoi73P/jz3anxuWOFOMqAam
	6hgYzxVFjcPtQeCF236bogZweyxu0ee0u3UOh0+R3AmQu08NUKRvfI7GjXIh7Pn1qOPmF2nsRo9lo
	rQo8PsbaASxZswCBKyJr0CLBHIw4v41J8CDBGSp7O8nEKXbVKeE8AADuLRdv7DQoinozmbkVvOjPB
	KOz8KQludhpMw5I/ioEHuOAVZq1e6yck3mStEATYjwwlaEm9CpT/RD66S8BRhEcJ9ikFbeFyM6BAq
	Q/OgPNyBFZm0WqV14Qd7X3b60XejnPtU6GOwFOZuu6cXMck0d5Cd4WGDVgSx6PawKipxHVONr34kR
	OYeifhyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9n5I-0000000Bhtq-1NWr;
	Thu, 24 Sep 2026 17:18:12 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9n5G-0000000BhtB-0SoB
	for linux-um@lists.infradead.org;
	Thu, 24 Sep 2026 17:18:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 990BF436D5;
	Thu, 24 Sep 2026 17:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84CF1F000FF;
	Thu, 24 Sep 2026 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270289;
	bh=E8FD4iT6RJg3BgIUMg1u6lq1AX2COPGo3VlgxX8d3j4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bFb1KWLfsVCfUNGf+4PHOZ6lOgMe6SwcajHMwk56U8Fa+GX2ljNEmHA5KRn3ss0ST
	 NTSEaL+MjRAJzME2l+QO1Mls8EstWL6jr6DxGSdjLtTEG3rsu2Jb0GTGx2DL+KGq3H
	 ipF40Ay6CajjrrElzhXEKf8h7IiadJUYcT5dZukeqXkCRZE3FmsdI64q+wiHTqqAO9
	 I2eQ1MgvqpKCGNuREB55Lt9UhM8kMQSLymhgu5F505Naiec7yVrCX50Bz5ToR8A5o+
	 THT4B0Ja6xkIIf2v+caT4h1lUIswlSDyyO9Oft/aoVXe8K+xBrgEsQXqEEkion/xnu
	 +yj1e5V91ReJQ==
Date: Thu, 24 Sep 2026 10:18:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Paulos Yibelo <habte.yibelo@gmail.com>,
 netdev@vger.kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, jasowangio@gmail.com, eperezma@redhat.com,
 xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch, pablo@netfilter.org,
 fw@strlen.de, phil@nwl.cc, razor@blackwall.org, idosch@nvidia.com,
 dsahern@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 horms@kernel.org, linux-um@lists.infradead.org,
 virtualization@lists.linux.dev, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
Message-ID: <20260924101808.638f2d22@kernel.org>
In-Reply-To: <20260923081209-mutt-send-email-mst@kernel.org>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
	<20260922030310.8684-2-habte.yibelo@gmail.com>
	<willemdebruijn.kernel.259bc7096258d@gmail.com>
	<willemdebruijn.kernel.2cdfef118aa1d@gmail.com>
	<20260923061215-mutt-send-email-mst@kernel.org>
	<CANn89iJaE5UarTdg6FMEp=rZ9mG3g=xrVRLyvMS5S02iE8CwGg@mail.gmail.com>
	<20260923081209-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 23 Sep 2026 22:02:57 -0400 Michael S. Tsirkin wrote:
> $ git grep 'skb->csum_start\ ='
> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:        skb->csum_start = (unsigned char *)th - skb->head;
> drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:        skb->csum_start = (unsigned char *)uh - skb->head;
> drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:        skb->csum_start = (unsigned char *)uh - skb->head;
> drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:        skb->csum_start = (unsigned char *)tcp - skb->head;
> drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:        skb->csum_start = (unsigned char *)tcp - skb->head;

These are HW-GRO, ASIC coalesced TCP segments so it better know 
the _correct_ offsets of things. And it's hardly remote-provided?

> drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:         skb->csum_start = skb_transport_header(skb) - skb->head;

selftest

