Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED38606A324
	for <linux-um@archiver.kernel.org>; Thu, 22 Oct 2026 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=izUvQwim;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QDC6uWPJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JkOX/PkEAI8mnSOFgbqqjMUWsWOosAz2unpOFyKd8vI=; b=izUvQwimPZhGW9LLZAVj8/+ZTn
	z+WvaG7AVG55M+J+EG+p9LmPrrvtuSYYFI1ZpLYRhUkIp8JO8upKa1lCCMFvmPv/AH8E/LH0PXACS
	P1Pqe2hZzR7kxbpxZHKKdoclHxPOYL4ZyI2HTq8/LkXYGn4QBKGlSqd2SY0l2OCdFIbR0maBxb1NG
	monyHgy+Lj2bN7OEvh7iOhhHbqSjoNc9xMCrbgmjx0II5U5S6HfReeAjc0yi9CMzqS81gVx8kGPRT
	IXJ5ozgnNmbDnldh5FmD0UH7q3wPnRJ0VWJreXrEpDNWSX39urg/5jFdZv2PqLr9E2zU/moItPMHg
	3xLFyF7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsN1-0000000E7sX-0XAZ;
	Thu, 22 Oct 2026 12:58:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsMy-0000000E7rf-2ba4
	for linux-um@lists.infradead.org;
	Thu, 22 Oct 2026 12:58:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792673885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JkOX/PkEAI8mnSOFgbqqjMUWsWOosAz2unpOFyKd8vI=;
	b=QDC6uWPJ4KYCjRg+SE6sTaS6a8J3ZQzGH7UFPzW7J6UoIMdRl6FOrxHbM5Hb0D+VEr4XrM
	dDWOJCNdQjhzCWX7GT6uATCskOT5dTu7JLUd51i0ISiMDw97qi4rQTF7gJcII3KSGbyzwg
	ai8KFfpldFWXvWTBCkhd84mdjJuw4mk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-YyoignGvNtaqmclaAIYDQA-1; Thu, 22 Oct 2026 08:58:04 -0400
X-MC-Unique: YyoignGvNtaqmclaAIYDQA-1
X-Mimecast-MFC-AGG-ID: YyoignGvNtaqmclaAIYDQA_1792673883
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1895ffc83so12517295e9.3
        for <linux-um@lists.infradead.org>; Thu, 22 Oct 2026 05:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673883; x=1793278683;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JkOX/PkEAI8mnSOFgbqqjMUWsWOosAz2unpOFyKd8vI=;
        b=LPeZtEg6peXGlABJA8nEAJ3E4jqrV+JVVPqDUcL4ewd4FkVFxq2oyaIiZWiNCK4ePJ
         qSgLMFm7BIzy4ZEd+zAzFwr9iohbfn8ba1W2lFL8cENcBChiHXS3YgqPbzIlZkuP8kdz
         zdIycf3V0ZngYktzJ1GdvpnMgiRi+cQ7HPx23bF16x4c5NrGVDHQGtXU+eFC+U5mf4rZ
         dLBFnLvJTyadKrbw7WZ5k/SzE510XsC77rye9r/WZ7WObjs+wMpAS1oE+boddNzXLreg
         vXmHUH0MVjhYR4BbkPLmQApgTbqhffe1Rdc9fs/+3DA5HXMu/pKX8nj2TsQ0cmXWrja/
         Mglw==
X-Forwarded-Encrypted: i=1; AKwUvBwBRjhTSLHsaajIQSovknjjb+a8xqoER+qmvjqIE7XxemojG2auWSRXi8aB2ecKR4rAnqtW+GVDdA==@lists.infradead.org
X-Gm-Message-State: AFq9FYIK25pNrRvR4qW5d5TgTMaseMpAGq17J53ex7IbdDysPITxbptr
	I2pFuiV7Y51sFU1k6j5ZWl4hgUS9XD3ppiBmWrQaXTf2jHEeE3s7MulfipbcERxZtfJ9oSf69C9
	Okj18J36anLrPxWEJ9jWw03XeNyuRL2phWob3HqzcobjPptXEWiLOlYzCQsABBbmWDA==
