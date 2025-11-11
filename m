Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB14CCFA1A
	for <linux-um@archiver.kernel.org>; Tue, 11 Nov 2025 11:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZIudUGKGeWaGvoL3nliZIihGbTlmfrlvqzddtIqLUFc=; b=QyZ1XTdKpqwSqCJUDoeTZOmT4y
	NRXa6S4Gi2j+m/07hVlTdSVNfP+4m7n/qSbVhX0yY+PDvy6dEpp2fbCS6aMyw08JoIX/pluVwR4B6
	6lM10L0zxS9DtXP0ZX8SDH8MP6+0t7pLbjkD0I7qbe36dyH2enkvIQamEMyPW9QbiuSFM9+BoPi8S
	i/qCx7V4PMCg1GMpBYIAFXKHdbzJEKrN8UbqZvwOlvvecgCjlbzejXPVOO3x6PSN3VZWM3AciUdf9
	cGEWmz7RnpLyLR9uv784pnlWPcw67/v16UfCX1J1Z23dz7JoiqypUp1/tPd2IVZkZJnISSwju0lUc
	ZOkUxGTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vImIS-000000073A7-0Jf1;
	Tue, 11 Nov 2025 11:12:24 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vImIO-0000000738m-1Vcp
	for linux-um@lists.infradead.org;
	Tue, 11 Nov 2025 11:12:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762859536; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZIudUGKGeWaGvoL3nliZIihGbTlmfrlvqzddtIqLUFc=;
	b=Ri6iFxC5Du/RGw1Marb8eY9Y1myz+sRQHTSY0y7a8DMl2/c+EwDg+XsB3BqaAJn8h6s021UB1peV6CiFhlTNAiotO8vFbcrXyUt1K+GLk+uN2io8FjuGeC4wr7zF1F2/qbyRYVcUeIG/dkGu+UUDKLnVCCcztocpGrXT72wlocQ=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WsBStOH_1762859534 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Nov 2025 19:12:14 +0800
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
Subject: [PATCH net v5 2/2] virtio-net: correct hdr_len handling for tunnel gso
Date: Tue, 11 Nov 2025 19:12:12 +0800
Message-Id: <20251111111212.102083-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251111111212.102083-1-xuanzhuo@linux.alibaba.com>
References: <20251111111212.102083-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: feb36a32054d
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_031220_887452_ACFBE4DD 
X-CRM114-Status: GOOD (  13.32  )
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

The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
GSO tunneling.") introduces support for the UDP GSO tunnel feature in
virtio-net.

The virtio spec says:

    If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
    VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
    all the headers up to and including the inner transport.

The commit did not update the hdr_len to include the inner transport.

I observed that the "hdr_len" is 116 for this packet:

    17:36:18.241105 52:55:00:d1:27:0a > 2e:2c:df:46:a9:e1, ethertype IPv4 (0x0800), length 2912: (tos 0x0, ttl 64, id 45197, offset 0, flags [none], proto UDP (17), length 2898)
        192.168.122.100.50613 > 192.168.122.1.4789: [bad udp cksum 0x8106 -> 0x26a0!] VXLAN, flags [I] (0x08), vni 1
    fa:c3:ba:82:05:ee > ce:85:0c:31:77:e5, ethertype IPv4 (0x0800), length 2862: (tos 0x0, ttl 64, id 14678, offset 0, flags [DF], proto TCP (6), length 2848)
        192.168.3.1.49880 > 192.168.3.2.9898: Flags [P.], cksum 0x9266 (incorrect -> 0xaa20), seq 515667:518463, ack 1, win 64, options [nop,nop,TS val 2990048824 ecr 2798801412], length 2796

116 = 14(mac) + 20(ip) + 8(udp) + 8(vxlan) + 14(inner mac) + 20(inner ip) + 32(innner tcp)

Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_net.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 3cd8b2ebc197..432b17979d17 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -232,12 +232,23 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 			return -EINVAL;
 
 		if (hdrlen_negotiated) {
-			hdr_len = skb_transport_offset(skb);
+			if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
+					       SKB_GSO_UDP_TUNNEL_CSUM)) {
+				hdr_len = skb_inner_transport_offset(skb);
+
+				if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
+					hdr_len += sizeof(struct udphdr);
+				else
+					hdr_len += inner_tcp_hdrlen(skb);
+			} else {
+				hdr_len = skb_transport_offset(skb);
+
+				if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
+					hdr_len += sizeof(struct udphdr);
+				else
+					hdr_len += tcp_hdrlen(skb);
+			}
 
-			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
-				hdr_len += sizeof(struct udphdr);
-			else
-				hdr_len += tcp_hdrlen(skb);
 		} else {
 			/* This is a hint as to how much should be linear. */
 			hdr_len = skb_headlen(skb);
@@ -421,11 +432,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
         vhdr->hash_hdr.hash_report = 0;
         vhdr->hash_hdr.padding = 0;
 
-	/* Let the basic parsing deal with plain GSO features. */
-	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
 	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, hdrlen_negotiated,
 				      vlan_hlen);
-	skb_shinfo(skb)->gso_type |= tnl_gso_type;
 	if (ret)
 		return ret;
 
-- 
2.32.0.3.g01195cf9f


