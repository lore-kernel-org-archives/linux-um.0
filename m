Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E51CC6B33
	for <linux-um@archiver.kernel.org>; Thu, 15 Oct 2026 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/qcGh/+2dqUoiHJpUXvQbolm141eVal40N7yCBeiObo=; b=Frn4oPjNslhzvjR8Da3hsN2/i8
	KOkJslgDhKxO8JShr5HUs1fvdmv6rQhFBr76ZusnmxpSCf6OPLt493vUEACqPr199GvcEB68W1IN6
	/6rFZHI/uCxoSaZHikoRnvioIlW/DV9AFOQQcqpeNaESDInB3AXKooKXJlJ4R0z3qMfIRmIBa9PuQ
	Jozf8eOLzumM5Mj57JWodUQIcgDrpxJM60zzppkEuyROhwnD2YS5WYb/duN5AgQu/0Bh9ht0bF9JV
	LwI3EqH/eHg3+uYAR3kpnWhxSFqW8MOecC8sKAwKMx/ZipHWwNcZHpvec6NEUhFLrEn8+t/tBOeIO
	xIVnrqIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHKmF-0000000092C-2mdF;
	Thu, 15 Oct 2026 12:41:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHKmB-0000000091U-2Ozj
	for linux-um@lists.infradead.org;
	Thu, 15 Oct 2026 12:41:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qcGh/+2dqUoiHJpUXvQbolm141eVal40N7yCBeiObo=;
	b=cdwinpGgKCUZUoUbV+nV4RUa1XXx8hjDVtGlKZx5qdtEwLuw1ZRV1oPEQbpy8s5z9NU7D3
	Z8sO0a1h+ic6hnv6L8MXfk1IcucnfU9WNxFDoLY9Ls7SCHt6gBOFAO70jajj//n0Pegv8c
	3PfsuwPR67CHx91hdLol0S4nZ8D9H/E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-Lh8LA_vKPbO6TPTf89Ucwg-1; Thu, 15 Oct 2026 12:41:36 +0000
X-MC-Unique: Lh8LA_vKPbO6TPTf89Ucwg-1
X-Mimecast-MFC-AGG-ID: Lh8LA_vKPbO6TPTf89Ucwg_1792068096
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48af5a07314so3337430f8f.2
        for <linux-um@lists.infradead.org>; Thu, 15 Oct 2026 05:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068095; x=1792672895;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/qcGh/+2dqUoiHJpUXvQbolm141eVal40N7yCBeiObo=;
        b=u5R5RlxS5QyiuXjVNPmWt2uI15zBAc8bnNmwTXeCqtHRq9D8SkcGxVPOJaIbLSjj2N
         iSCWJ8PljotG/LfGocET3G6FOGz6kjpa3mCdP6q5Zfuy2OFbXJggQPdSTanBAy8CkhHl
         5IEajWlX7c0OoWzrcH8EgOlttSXKAcHj/HW6ykCCXrQw/N9wsmg0os9NVJnLCIQkFzFm
         OEQDGn5+IO743pxbn373z/Q6T+ZOSsakhKpWweJAAi0s6kKMMzbP/ZxriWgELRIHEkiA
         PiOQeAWbPDgakPZnZzvjzYhbZkTvhMiKAcTy67W4tVD1Qj8F5BEgSTP6jcNcU+J0vy7W
         XA3g==
X-Forwarded-Encrypted: i=1; AKwUvBxWTIpLshE+F07Kgxteq7S5nD6pvlctjwBk/de90kX8Ocy01CDy2AJ/CMlwkSneNI/LdZcXq688Hg==@lists.infradead.org
X-Gm-Message-State: AFq9FYIGU5kmjVlXYpYhkRyEYQ8+A7wUlBKSbe93RPdSmPZTwxTNwJKs
	Ij3ow6Z2CM6Famf+ME5VF6VwnHjdzfiVBo9RqQRk2OePcLuekczblmrDtPCd0BfwHdgeXmihfST
	MnJuylZgxgBsvPboDtIY89JUM4rG9uDstTgToEg+0v8UNmefZZ7FCHEifAW5kl5fSHw==