X-Gm-Gg: AYBFou1sfMOsJlN+1tE/50rejRQh1wUPDy+TrBDZ0FmKZLoe6h6joqHELRyiYyHGLak
	bhTQf4sfkSKrn8zohiGEI8H1bLYYIHSq0rCHCAIYLd+hFPqNIya7Xn/jv5mGZqEiMXc6aviFz7V
	CmB+kmURzqAdrW/QgucAyfDkxlFdUfWkapUXZTmAqyMZ9ImXSJdrJsw4f8zhP01NKSZCbsGVtAv
	5/4JroJCwk6SYKrlQgw+CH96V4QZWU9/1zXZ22olMUi04F8Z1Pv3AfXm5kKYlEECFq3ItIRDPla
	MyfgZMFoC8Ad+OUrlSLgbVNiEEmOzcAyHZDRoUA44QpBUQV+zF8w3Z2xMNCJXB4hLwU=
X-Received: by 2002:a05:600c:b90:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a1fdb20d7dmr101027465e9.26.1792673882387;
        Thu, 22 Oct 2026 05:58:02 -0700 (PDT)
X-Received: by 2002:a05:600c:b90:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a1fdb20d7dmr101026945e9.26.1792673881845;
        Thu, 22 Oct 2026 05:58:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203a265afsm80608645e9.7.2026.10.22.05.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:58:00 -0700 (PDT)
Date: Thu, 22 Oct 2026 08:57:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Simon Horman <horms@kernel.org>, linux-um@lists.infradead.org
Subject: [PATCH net v5 1/7] net: account for ingress-resolved virtio net hdr
 state
Message-ID: <94796ee3c32e50665ecf70e2b390db1bc2773be9.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.v5.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6CPqFe3zwWKE93ukaTSdDsl-npslOB_xEAfVm6GrOUQ_1792673883
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_055808_733406_1811F396 
X-CRM114-Status: GOOD (  19.00  )
X-Spam-Score: -2.8 (--)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following patch will add ingress resolution of uncommon virtio net
hdr checksum metadata (software checksum completion at ingress) which
adds performance overhead to the packet processing.

We should make it visible, so a hypothetical workload relying on
uncommon metadata can be distinguished from none at all. This way issues
in the parsing will be reported and not quietly pay the host-CPU
checksum overhead instead of offload.

Flip every call to virtio_net_hdr_to_skb to test for negative errno
only.  The um vector raw transport even ignored the return value
altogether: rejected packets went on into the stack with their
metadata unvalidated, so check it there as well.

Have tun count these events per device as rx_csum_sw, exposed via
ethtool -S.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes (changelog):
    v4->v5:
        count on tun only: dropped the tap, macvtap, ipvtap and
        virtio_net counters (Willem de Bruijn)

 arch/um/drivers/vector_transports.c |  4 ++-
 drivers/net/tap.c                   |  4 +--
 drivers/net/tun.c                   | 41 +++++++++++++++++++++++++++--
 drivers/net/virtio_net.c            |  2 +-
 net/packet/af_packet.c              |  4 +--
 5 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
