Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09703606A31D
	for <linux-um@archiver.kernel.org>; Wed, 21 Oct 2026 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YekwFdz+;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TD0dtnCG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8bDfpp7sAel4FSdNGE9WjbJ8LMrLDJQ/k3zaoUEgNSo=; b=YekwFdz+57ybjeBAeLy0Tvu8Qi
	O+oGHpQWa5hUxk8RNyIi1R17tT/seN7T5jJ0me8TgtmMAoJGa7mZTzIaBB3ffEwCoI6zZL4zJK+vJ
	4Egtk2D5Hx9P0NVidw7MMTeyNza3Ik6H9jagbozocHPhsj8zEIlzLuUtxJVma0RqyQFWEQigWFX6X
	BIRRu+XnCx3f5iuRvUMMrWaUjh0EsaalxQE5Fb7nm23gDsktbYFDfFnLr4P1TOLowEe+V9TVDmq4p
	b2aSB1hk4MQxy7QCe9Kzkh6qNAW2Ujul6qIfGhBavkMy14E25xgbv6rk5CT63RV67b8PIqGiGDib9
	BVkDXKzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJR5I-0000000BGzX-3Fpl;
	Wed, 21 Oct 2026 07:50:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJR5G-0000000BGyp-1oCu
	for linux-um@lists.infradead.org;
	Wed, 21 Oct 2026 07:50:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792569001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8bDfpp7sAel4FSdNGE9WjbJ8LMrLDJQ/k3zaoUEgNSo=;
	b=TD0dtnCGzQ9C/5YVhNaaC7efxbD9XUGZuke7T0rOXaJGb33xtUSEvjZRruVvTv3kQwpFQf
	FXaB51lNTj6rGkxCLmB5uqRC9YnjRHSoL8IV3rPQ/so+sXYrOoR4tSlKEHKkGos/sBdoVx
	2sMEcGthkxiaPUhMiUzN9LhOHGzllys=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-fAF03aKmNXu61f1CyE108w-1; Wed, 21 Oct 2026 07:49:59 +0000
X-MC-Unique: fAF03aKmNXu61f1CyE108w-1
X-Mimecast-MFC-AGG-ID: fAF03aKmNXu61f1CyE108w_1792568998
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a01ba12198so10632465e9.1
        for <linux-um@lists.infradead.org>; Wed, 21 Oct 2026 00:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792568998; x=1793173798;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8bDfpp7sAel4FSdNGE9WjbJ8LMrLDJQ/k3zaoUEgNSo=;
        b=yvloscHow3Vn6OKg8tdWH53U/Fq34cL2XfFFFJBlXA1Bpr2B0uarBTHGsGCONOruCa
         6YpGxkvXFBJ5ThNchzXua/S/Hpk2hHN7z0n0wqNvwy4xfbQ++TFC9qjE/43qZrX4J8ww
         RS9Q4FvH4o+SbBjyxYRYW2CH78/xWavKe0/go/JuBNvkAR6pjqQ+HAd83geJFhtP99iY
         HkkD2BFCemDPRslPBClSB4CuVceMohRbc5SA+Cf62AyhlElGBaQOyphY/VzkI4jf9YLy
         KYGdI7Usxyy/ko/u33Rgzx86+iv2uxHp8YMr3HYgcbn+pSxrKAgvd/C+8aAoa12LKmva
         clUw==
X-Forwarded-Encrypted: i=1; AKwUvBwZ8ad3El+4rNU2wd33UeQ0EFVx+izzGSq+atlydemlSWuo5LxzqlIDmFUqfsrXljfB92FNj3ULhg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ+BrrT/PaTpVqQcCch6V9Uda8fQAJrpQLxpRdU5TFjB7PjgQpu
	tIbSmmtYr8NE/xCon5KMdDvTHIBk56WnU0i9S25w0UNI/X6DdkasWs1Ysb9NHofNnOtPiRHXyeb
	JiLoH+aXpNYovPkK7OkFgF3FsvRxrRazvWdjZkVYSNcw18S0AYm3dMyDTr5cCBDnCsA==
X-Gm-Gg: AYBFou2p3qyB1MNd73oE1UVq2ONrYtFNw1NnSeHGLusk/hBRqOFRDIXgfASXrNYkLHL
	CyH2o5ZIC4wCGU1l/XbWIeeAg4+O8mgS1RPmoxZ8CewxGkHd9+WDKHC0Oql2KhMxJ4aYf4JWowc
	DvjX4pUoNM5idDv3KQdo9XW51DBIK1pHpMb0C9guUl5iNMYsbmjcEppZuuC5ZcyqULnEUf76sAP
	6IWuEFMNdeTQ5nd9XKpfd2ET2RDdLSZLA83/7sKM89vQY+xv6p2bx3+nxFX0qCUNfI5SDawdY0e
	CjyGZiAovnlQZnUgTLNgnYrcozB8T8CuaM+EBKf6H/xoMgqt/T10rFih9JkGjIMnFbUwsg==
X-Received: by 2002:a05:600c:3f0d:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a1fdd29c19mr24760725e9.14.1792568998299;
        Wed, 21 Oct 2026 00:49:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0d:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a1fdd29c19mr24759945e9.14.1792568997732;
        Wed, 21 Oct 2026 00:49:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc1060f3sm34363505e9.1.2026.10.21.00.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:49:49 -0700 (PDT)
Date: Wed, 21 Oct 2026 03:49:45 -0400
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
Subject: [PATCH net v4 2/7] um: vector: trim skbs before verifying the header
Message-ID: <26741a9a64c28e8de6d13e04972d296d89e1c95d.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fUI2-D0ZOeBrHSnm3c3SYks9Z1SHa8OINTV3Ocvy0GE_1792568998
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_005002_553303_6FB5E4EC 
X-CRM114-Status: GOOD (  13.71  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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


