Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7841CCF2E3
	for <linux-um@archiver.kernel.org>; Mon, 19 Oct 2026 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/qcGh/+2dqUoiHJpUXvQbolm141eVal40N7yCBeiObo=; b=l+e4iQi27qIqE7Gqob0Sxr1TmY
	X7Crfo5TtvH9bSSqOf7oddTG82/1yFObj8qBRDpivutX8LrkIoNPq6kUqsrGxu0ewLliwACpNaJ/N
	QrGJkaniguhlqUDmPP8Si+4vh4FLYW++INHH7Z87tbmQVIs4YhkwOoCV2qXRos1PXiCOKhX5sASoY
	1hPfWRkTaLSW8kJkpPOYyAJTognz3tHY/1nK0EKWkEPsf15TVoB81YbP8R0m4H9GXmBeT8WYQ160/
	1Kuh1NbMvxNlwaqgOdmQ+hOwzQAKRvOWLHsovgAIdIa0O8oXGeg7qqbC/UIXGn5GXDF2t4KjPli6G
	jITuYOsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIm5N-00000007LDg-2IHh;
	Mon, 19 Oct 2026 12:03:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIm5K-00000007LCF-1Y3Q
	for linux-um@lists.infradead.org;
	Mon, 19 Oct 2026 12:03:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792411399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qcGh/+2dqUoiHJpUXvQbolm141eVal40N7yCBeiObo=;
	b=MNWbh3mWZ71nnYwSXBOkpII/pgIFoWvPpOclCpiOcfUUKrUldHSXqN9OBZ/A53I72VH3dJ
	alKJZNu+iJHE0p1WXP0XDvy91odbXzJYlE9ofGYBaofG4AcNPIma7MJbbYnmkxHIiBnG7l
	jZQY3TgQngTlT85pKg2G60Gu7DjHduI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-fw2ovlgPP-m0BsAZEaWZig-1; Mon, 19 Oct 2026 12:03:17 +0000
X-MC-Unique: fw2ovlgPP-m0BsAZEaWZig-1
X-Mimecast-MFC-AGG-ID: fw2ovlgPP-m0BsAZEaWZig_1792411396
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48df02b91f9so1895831f8f.1
        for <linux-um@lists.infradead.org>; Mon, 19 Oct 2026 05:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411396; x=1793016196;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/qcGh/+2dqUoiHJpUXvQbolm141eVal40N7yCBeiObo=;
        b=x9W4JFduGYZZGu9oPSebDwQ40NG2+qlI8blpL55FADlG4p7yniNXHBCuT7DgmggKeh
         hsovyDI4jFQI3VR/r6rBV/IQ20/tFDD1w1z00LodRrx2HVLQXdSiWxNW/QMboV8MafqE
         hofGRHylYQoYdsB1PfWB3bcHocwzb5btE27kj+HgavNwdiAnvPAa89kSLk14FJlrwIVJ
         c3iyvllNL+jFq5t9NXETKc3d4v7J7G7raisJ20jcoJojc2yJiFD/IXvCI1bcJ9l2HVxJ
         wCV7y6B+w33ofLuDzMHZvvuMZx6Jqxqjb6pBBIyM4lLqIkFlmDLmO6JcXYMijgs6h3Om
         Ikiw==
X-Forwarded-Encrypted: i=1; AKwUvByyMfbELsHFSFoUvaM/a3NcGfAXDUD4i5leWZhXDMFtQdMRfKpTMoxDY7rV+HJZjlKd5ZbEnGwL4g==@lists.infradead.org
X-Gm-Message-State: AFq9FYKAVBSWFh960llgdGK+2xv9lC23Cge0PCc5SDvzB/eqx7xp/gud
	0Dy+XlyUESDNsNnE+bTqvQdX6cfm/U5xi4BmYVEvIRnSvOul4yS8iI3LoqNOiWfHjgj0+VsuewY
	Zw93MQRvXTDn7Mwf6ngP7WeMjqXjmE9dWprdGtyaWj5CbMN9YGEQ2CIDT6j1/2GQbwQ==
X-Gm-Gg: AYBFou3h06doTAMmNIKz8hMBqWKRHkmjxtHrXtBwCurrCYFp8H+TyJfG/gj3HU8asXV
	lWYzSkr54RdxJM7c8Ry4cmco7WV1v4Quz+f9EN3hQ0chZSE34FD8HPvXOcIJINA0lcCYxF4OwW5
	6F/1nTxYBRGbZMeJGzOcnUnJhi1GUMeK8YIqNwMCdL4AhU/gL0RNn4Q669wDC1vtgHrYQ0Onp/V
	w+NEIhrGRzSYlBqz1TBUgvp0h6vrTIch0TgsFohEA1vwasI92aXoKQas7XiIY9yvM5NmpPGzGfO
	HZhbqS0RnCSvmakAj4cA8EzLAsR42I/VPzTi2+MxOxgYKufGoxssRw71k5JnsGY9dhChNg==
X-Received: by 2002:a05:6000:26c1:b0:48b:946:c1f7 with SMTP id ffacd0b85a97d-48dfaea3908mr25611964f8f.31.1792411396009;
        Mon, 19 Oct 2026 05:03:16 -0700 (PDT)
X-Received: by 2002:a05:6000:26c1:b0:48b:946:c1f7 with SMTP id ffacd0b85a97d-48dfaea3908mr25611747f8f.31.1792411394009;
        Mon, 19 Oct 2026 05:03:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4feb6bsm24515964f8f.41.2026.10.19.05.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:03:13 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:03:10 -0400
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
	linux-um@lists.infradead.org
Subject: [PATCH net v3 3/8] um: vector: trim skbs before verifying the header
Message-ID: <372d22237412a8dee2f848660e76162f05c566cd.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1792411304.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zkxgNoILBhkRnMBWXk5ejXm7PY6hMpNeflpdTqYFz2U_1792411396
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_050322_488221_790E1508 
X-CRM114-Status: GOOD (  13.65  )
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