index e1fb2a76fdff..8b7548458663 100644
--- a/arch/um/drivers/vector_transports.c
+++ b/arch/um/drivers/vector_transports.c
@@ -210,7 +210,9 @@ static int raw_verify_header(
 		return 1;
 
 	skb_set_network_header(skb, ETH_HLEN);
-	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
+	if (virtio_net_hdr_to_skb(skb, vheader,
+			virtio_legacy_is_little_endian()) < 0)
+		return -1;
 	return 0;
 }
 
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index ff67d99deb39..73e883394446 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -649,7 +649,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	if (vnet_hdr_len) {
 		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
-		if (err) {
+		if (err < 0) {
 			rcu_read_unlock();
 			drop_reason = SKB_DROP_REASON_DEV_HDR;
 			goto err_kfree;
@@ -1084,7 +1084,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	if (vnet_hdr_len) {
 		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
-		if (err) {
+		if (err < 0) {
 			rcu_read_unlock();
 			goto err_kfree;
 		}
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 242899f7fd07..197fb8726f8d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -210,6 +210,7 @@ struct tun_struct {
 	u32 flow_count;
 	u32 rx_batched;
 	atomic_long_t rx_frame_errors;
+	atomic64_t rx_csum_sw;
 	struct bpf_prog __rcu *xdp_prog;
 	struct tun_prog __rcu *steering_prog;
 	struct tun_prog __rcu *filter_prog;
@@ -1935,10 +1936,14 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		break;
 	}
 
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
+	err = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
+	if (err < 0) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
+	} else if (err > 0) {
+		atomic64_inc(&tun->rx_csum_sw);
+		err = 0;
 	}
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
@@ -2605,11 +2610,15 @@ static int tun_xdp_one(struct tun_struct *tun,
 	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
 	skb->dev = tun->dev;
 	skb_set_network_header(skb, ETH_HLEN);
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
+	ret = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr);
+	if (ret < 0) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
 		ret = -EINVAL;
 		goto out;
+	} else if (ret > 0) {
+		atomic64_inc(&tun->rx_csum_sw);
+		ret = 0;
 	}
 
 	skb->protocol = eth_type_trans(skb, tun->dev);
@@ -3739,7 +3748,35 @@ static void tun_get_channels(struct net_device *dev,
 	channels->max_combined = tun->flags & IFF_MULTI_QUEUE ? MAX_TAP_QUEUES : 1;
 }
 
+#define TUN_STATS_LEN	1
+static const char tun_ethtool_strings[TUN_STATS_LEN][ETH_GSTRING_LEN] = {
+	"rx_csum_sw",
+};
+
+static int tun_get_sset_count(struct net_device *dev, int sset)
+{
+	return sset == ETH_SS_STATS ? TUN_STATS_LEN : -EOPNOTSUPP;
+}
+
+static void tun_get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	if (stringset == ETH_SS_STATS)
+		memcpy(data, tun_ethtool_strings,
+		       sizeof(tun_ethtool_strings));
+}
+
+static void tun_get_ethtool_stats(struct net_device *dev,
+				  struct ethtool_stats *stats, u64 *data)
+{
+	struct tun_struct *tun = netdev_priv(dev);
+
+	data[0] = atomic64_read(&tun->rx_csum_sw);
+}
+
 static const struct ethtool_ops tun_ethtool_ops = {
+	.get_sset_count		= tun_get_sset_count,
+	.get_strings		= tun_get_strings,
+	.get_ethtool_stats	= tun_get_ethtool_stats,
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_MAX_FRAMES,
 	.get_drvinfo	= tun_get_drvinfo,
 	.get_msglevel	= tun_get_msglevel,
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index daab43ac92ce..2e6fd81df9c4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2519,7 +2519,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 	skb_set_network_header(skb, ETH_HLEN);
 	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
 				      vi->rx_tnl_csum,
-				      virtio_is_little_endian(vi->vdev))) {
+				      virtio_is_little_endian(vi->vdev)) < 0) {
 		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
 				     dev->name, hdr->hdr.gso_type,
 				     hdr->hdr.gso_size, hdr->hdr.flags,
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 52ae3d875e97..e6aec9ecfa99 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2913,7 +2913,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		}
 
 		if (has_vnet_hdr) {
-			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
+			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
@@ -3136,7 +3136,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 
 	if (vnet_hdr_sz) {
 		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
-		if (err)
+		if (err < 0)
 			goto out_free;
 		len += vnet_hdr_sz;
 	}
-- 
MST


