Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FB3606A33D
	for <linux-um@archiver.kernel.org>; Thu, 22 Oct 2026 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KESm3deY;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NX/LQjCY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=; b=KESm3deY2yr9Q+vhNr7a5Kmat6
	T2xTTOVYl6duDfYkB4Xo/lLwf1fgT84C24TSH4ZdLf3e8Hrr5phAt6t+0JKMU9kkoyNtF4CTXnII6
	3By5PfhHCWuj+d/NWkfehSYSQA7VYDDBhOJK98bHTKHTqo9l2SyVG+lQuWyZx7G4KlEKIWAXC6f+/
	EMWGs5Xq8pfTyg8mg2w0ftSg+Zfpnjvbw33OFEzo/vBGA9r5+053SaeJziAzJ/321B/J3Sk6X5FTR
	3+s15/p2OOOhd6DfZSyLdym0OBXKG2fNuIEdqCadTHlKhnk96ufclBFSefo2Gg4Tee6Dr+fRxTGhZ
	7f/IGHXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsND-0000000E7uv-0neC;
	Thu, 22 Oct 2026 12:58:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsNA-0000000E7uZ-47NH
	for linux-um@lists.infradead.org;
	Thu, 22 Oct 2026 12:58:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792673900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
	b=NX/LQjCY+5JWLB2kd49Ym6PPo+dDK2og8i6Dx1O1KfG0rMbeEqg1JbBGQFjSsI1ZqUusG+
	Xc4aty/0/v9QEXeT0QeHmKYuWkQrT8i77Xr/40yfJnF4ceeuWCIMtBskOU05GnsNO7V6Tx
	DqLuMBKiINTQKnITbGc79QBKu8TuZ7Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-UNgRe67ZMruIAkYp2X5J2g-1; Thu, 22 Oct 2026 08:58:16 -0400
X-MC-Unique: UNgRe67ZMruIAkYp2X5J2g-1
X-Mimecast-MFC-AGG-ID: UNgRe67ZMruIAkYp2X5J2g_1792673895
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48af4a0bd0fso1029541f8f.2
        for <linux-um@lists.infradead.org>; Thu, 22 Oct 2026 05:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673895; x=1793278695;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
        b=j0O+YF1iEYOeJEUrGpmgarEkruKzvxL3QG2aWpjfLs7BOerLVARn+HUzeKbIAAZpO1
         0Yc5ujJhj0YilBWkQIxkTgaGOKq5fGn2ci/j+d3btLsRqjCxqoUohKMptIageKqTLAWI
         0DoUbr1avmMYoguF+2i9IrEIZJjOXKzS99UhHTloEzblLP2tG9A7sP8JW4bDbNNw9yzN
         O9DnGZbbpdxuHSS67JXgSqdrm8+AM6+JU28cbBCGt2VbvVQ8PrNJyhyZ+VkqGEdJfZ9f
         xMZAObyfxWjwGHrDqiBVTVIAUsaQAiv+ZetDhKJn7t36sH5pEtj2rjawhujX4Kk08QnG
         fvZg==
X-Forwarded-Encrypted: i=1; AKwUvBwoUG6bxPr4OiX1y7GB1kr8WT41MVcXLO2sga+0SH6p8vS6w2yy/GUNOKB7ph0VZfoJ/mkCqYXI2g==@lists.infradead.org
X-Gm-Message-State: AFq9FYLsdsaXUHikn77dz/PUIVZYUzlhFOBmEPRhB2hTXjmKll0fCDWa
	3SmkKKBO17+hFbldsvTuZsa6EY3/zGavmKG9XVt4xIG9Z0RXod4CaG+ZJlwNSB8E/HZASGWTZPf
	H3cMVMDNhCSgpA0fhxlxvcvspqahvEPVL67pkXnkd1FNBcFHO0CRF2n1OX1UHLWcJvg==
X-Gm-Gg: AYBFou31LIH3VoPeHgg3olXkSbnUWJZLPWEd9QgdnDr7PobKINehyf7q7qI1w1jS4Wm
	YoBm5Ad/wRA9+iNrjw/yRFzujMEWpUj6RIufReNfHPr7Gvx5W5zbqGdQMFx9+7imT31rEJe3smy
	kL4PRkeaOFwDuBWSYnjqCuVoxgEN1yH7TgWhA04iVk8FMB/zKT2YjUMgaeR23H4nqvDgAp4MpDk
	cZH/C0nFVC4ot0aBi6Der/7ATkRqPwK8P5aHUfplZGf/ILVMjtDoWkL7HgMTQzlhFqcTNFLdaXP
	qwBdo3SLOazX2QlwimHRC2gXtn0vbLrwl/nQdL3460mwZrVNqfIZ/Axl4ON4UFLU2L4=
X-Received: by 2002:a05:6000:2289:b0:48e:932:af01 with SMTP id ffacd0b85a97d-48e264b569dmr9840318f8f.31.1792673894871;
        Thu, 22 Oct 2026 05:58:14 -0700 (PDT)
X-Received: by 2002:a05:6000:2289:b0:48e:932:af01 with SMTP id ffacd0b85a97d-48e264b569dmr9840264f8f.31.1792673894174;
        Thu, 22 Oct 2026 05:58:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2583ffa8sm12500019f8f.51.2026.10.22.05.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:58:04 -0700 (PDT)
Date: Thu, 22 Oct 2026 08:58:02 -0400
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
	Willem de Bruijn <willemb@google.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH net v5 2/7] um: vector: trim skbs before verifying the header
Message-ID: <1b2a0697662501fd4fe896a7dc2bba2d97885101.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.v5.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vgGrcdRYmjz25I9A6sJkhw6tGJ9GPqDNFvNr84A7Mgc_1792673895
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_055821_095967_9CBC7C90 
X-CRM114-Status: GOOD (  13.73  )
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

The vector receive path over-allocates the skb and only trims it
to the received length after the transport header is verified.

A follow up patch will complete the packet checksum in software within
virtio_net_hdr_to_skb so we need the packet trimmed (otherwise the
checksum would be computed incorrectly over the unreceived tail of the
buffer).

Trim first, so the import sees the packet as it was received.

Reviewed-by: Willem de Bruijn <willemb@google.com>
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