X-Gm-Gg: AYBFou3d5P8gxNtsLH91uurweIrGHON5iflb/xBSRqzhG/8jgoT1m3IX7yN2wAloEk4
	VzJHPqYz50ByXa/SD2cHLmLK1bD9sefym2LImTJ15ddhOcLYZMGRB0o4mHG53/rc3DTA7WMof/J
	S9BVa83rdrTOZOvxA7Qh4gaHIf5hlhuKneq9yLCLqWUVrXatRe7SxVlyZ2AQH2sU5sGFAYtI+7q
	CvG6hU3kCtWGeGQ3aqHjZcV6V/O4VuxayrvdUsEfgZlUYOc29k/v15C4BKe7WvIg3XdZRg2OQX4
	PsPYwrs2as/BqGjaLAbUWIkDHptsl64UBL9jlyp+oMUar0+Ssr5gkOoKz/HPhHr9wA+F5w==
X-Received: by 2002:a05:6000:468a:b0:48d:c162:571a with SMTP id ffacd0b85a97d-48dc1625761mr21924073f8f.4.1792068095454;
        Thu, 15 Oct 2026 05:41:35 -0700 (PDT)
X-Received: by 2002:a05:6000:468a:b0:48d:c162:571a with SMTP id ffacd0b85a97d-48dc1625761mr21924037f8f.4.1792068094949;
        Thu, 15 Oct 2026 05:41:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48defca4013sm8758247f8f.9.2026.10.15.05.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:27 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:41:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
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
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH net-next v2 3/7] um: vector: trim skbs before verifying the
 header
Message-ID: <d9ac3420f95c5953227d80c71ebc3cd7e3c5fd9c.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1792067836.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M-m2TJy6glGQvoU7HNojENQ68-gGUB1iVnP1PHQsAB4_1792068096
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_054139_686314_9A1D287A 
X-CRM114-Status: GOOD (  13.67  )
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

The vector receive path over-allocates the skb and only trims it
to the received length after the transport header is verified.

A follow up patch will complete the packet checksum in software within
virtio_net_hdr_to_skb so we need the packet trimmed (otherwise the
checksum would be computed incorrectly over the unreceived tail of the
buffer).

Trim first, so the import sees the packet as it was received.

Assisted-by: LLM
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/um/drivers/vector_kern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 8a70b3a62553..1afbef78df72 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -865,6 +865,7 @@ static int vector_legacy_rx(struct vector_private *vp)
 
 	if (skb != NULL) {
 		if (pkt_len > vp->header_size) {
+			pskb_trim(skb, pkt_len - vp->rx_header_size);
 			if (vp->header_size > 0) {
 				header_check = vp->verify_header(
 					vp->header_rxbuffer, skb, vp);
@@ -879,7 +880,6 @@ static int vector_legacy_rx(struct vector_private *vp)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			pskb_trim(skb, pkt_len - vp->rx_header_size);
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			vp->dev->stats.rx_bytes += skb->len;
 			vp->dev->stats.rx_packets++;
@@ -981,6 +981,8 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 	for (i = 0; i < packet_count; i++) {
 		skb = (*skbuff_vector);
 		if (mmsg_vector->msg_len > vp->header_size) {
+			pskb_trim(skb,
+				mmsg_vector->msg_len - vp->rx_header_size);
 			if (vp->header_size > 0) {
 				header_check = vp->verify_header(
 					mmsg_vector->msg_hdr.msg_iov->iov_base,
@@ -1005,8 +1007,6 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			pskb_trim(skb,
-				mmsg_vector->msg_len - vp->rx_header_size);
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			/*
 			 * We do not need to lock on updating stats here
-- 
MST


