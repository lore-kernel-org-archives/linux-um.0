Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDF2606A33F
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ox6B9CUj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7YB7UL0sucy3/7oJUhtDU4Mp/84PzZO7y1sht4zAS4U=; b=Ox6B9CUjHREOPL
	hEkP5j9GyTPMNq8I4y5RaBgFzEV2F48hQf1SyWLnvS269RoRT7vFYlGn4i0FShp6iNnqW5lrQ5YFE
	Sqsh/IOfvKABcgt1FkWqbH35eWTkS/H/TW7mEg/2F5JwjfHVGhI7tsdE3AFQDseVJ65LRZEZgWG0C
	ZaJc67VMqAHRsrTnaRgb2AYc5PZaFCrs++MkCQjDULH+e5bY7WnrSugjhmR4MrCc5ZrUZJ+C8XCZF
	qVToVQblQcX9ETaA8llO/S0kGgIqtt1zxoANlGd0/PgugpKcfEY0WoFQxMIFsdlicuHGV4nE8mva6
	vfLZBPGoWqkSbkXAm1aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFWW-0000000AUl3-0HTK;
	Wed, 25 Nov 2026 16:07:08 +0000
Received: from bambi.snowrabbit.org ([182.48.54.220])
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFWS-0000000AUhn-13xm
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 16:07:06 +0000
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id 86332C936A; Thu, 26 Nov 2026 01:07:03 +0900 (JST)
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
Subject: [PATCH RFC net v8 4/6] net: resolve uncommon partial checksums at ingress
Date: Thu, 26 Nov 2026 01:06:45 +0900
Message-ID: <20261126.rfcv8.99797.4.zakinko@snowrabbit.org>
In-Reply-To: <20261126.rfcv8.99797.0.zakinko@snowrabbit.org>
References: <20261126.rfcv8.99797.0.zakinko@snowrabbit.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_080704_651033_E1107013 
X-CRM114-Status: GOOD (  30.23  )
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Michael S. Tsirkin" <mst@redhat.com>

As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
others, credited below, found more ways the bug can affect users) a
virtio net header can place CHECKSUM_PARTIAL at any in-packet offset.
If that state is retained, later checksum completion can modify the
packet after protocol processing has made decisions from it.

Let's fix that: let's validate csum_start and csum_offset and only keep
CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
headers.  Complete other non-GSO checksums immediately, before any
protocol processing runs.

We can't easily "complete the checksum" for GSO we don't recognize - GSO
assumes knowledge of the protocol. We could segment ignoring the
checksum then do whatever csum_start and csum_offset say, but that
seems like an overkill for something that shouldn't happen.

There's some risk here:
- non-gso packets which can't be parsed get checksum calculated in
  software, adding performance overhead
- gso packets which can't be parsed get dropped

Note that for zero copy, userspace can change the data after the
checksum has been calculated.  This is fundamental to zero copy by
design, and the only outcome is a bad checksum and a packet drop.

To mitigate the risks, a later patch will add a sysctl knob to
bypass the resolution. This is reasonable if the setup is such that
there is no protocol processing at all.

UDP tunnel headers get the same handling on the inner header.

Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.

Note a fundamental limitation of this approach: an nf/BPF program
that tweaks the payload of a packet in flight may rely on the
checksum being fixed up later, assuming the packet carries
CHECKSUM_PARTIAL.

For metadata that fails validation the checksum
is now completed at input, so such edits leave a stale checksum
and the packet is dropped at the receiver.  Protocols whose
transport header we cannot parse (anything but TCP and UDP) are
affected even when the metadata is self-consistent.

The sysctl added later in the series is the escape hatch for these setups,
but it is a very blunt tool.

Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Reported-by: Chris Arges <carges@cloudflare.com>
Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[showta: rebased, the parsing helpers are in the tree already; has_eth
 passed to virtio_net_hdr_to_skb() instead of using the device type;
 the tnl_csum_negotiated check kept ahead of the validation; a tunnel
 packet with bad inner metadata is dropped here, the next patch handles
 the ones too small to segment]
Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
 arch/um/drivers/vector_transports.c |   2 +-
 drivers/net/tun_vnet.h              |   4 +-
 include/linux/virtio_net.h          | 132 ++++++++++++++++++++++++++--
 net/packet/af_packet.c              |  14 ++-
 4 files changed, 140 insertions(+), 12 deletions(-)

diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
index 8b7548458..2dc4cf992 100644
--- a/arch/um/drivers/vector_transports.c
+++ b/arch/um/drivers/vector_transports.c
@@ -210,7 +210,7 @@ static int raw_verify_header(
 		return 1;
 
 	skb_set_network_header(skb, ETH_HLEN);
-	if (virtio_net_hdr_to_skb(skb, vheader,
+	if (virtio_net_hdr_to_skb(skb, vheader, true,
 			virtio_legacy_is_little_endian()) < 0)
 		return -1;
 	return 0;
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index 3364e08dd..5411258ee 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -180,7 +180,9 @@ static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
 static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
 				      const struct virtio_net_hdr *hdr)
 {
-	return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
+	/* Only tap.c, where a frame always starts with an Ethernet header. */
+	return virtio_net_hdr_to_skb(skb, hdr, true,
+				     tun_vnet_is_little_endian(flags));
 }
 
 /*
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 3135dae03..e9057767b 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -190,6 +190,77 @@ virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
 	return false;
 }
 
+/* Does checksum metadata match a known TCP or UDP header? */
+static inline bool
+virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
+				     unsigned int nhoff, __be16 proto)
+{
+	unsigned int thoff;
+	int ip_proto;
+
+	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
+		return false;
+
+	if (skb_checksum_start_offset(skb) != thoff)
+		return false;
+
+	switch (ip_proto) {
+	case IPPROTO_TCP:
+		if (skb->csum_offset != offsetof(struct tcphdr, check) ||
+		    !pskb_may_pull(skb, thoff + sizeof(struct tcphdr)))
+			return false;
+		break;
+	case IPPROTO_UDP:
+		if (skb->csum_offset != offsetof(struct udphdr, check) ||
+		    !pskb_may_pull(skb, thoff + sizeof(struct udphdr)))
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+	case VIRTIO_NET_HDR_GSO_NONE:
+		return true;
+	case VIRTIO_NET_HDR_GSO_TCPV4:
+		return proto == htons(ETH_P_IP) && ip_proto == IPPROTO_TCP;
+	case VIRTIO_NET_HDR_GSO_TCPV6:
+		return proto == htons(ETH_P_IPV6) && ip_proto == IPPROTO_TCP;
+	case VIRTIO_NET_HDR_GSO_UDP:
+	case VIRTIO_NET_HDR_GSO_UDP_L4:
+		return ip_proto == IPPROTO_UDP;
+	default:
+		return false;
+	}
+}
+
+static inline bool
+virtio_net_csum_partial_ok(struct sk_buff *skb, bool has_eth,
+			   u8 hdr_gso_type)
+{
+	int nhoff;
+	__be16 proto;
+
+	if (!virtio_net_l3_start(skb, has_eth, &nhoff, &proto))
+		return false;
+
+	return virtio_net_csum_partial_ok_at_offset(skb, hdr_gso_type, nhoff,
+						   proto);
+}
+
+/*
+ * Handle a packet whose checksum metadata does not match the packet:
+ * GSO packets are dropped, as segmentation needs one checksum per
+ * segment; others are completed in software.
+ */
+static inline int __virtio_net_resolve_csum_partial_mismatch(struct sk_buff *skb)
+{
+	if (skb_is_gso(skb))
+		return -EINVAL;
+
+	return skb_checksum_help(skb) ?: 1;
+}
+
 static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 					  const struct virtio_net_hdr *hdr,
 					  bool little_endian, u8 hdr_gso_type)
@@ -336,11 +407,38 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 	return 0;
 }
 
+/*
+ * @has_eth: the frame starts with an Ethernet header, see
+ * virtio_net_l3_start().
+ *
+ * Return value:
+ * 0 - success
+ * >0 - checksum was completed in software (slow path)
+ * <0 - failure
+ */
 static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 					const struct virtio_net_hdr *hdr,
