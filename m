Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130DD60A260E
	for <linux-um@archiver.kernel.org>; Fri, 23 Oct 2026 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Xu8Efin7;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=id6hoyZw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=; b=Xu8Efin7a+Yy0q3V2FwJ8U2FJW
	ZwwcOEc40PeSZPfyIIDqJXl7KQcTdRgRDv+P+2FOs+8Jeek/67R3HEn+F7cITwjzL8rU2hx2LRGTF
	nGMJV3GPYRfxuCsIIjlFYfDF0RhjvvmvpALDTwa6e6sTi9Fx1ES83YLHYCO2pyUdGk52KRo4PMtdj
	R5E+QjSXaDJ82n/f0w3HKmtwKMqrJv870bcnerromxDTXh0JowWoeqHXCUzH4iLLaLSBY84GPk//S
	MHmY7kJfAl38I1wPf9JCJYf8qfYjMfs8gmTSJwsvjlygPy2AGqaQIVuH9Ki3SQYEOFqzQtC0cufAj
	pdCnj2LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKGtp-0000000GaLU-39wj;
	Fri, 23 Oct 2026 15:09:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKGtn-0000000GaL8-2hCv
	for linux-um@lists.infradead.org;
	Fri, 23 Oct 2026 15:09:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792768178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
	b=id6hoyZwPdsxhswfcVbl9FCX13LR1/PxjfX91nOyyHIMVfeX9GACCMyVbyiiqauTCBl2TF
	9yfRZxtFWFc5DZpdjK9Nzjy5XY5rN0baQmqXtxna9/Smfi8Y7lW/fO6J4ZUUT8/z6ZObyi
	feEyvlarftY+/3vczPbaqOt5d+76Juk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-AuMbt3v6OGahl3IYn9zdow-1; Fri, 23 Oct 2026 11:09:36 -0400
X-MC-Unique: AuMbt3v6OGahl3IYn9zdow-1
X-Mimecast-MFC-AGG-ID: AuMbt3v6OGahl3IYn9zdow_1792768175
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48dff112136so718229f8f.1
        for <linux-um@lists.infradead.org>; Fri, 23 Oct 2026 08:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768175; x=1793372975;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tgpP8ntgb1IS0cEJ3QYg5i8QakFDo2yC2w4u+PGohBk=;
        b=WKQ1Pmn4Ew/PblexYQiP/nxF8Bc6ak0PS0Ge8hfvd/42jdBjAYx0DBUHNl6F9fHStz
         SmX3otYT3b2ZYKCyQzuEYr1p4kz83EAPVJmWhUfc26QnbmKtVyyxbMStNLTdSdr2MEQZ
         0Ir5f6M0qNe6JSoiHEc4NqVhVEdTuRW8Ws1IVQa4DdUTAFpe5tX8stzkqcOO1KgGDxgP
         7HG444z+Rw9sjW69/yPCupv1o9jddnZJ3HB9vod1m6qdoxPv0ZRQqrX7Q+j/YrTKWwmw
         fDe1vXfzwv/17TpIOaSkQknHCKnbHd+DNc4Q9585kL3/CUF+dI6UcMetV8CP1PPvNdor
         21Lg==
X-Forwarded-Encrypted: i=1; AKwUvBzbHCEAB9HJrHn2mbNR0NP1/5cWQBYuoUZ67hx0oZHnBcvQnWQ8kVO6FFT9O8NnFDNFMoJHQvr43Q==@lists.infradead.org
X-Gm-Message-State: AFq9FYIKCLUHiVhiKmGCZhP6ZCseQBkFcveJMpDFaw1nKQnGhMeaXtxO
	ZsiVf1bhJQNGyjr6SNydt4yZlXiGENCHrogBdDM6WYz/DefX5ymY9Lc97PpcSJrJm5hMydz45xB
	cbTnyj+93uCgpEKfVjfZU3t7iz4We8WCOayVhnyOU3TNDi9G4+WSYcmcH5iMIjceKIA==
X-Gm-Gg: AYBFou0TIv1em0mIgqWm6lKKyppFl4CFZozNlvWxmkehWzQs7QXSPyfF2OsPhM51V7w
	Kk39NSNcjMEXwVWB/iEVX9iVWgCyNuwt7+5z0JjRc3c7gWrP4ToxS6GCGu3AcdwoIXUygiTqbRo
	LZk3qd/EgxZoVwpM4VnaupPXnpn3hu2+tGtRqUFe8ZIxHJD23bQWy3Axq17JPAjBeB4NsOxhPlj
	XNJRSNFnu3SNvYHnhKvWHHftBMAo3jTIK16UFAfiXsNh98okgDjmmfGAg0wQhMAQi+KkRdKx9lQ
	ZYQ1l4jGjTt3YbWWbqT0+VeDbzf1/aIS/iFAZmWIPOFEkPMXvaLS7f7YGCWUL6H0X5wLsYE=
X-Received: by 2002:a05:6000:4024:b0:488:79d6:a4a6 with SMTP id ffacd0b85a97d-48e38594e74mr3887736f8f.8.1792768175089;
        Fri, 23 Oct 2026 08:09:35 -0700 (PDT)
X-Received: by 2002:a05:6000:4024:b0:488:79d6:a4a6 with SMTP id ffacd0b85a97d-48e38594e74mr3887682f8f.8.1792768174508;
        Fri, 23 Oct 2026 08:09:34 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d400365sm339853f8f.25.2026.10.23.08.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:26 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:09:22 -0400
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
Subject: [PATCH net v6 2/5] um: vector: trim skbs before verifying the header
Message-ID: <dbbe73d2ce720e333aa8fa7c58b7bd01994a4216.1792768096.git.mst@redhat.com>
References: <cover.1792768096.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1792768096.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BvFC6SANHbInkM4lfIeglvDfsPCuE7Xhu1ffTvnLa94_1792768175
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_080939_763419_3E5A7B40 
X-CRM114-Status: GOOD (  13.03  )
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


