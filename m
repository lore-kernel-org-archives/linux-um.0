Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC2A606A68B
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1yt037aP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PvKsNKTH+N/wo+qc+k6pH61Gkxzo7WgdYLcaOadWIBU=; b=1yt037aPGtZWw/
	z1fdYZwVpP8qg3x1Y7lV2WkYaKNtAFqB3JZ9yO3u63p3l+SPVDVPaw2uvEkH9akEPC/frm1VVxu8K
	L5aM23u2RjzJvcAZ6rY8TZp+dOAZf1bkI1iElF+4k4mEPewdqy7TJujQiKgXnBM6FpOrKC33YC4Hq
	y5kqlgxtExwW9+qSSxWm/KKTr6vqB8hP7V0tZ8Fpu+ZFH27nsUjgR9F/xLHJ5UP2TKM7K9OPVDRSf
	KSz7ooQv/FjS7Ky+veeMHbLv9+ngT/WPkZrPE5hXMhpbKt1Pt6gNtlBOZpLlE4+QXofxcqSsS5xFU
	flfuVXYZSXA9xr/wXO2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFWY-0000000AUnz-1yRE;
	Wed, 25 Nov 2026 16:07:10 +0000
Received: from bambi.snowrabbit.org ([182.48.54.220])
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFWV-0000000AUhn-05sA
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 16:07:09 +0000
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id A394BC936F; Thu, 26 Nov 2026 01:07:05 +0900 (JST)
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
Subject: [PATCH RFC net v8 5/6] net: virtio: compute the outer checksum of non-GSO tunnel packets
Date: Thu, 26 Nov 2026 01:06:46 +0900
Message-ID: <20261126.rfcv8.99797.5.zakinko@snowrabbit.org>
In-Reply-To: <20261126.rfcv8.99797.0.zakinko@snowrabbit.org>
References: <20261126.rfcv8.99797.0.zakinko@snowrabbit.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_080707_299667_831C0AD0 
X-CRM114-Status: GOOD (  24.08  )
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

A packet may be tagged as UDP tunnel GSO and still be too small to
segment. Then nothing consumes the pseudo-header seed the sender left in
the outer UDP checksum. The GSO layer is not run, and transmit checksum
offload completes only the inner checksum, so the seed goes out as the
outer checksum.

Zeroing it is not an option either: IPv6 receivers drop a zero UDP
checksum unless the tunnel opted in (RFC 6935, RFC 6936).

Compute the outer checksum when VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM asks
for one: with local checksum offload while the inner checksum is still
partial, or by a full sum once the inner one was completed in software
because its metadata did not match the packet. Such packets no longer
need to be dropped.

The addresses come from the outer header in the frame and the length
from the UDP header. udp_set_csum() is not used: it is built with
CONFIG_INET, which virtio_net does not depend on.

Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Suggested-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
 include/linux/virtio_net.h | 105 ++++++++++++++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 7 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index e9057767b..5d5049418 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -8,8 +8,10 @@
 #include <linux/netdevice.h>
 #include <linux/udp.h>
 #include <net/ip.h>
+#include <net/ip6_checksum.h>
 #include <net/ipv6.h>
 #include <net/tcp.h>
+#include <net/udp.h>
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
 
@@ -545,6 +547,64 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool has_eth, bool outer_isv6,
 	return ip_proto == IPPROTO_UDP && outer_th == thoff;
 }
 