-					bool little_endian)
+					bool has_eth, bool little_endian)
 {
-	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
+	typeof(skb->transport_header) old_transport = skb->transport_header;
+	int ret = __virtio_net_hdr_to_skb(skb, hdr, little_endian,
+					  hdr->gso_type);
+
+	if (ret < 0)
+		return ret;
+
+	if (likely(skb->ip_summed != CHECKSUM_PARTIAL ||
+		   virtio_net_csum_partial_ok(skb, has_eth, hdr->gso_type)))
+		return 0;
+
+	/*
+	 * Here we do not trust the checksum metadata.
+	 * __virtio_net_hdr_to_skb set the transport header to csum_start
+	 * from virtio hdr, restore it to a known good value.
+	 */
+	skb->transport_header = old_transport;
+
+	return __virtio_net_resolve_csum_partial_mismatch(skb);
 }
 
 /* This function must be called after virtio_net_hdr_from_skb(). */
@@ -447,6 +545,12 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool has_eth, bool outer_isv6,
 	return ip_proto == IPPROTO_UDP && outer_th == thoff;
 }
 
+/*
+ * Return value:
+ * 0 - success
+ * >0 - checksum was completed in software (slow path)
+ * <0 - failure
+ */
 static inline int
 virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
@@ -459,16 +563,20 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	unsigned int inner_nh, outer_th, inner_th;
 	unsigned int inner_l3min, outer_l3min;
 	u8 gso_inner_type, gso_tunnel_type;
+	__be16 inner_proto;
 	bool outer_isv6, inner_isv6;
 	int ret;
 
 	gso_tunnel_type = hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL;
 	if (!gso_tunnel_type)
-		return virtio_net_hdr_to_skb(skb, hdr, little_endian);
+		return virtio_net_hdr_to_skb(skb, hdr, has_eth, little_endian);
 
 	/* Tunnel not supported/negotiated, but the hdr asks for it. */
 	if (!tnl_hdr_negotiated)
 		return -EINVAL;
+	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM &&
+	    !tnl_csum_negotiated)
+		return -EINVAL;
 
 	/* Either ipv4 or ipv6. */
 	if (gso_tunnel_type == VIRTIO_NET_HDR_GSO_UDP_TUNNEL)
@@ -521,12 +629,20 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 	}
 
-	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-						 htons(ETH_P_IP));
-	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
-		if (!tnl_csum_negotiated)
-			return -EINVAL;
+	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
 
+	/* NEEDS_CSUM is set, so this is CHECKSUM_PARTIAL.  A packet whose
+	 * inner metadata does not match cannot be segmented, and completing
+	 * the inner checksum alone would leave the outer one to the seed
+	 * the sender put there.
+	 */
+	if (unlikely(!virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type,
+							   inner_nh,
+							   inner_proto)))
+		return -EINVAL;
+
+	skb_set_inner_protocol(skb, inner_proto);
+	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
 		skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
 	} else {
 		skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 930e85e4b..c07a01969 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2778,6 +2778,16 @@ static int tpacket_parse_header(struct packet_sock *po, void *frame,
 	return tp_len;
 }
 
+/* The device says how its frames start. */
+static int packet_vnet_hdr_to_skb(struct sk_buff *skb,
+				  const struct virtio_net_hdr *vnet_hdr)
+{
+	bool has_eth = skb->dev->type == ARPHRD_ETHER ||
+		       skb->dev->type == ARPHRD_LOOPBACK;
+
+	return virtio_net_hdr_to_skb(skb, vnet_hdr, has_eth, vio_le());
+}
+
 static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 {
 	struct sk_buff *skb = NULL;
@@ -2941,7 +2951,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		}
 
 		if (has_vnet_hdr) {
-			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
+			if (packet_vnet_hdr_to_skb(skb, &vnet_hdr) < 0) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
@@ -3163,7 +3173,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		skb->no_fcs = 1;
 
 	if (vnet_hdr_sz) {
-		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
+		err = packet_vnet_hdr_to_skb(skb, &vnet_hdr);
 		if (err < 0)
 			goto out_free;
 		len += vnet_hdr_sz;
-- 
2.54.0 (Apple Git-157)


