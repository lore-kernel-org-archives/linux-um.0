Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85592606A686
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dUKZQ/Th
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=tbHtq4u5qNw0coKzM67hn3NfizR9DRcO7y7V+ZSUs48=; b=dUKZQ/ThjiAohS9ufvgzc1qctT
	sxmwqxZGcMF19mUBmgw412ETTgLlP6JZPYSK2zb/6gRyAKrhUNwdrEh/GBZy7vKY+hRRyK7d7gfg+
	g6jYTZ4XGyO0KfUUuPopJTFWfLSc79oNRwD03mirfrD8mcOzfxqsWVsETk2Gi70R7B7y+qAb6e/pc
	W9BHlkXRfE+HTrCjBHrqABmPs0WsepXDjvfneT5qQumLl8bGikSseK34o0rVNRqBzjKYZXyiTcWfU
	q7MVqU1yNi5cr1Ed97cgW3DFBlBby/NBafs8wdtlJTKSG6LyMhdgIyUbA93pSPcHkUIrMsbua9dsn
	ZelAmyPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFWS-0000000AUi5-18fi;
	Wed, 25 Nov 2026 16:07:04 +0000
Received: from bambi.snowrabbit.org ([182.48.54.220])
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFWN-0000000AUgE-1ooA
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 16:07:02 +0000
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id 2B33CC9300; Thu, 26 Nov 2026 01:06:55 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	=?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Chris Arges <carges@cloudflare.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>,
	=?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	virtualization@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-doc@vger.kernel.org,
	Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH RFC net v8 0/6] more virtio-net csum hardening
Date: Thu, 26 Nov 2026 01:06:41 +0900
Message-ID: <20261126.rfcv8.99797.0.zakinko@snowrabbit.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_080659_698593_09FC1A21 
X-CRM114-Status: GOOD (  15.50  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Michael wrote in v7 that he would be on other things for a while and
posted it in case anyone wants to take it up, so here it is, rebased and
with the review comments addressed. Michael, if you already have a newer
version, I am happy to drop this one in favor of it. Patches 1-4 and 6
are yours; what I changed is noted above my sign-off.

Changes since v7:
- Rebased. Commit 73e08d50eb13 ("net: virtio: validate outer protocol of
  UDP tunnel GSO packets") has the header parsing helpers and the outer
  header checks, so those are gone from patch 4.
- Patch 4: has_eth is passed to virtio_net_hdr_to_skb() as well, instead
  of looking at the device type. I dropped Chris' Tested-by, as this is
  no longer what he tested.
- Patch 4: the tnl_csum_negotiated check is ahead of the validation
  again, as Willem pointed out.
- Patch 5 is new: the outer checksum of tunnel packets that are too small
  to segment. Willem asked for it as a separate patch.
- Patch 6: the sysctl does not turn off the outer header checks, which
  are in the tree unconditionally now. I turned the Reviewed-by tags into
  Cc, as that changes what was reviewed.

The two issues Michael listed as open in v7 are still open, hence the
RFC: the inner packet of a tunnel can have a valid header at
inner_nh_offset that overlaps the real transport header, and completing
the checksum at input breaks nf/BPF programs that edit the payload and
rely on CHECKSUM_PARTIAL.

I compared no patches, 1-4 and 1-6 on arm64 (qemu, TCG) with frames
written to a tap:

- Non-GSO UDP tunnel packets that ask for the outer checksum, over IPv4
  and IPv6, go out with a wrong one without the series and with 1-4, and
  with a correct one with 1-6.
- When the inner packet is a fragment, 1-4 reject them with EINVAL, and
  1-6 send them with a correct checksum.
- GSO behind an IPv6 AH is accepted without the series, and rejected
  with 1-4 and with 1-6.
- A plain UDP packet with csum_offset at the destination port is
  completed at input and counted in rx_csum_sw. One with good metadata is
  not counted.

The objects touched build on x86_64 with W=1 after each patch. At the end
of the series I also built the um objects, and linked an arm64 kernel
with CONFIG_INET=n and VIRTIO_NET=y.

Based on net e6474ead54b8, where the tests were run as well.

Michael S. Tsirkin (5):
  net: account for ingress-resolved virtio net hdr state
  um: vector: trim skbs before verifying the header
  virtio_net: parse tunnel csum_start little-endian
  net: resolve uncommon partial checksums at ingress
  net: add a sysctl to opt out of virtio net hdr checksum validation

Showta Ishizaki (1):
  net: virtio: compute the outer checksum of non-GSO tunnel packets

 Documentation/admin-guide/sysctl/net.rst |  19 ++
 arch/um/drivers/vector_kern.c            |   6 +-
 arch/um/drivers/vector_transports.c      |   4 +-
 drivers/net/tap.c                        |   4 +-
 drivers/net/tun.c                        |  44 +++-
 drivers/net/tun_vnet.h                   |   4 +-
 drivers/net/virtio_net.c                 |   2 +-
 include/linux/virtio_net.h               | 247 ++++++++++++++++++++++-
 include/net/netns/core.h                 |   1 +
 net/core/dev.c                           |   7 +
 net/core/net_namespace.c                 |   1 +
 net/core/sysctl_net_core.c               |  50 +++++
 net/packet/af_packet.c                   |  16 +-
 13 files changed, 381 insertions(+), 24 deletions(-)


base-commit: e6474ead54b8acecb8b0462dde2d77f46d2b7dc1
-- 
2.54.0

