Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1917CD1297
	for <linux-um@archiver.kernel.org>; Tue, 11 Nov 2025 11:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nVqpNz4zmQtnhgYeVe3TQQhFUL1KimGDuNjnX3WYQhU=; b=lDDCmsN0NwWerKtP9vLB/Kv9xg
	Uzt0jVglPPT7XBtuS2Ru48Z9I8hLaUPmun6QdOdm8KjbHX77i/UFiDI+Z3zIyt0Hfg8Soy0Cz7p9R
	rjh+Ysjf4jhXMJIP428Jrs0QbpRIwG39C7WzMZV9JmJJPlr7sQSULf4Rw9Yja3F2/lnWCbhrjc713
	AkhHmDaxio7tN4I6jPBsfRUsedtYw/mTQedLGJTwZJG8vJXD8SSd9Vl6yM0nzbAEaUnfz6HGy1oVX
	wkNjwfWIuxE2rkAt/B4EdeiuwNMdH0xzFz6OI9QWulDSJSsOm9uh9Lq29onUlT1v2M3udp2nNT7D4
	xBuPnwuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vImIS-000000073AD-1Lga;
	Tue, 11 Nov 2025 11:12:24 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vImIO-0000000738n-1uaJ
	for linux-um@lists.infradead.org;
	Tue, 11 Nov 2025 11:12:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762859537; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nVqpNz4zmQtnhgYeVe3TQQhFUL1KimGDuNjnX3WYQhU=;
	b=r7Mtob/sIq6TW8s1zoFopZI/oBbFyZ54r8lE3GCO+pnCEyIZNp7InUY9oAbonLXrEACO5hSraABuJGb//kyO2p7Dc4MbHQVFbn4799SYr6PSPO2UCGoioztJY62eEXLQTFTzxABapDAVfy8X7U9twBLpNfYBOR+ld04JBnEoSqE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WsBONCA_1762859532 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Nov 2025 19:12:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	linux-um@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: [PATCH net v5 0/2] virtio-net: fix for VIRTIO_NET_F_GUEST_HDRLEN
Date: Tue, 11 Nov 2025 19:12:10 +0800
Message-Id: <20251111111212.102083-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: feb36a32054d
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_031220_886917_158E7496 
X-CRM114-Status: UNSURE (   7.70  )
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

The commit be50da3e9d4a ("net: virtio_net: implement exact header length
guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
feature in virtio-net.

This feature requires virtio-net to set hdr_len to the actual header
length of the packet when transmitting, the number of
bytes from the start of the packet to the beginning of the
transport-layer payload.

However, in practice, hdr_len was being set using skb_headlen(skb),
which is clearly incorrect. This path set fixes that issue.

As discussed in [0], this version checks the VIRTIO_NET_F_GUEST_HDRLEN is
negotiated.

[0]: http://lore.kernel.org/all/20251029030913.20423-1-xuanzhuo@linux.alibaba.com

Xuan Zhuo (2):
  virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
  virtio-net: correct hdr_len handling for tunnel gso

 arch/um/drivers/vector_transports.c |  1 +
 drivers/net/tun_vnet.h              |  4 +--
 drivers/net/virtio_net.c            |  9 +++++--
 include/linux/virtio_net.h          | 40 +++++++++++++++++++++++------
 net/packet/af_packet.c              |  5 ++--
 5 files changed, 45 insertions(+), 14 deletions(-)

--
2.32.0.3.g01195cf9f


