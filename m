Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086460A2618
	for <linux-um@archiver.kernel.org>; Thu, 29 Oct 2026 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=a5Cg79EV;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YlJAnAkx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YKSPCbeY/OQI++t0FoyUVDRUKnMhMVlO33rtvFKUKas=; b=a5Cg79EV33bIxtiQ3sy6IeVKph
	+g378bhwSm1w6pp5IXi/PoKwhGKhv0ZsqFXcIWIsGg1B5jCzPCM7xS/NgsDXAN3/8DsC21/Yk5usC
	MXElL1Y19QnWwTI375v+GpOn5QDQU64Pd7I874CJ8AJusC//WX+0BLT4xrtJQ+6f2/1lEy+uA8Lqq
	pwbSCdYYqXF7A6cBKP3fVBYxuNk6dIIRfSmVZrb80Lsp0W03/KormnIPq7H3zIkKrD+2FMb2MtrB/
	etXxDTgo/j27YH8HbAM8DcmpL88jLoRER1/ho+c7BshIYr8VnTXVc3va/v5ne7HEWqa6LrFlnPMbI
	vMlZ00fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMVFv-0000000ABKM-2tvu;
	Thu, 29 Oct 2026 18:53:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMVFt-0000000ABJi-22R8
	for linux-um@lists.infradead.org;
	Thu, 29 Oct 2026 18:53:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793300020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YKSPCbeY/OQI++t0FoyUVDRUKnMhMVlO33rtvFKUKas=;
	b=YlJAnAkxwJ+kqnHGTw7OOfRmBCTLFLkHQwPwdUPLA13mvof1syA7Mox5Jr7a7RyOZRUn9o
	T4PEVcAuLnGWwfN6QKTg5fhJF491rZMaI6wQYTtj6BCq3xWPpkKYY66QyetjnJ5kpNoVEj
	EFzBO4EOnfI7m/4C+jsunLRzfphcRv8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-idOybqWCOTeF3Y0_W8gVdw-1; Thu, 29 Oct 2026 14:53:33 -0400
X-MC-Unique: idOybqWCOTeF3Y0_W8gVdw-1
X-Mimecast-MFC-AGG-ID: idOybqWCOTeF3Y0_W8gVdw_1793300012
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so21018055e9.3
        for <linux-um@lists.infradead.org>; Thu, 29 Oct 2026 11:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300012; x=1793904812;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKSPCbeY/OQI++t0FoyUVDRUKnMhMVlO33rtvFKUKas=;
        b=oQqdoWfwYA2iR8Y7NXXmRXKGc2AbFSGOjWZfEzT9n/l4bzL/Pvjpq/Qp0cPwt2mJIM
         Hyw16H/kzBOMJfIOY4AoB06ecO/xHT6PvleAc/W3nR5rpgiqqEDeOWPobeUUWmiOrdCr
         gjkwAEqUVq+HdsRZCGX5T7TO2+9C1HEfqvHACYiy7tRG+9CHwEuYnRacLX8f3z3lmV3R
         Y1l8ETCxXhFfggUVwl+W9ZXPUPOJl5PCNmrVHV223xniutYv9ifYIshBKHIslhHlxV9q
         aw+4o/HMmkVHoi8IrmAfqxbv4k2Tjm634VeBLdi3fxiDwWgKsl3dZmmZnb4Dp0luy3Ch
         HQvw==
X-Forwarded-Encrypted: i=1; AKwUvBzSOGRaPMmRcTtrwsDvgA7nT1UirTltgD3Bu9xc2z0y10VrEVxnTtTuvywxQsuNKbgXsRvh8updCA==@lists.infradead.org
X-Gm-Message-State: AFq9FYJb2LZobYmut/uHeuudWGEymTZ0MVHE4DXd4sbSGOrGgDLF1fte
	c1CKUek64iort6PI5rwLfSdfmuVyW28jJYHSK4WF/dBdbjjpq6IADADX0n4i5X+A85bKbVvw+e9
	FAXf6/As7MFzHyQy/Z4xv+QinE7AZCCcPDfxqPOEz16UdStPtkJ0r6KEVudcF3q3MZw==
X-Gm-Gg: AYBFou10dUrCgzFIK0WEVu8UXBJmfDZriLrBcRBoYj2ncjnFeARd36BlUS8gNM1Soiz
	EbQZQxs4fPVukZDgPB7vvkj27AwqTklGiinoBSFziKSfYH30OS72LD7BqMpXQ1DW6bTtrbZ4nBo
	iEhnmfrYm0jVy/jFpa9Uzde6kRZzNQuaGbtuv8FeEwpcMf/crq8WSErFX/qggiNnc4ap8EXQglS
	ctzCNybr/GC2NbFqboKAMxPkdXi0IFF7zX0lQwJwyHJjeCDwBy4+ATaLKocHj2TW602c/+YDHGP
	bgIt1T8uBxDM/VOeWdrItpKfOblMXXWtpb+BxpkQmiZu9oepwJtGXUjTk3YRIyIzRlXAx41oNAy
	79NZoyOjEpg9O+THfREfRZFv+vAGDZq47CAFUyw2WBmGN
X-Received: by 2002:a05:600c:1909:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4a9675dc5cfmr142984555e9.28.1793300011491;
        Thu, 29 Oct 2026 11:53:31 -0700 (PDT)
X-Received: by 2002:a05:600c:1909:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4a9675dc5cfmr142984155e9.28.1793300011057;
        Thu, 29 Oct 2026 11:53:31 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b289f7sm4241265e9.5.2026.10.29.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:53:22 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:53:19 -0400
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
Subject: [PATCH RFC v7 2/5] um: vector: trim skbs before verifying the header
Message-ID: <d5a36cae5997d36ae6b4bb192a251194e61a8a2f.1793276116.git.mst@redhat.com>
References: <cover.1793276116.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1793276116.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uaKTO2fo214bt_G83mhmHzHxGiBMEMI_oM6EfXTXU8s_1793300012
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_115341_600581_94AFFE25 
X-CRM114-Status: GOOD (  13.42  )
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
index e902e78c5ff6..828bd61995b8 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -873,6 +873,7 @@ static int vector_legacy_rx(struct vector_private *vp)
 
 	if (skb != NULL) {
 		if (pkt_len > vp->header_size) {
+			pskb_trim(skb, pkt_len - vp->rx_header_size);
 			if (vp->header_size > 0) {
 				header_check = vp->verify_header(
 					vp->header_rxbuffer, skb, vp);
@@ -887,7 +888,6 @@ static int vector_legacy_rx(struct vector_private *vp)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			pskb_trim(skb, pkt_len - vp->rx_header_size);
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			vp->dev->stats.rx_bytes += skb->len;
 			vp->dev->stats.rx_packets++;
@@ -989,6 +989,8 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 	for (i = 0; i < packet_count; i++) {
 		skb = (*skbuff_vector);
 		if (mmsg_vector->msg_len > vp->header_size) {
+			pskb_trim(skb,
+				mmsg_vector->msg_len - vp->rx_header_size);
 			if (vp->header_size > 0) {
 				header_check = vp->verify_header(
 					mmsg_vector->msg_hdr.msg_iov->iov_base,
@@ -1013,8 +1015,6 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
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