+/* Fill in the outer UDP checksum of a tunnel packet that is not GSO.
+ * While the inner checksum is still CHECKSUM_PARTIAL this is local
+ * checksum offload, as udp_set_csum() does for udp_tunnel_xmit_skb(),
+ * and needs the transport header at @outer_th.  Once the inner
+ * checksum has been completed the datagram is summed in full.
+ *
+ * The pseudo-header comes from the frame, not from the seed the sender
+ * put in uh->check: the addresses of the outer IP header and the
+ * length of the UDP header, which skb->len exceeds when the frame is
+ * padded.
+ *
+ * udp_set_csum() itself is not used: it is built with CONFIG_INET,
+ * which virtio_net does not depend on.
+ */
+static inline int
+virtio_net_tnl_set_outer_csum(struct sk_buff *skb, bool has_eth,
+			      bool outer_isv6, unsigned int outer_th)
+{
+	unsigned int thoff;
+	struct udphdr *uh;
+	int ip_proto, nhoff;
+	__be16 proto;
+	__wsum csum;
+	int len, err;
+
+	/* virtio_net_tnl_offsets_ok() has passed; this finds nhoff. */
+	if (!virtio_net_l3_start(skb, has_eth, &nhoff, &proto) ||
+	    !virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
+		return -EINVAL;
+
+	err = skb_ensure_writable(skb, outer_th + sizeof(*uh));
+	if (err)
+		return err;
+
+	uh = (struct udphdr *)(skb->data + outer_th);
+	len = ntohs(uh->len);
+	uh->check = 0;
+	if (skb->ip_summed == CHECKSUM_PARTIAL)
+		csum = lco_csum(skb);
+	else
+		csum = skb_checksum(skb, outer_th, skb->len - outer_th, 0);
+
+	if (outer_isv6) {
+		const struct ipv6hdr *ip6h = (void *)(skb->data + nhoff);
+
+		uh->check = udp_v6_check(len, &ip6h->saddr, &ip6h->daddr,
+					 csum);
+	} else {
+		const struct iphdr *iph = (void *)(skb->data + nhoff);
+
+		uh->check = udp_v4_check(len, iph->saddr, iph->daddr, csum);
+	}
+	if (uh->check == 0)
+		uh->check = CSUM_MANGLED_0;
+
+	return 0;
+}
+
 /*
  * Return value:
  * 0 - success
@@ -560,6 +620,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			  bool little_endian)
 {
 	const struct virtio_net_hdr *hdr = (const struct virtio_net_hdr *)vhdr;
+	typeof(skb->transport_header) old_transport = skb->transport_header;
 	unsigned int inner_nh, outer_th, inner_th;
 	unsigned int inner_l3min, outer_l3min;
 	u8 gso_inner_type, gso_tunnel_type;
@@ -631,15 +692,26 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 
 	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
 
-	/* NEEDS_CSUM is set, so this is CHECKSUM_PARTIAL.  A packet whose
-	 * inner metadata does not match cannot be segmented, and completing
-	 * the inner checksum alone would leave the outer one to the seed
-	 * the sender put there.
-	 */
+	/* NEEDS_CSUM is set, so this is CHECKSUM_PARTIAL. */
 	if (unlikely(!virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type,
 							   inner_nh,
-							   inner_proto)))
-		return -EINVAL;
+							   inner_proto))) {
+		/* __virtio_net_hdr_to_skb set the transport header to
+		 * csum_start, restore it to a known good value.
+		 */
+		skb->transport_header = old_transport;
+
+		ret = __virtio_net_resolve_csum_partial_mismatch(skb);
+		if (ret > 0 && hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
+			int err = virtio_net_tnl_set_outer_csum(skb, has_eth,
+								outer_isv6,
+								outer_th);
+
+			if (err)
+				return err;
+		}
+		return ret;
+	}
 
 	skb_set_inner_protocol(skb, inner_proto);
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
@@ -653,6 +725,25 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	skb->inner_mac_header = inner_nh + skb_headroom(skb);
 	skb->transport_header = outer_th + skb_headroom(skb);
 	skb->encapsulation = 1;
+
+	if (!skb_is_gso(skb)) {
+		/* Too small to segment.  Senders do tag small packets with
+		 * GSO headers, e.g. packetdrill sets gso_type and gso_size
+		 * with --mss, whatever the packet size.  Nothing consumes
+		 * the seed the sender left in the outer uh->check without
+		 * GSO, so compute the outer checksum if one was asked for.
+		 */
+		skb_shinfo(skb)->gso_type &= ~(SKB_GSO_UDP_TUNNEL_CSUM |
+					       SKB_GSO_UDP_TUNNEL);
+		if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
+			ret = virtio_net_tnl_set_outer_csum(skb, has_eth,
+							    outer_isv6,
+							    outer_th);
+			if (ret)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.54.0 (Apple Git-157)


