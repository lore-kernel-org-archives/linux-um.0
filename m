Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC698CCF2E4
	for <linux-um@archiver.kernel.org>; Mon, 19 Oct 2026 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+e+7zZS8Om0Hv5D5NOXTDcthbJqXRoYdlzoN2ljcZOk=; b=2iBUV9/dzqvJXcQWt/shjBzf2G
	W1nBy3Hivg3nCyY1H44lmTL9tbU5kDlvnODLy6Vb7dr85GEBLMtqKXRJLlkcvNpsgZc9xlD/zhXCq
	bfvbb9Py1lnP9TuzNp0V2KzpLYe5y//AYV1/7QbSJcpqQmKJEJOfQEmK1gKwKkdF9Fn8nPhF1Fo8B
	J6X3wxDaEbtoLJflktPLUMddeks25QCoQYFY/UFyCchcbhGhzlV2ByTeZrr5m3Oi55bmQ6M5BcC7e
	xvyDdv3/HbLMAkMsR0EaLBgSki1wCRvhJBzWSjx10dQJZZw6TFBLnJWiOH/+8/SEBDnqVU7JZFQx+
	votlyzqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIm5N-00000007LDm-2Wrm;
	Mon, 19 Oct 2026 12:03:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIm5K-00000007LCQ-3SSK
	for linux-um@lists.infradead.org;
	Mon, 19 Oct 2026 12:03:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792411401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+e+7zZS8Om0Hv5D5NOXTDcthbJqXRoYdlzoN2ljcZOk=;
	b=MBgAZaDj1Joq3aTiX8BztU6AwyjbDBI/8UYbaMDEMqYO14cG2dKWjaNbdjtKvH9S+81HRA
	4DZ7KN46E+M/cTcJHJGHlZFtt8vl/pncF/aOGKyQh8uMb3ND8DOPlaWDqMvgipWRvZllK9
	rGXimws1baopjV69vHbw6nVJaruhm18=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-zp5HQBACP-mK_wgq0590JA-1; Mon, 19 Oct 2026 12:03:13 +0000
X-MC-Unique: zp5HQBACP-mK_wgq0590JA-1
X-Mimecast-MFC-AGG-ID: zp5HQBACP-mK_wgq0590JA_1792411391
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e00f3929bso1544107f8f.0
        for <linux-um@lists.infradead.org>; Mon, 19 Oct 2026 05:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411391; x=1793016191;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+e+7zZS8Om0Hv5D5NOXTDcthbJqXRoYdlzoN2ljcZOk=;
        b=Lguxsdl8+Lb42EKq5Unq67qQK5IIu3gigPBgIKy70Z23eyLZtdXO2mv5pQQxctpdob
         wnVq8yvaK2Gzg7TgCdQlkbC9fqZVYODgvMD9dmXr5ZaVvRtdp0qIByz+V+I/ZZcNcBDt
         iOci9C+7bi4updx+zUyDOVaF5mkjnBc5aDeNrcebURIFYlpMHEkoVA/2TZV85dTS6+OE
         GfG/uP1hwM/OImj4+D7Owz9sRlmXOYMIP5oot3lTKvq9km6pGgrzLsM59xcOHy+a2x5g
         T2y1zbr+nZQhFt2NrdDY1+22JHZb5AOpmxs3hyJ5EnMWrEkb+iMsW1hghfeCgGSOwz7j
         eq7w==
X-Forwarded-Encrypted: i=1; AKwUvBzTrS71Z+5mjdjXchRhrCpv3kihlOQgIQQft0sA/L5oC2s31oqPzl+f47Ee9qg8JYUYy6t+OnFTVQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYLepCEENGgOGASTEFVOy5i6DqV7DwWZrFPN5k6tGpNYWllJDJHd
	biNAzzjAnLrQVpxSLiJX6ZUB+8PWdrNNlH0ni6rHXd0prRcBV2vPbthfhZrG60sq6LwYispftLA
	3vXID2VcdpPGCfJPTyBB3p3UBzw837wcWn2z9hDn2pvGtyc+hJDpuC+r4EasoM+uA2Q==
X-Gm-Gg: AYBFou2R0gPZipK6jOqEt8LQjRS0dIWlfgxnIUsLM4dJD3EqtO4oxHK1NX2UmTEJZux
	rDnuA0rZRJhEKm/UNli4W096DxabZZyTIpIUYFu+94GcblgWOCnORmuRpX3nDHYepXJGmFzAnlL
	28Ch/2Bh3AqCCPKljYgb58IkazLQ1uM70naCC+7bs9tb4RO+ajar1tTZ3PoKDcJTDtJ442orXHm
	B71L2fAipKqJCXECf/6f9lUBcM919eVSVantmzn4KLxj2J22X4Uc6M4pApkRk/8swTlg5+0v0bP
	IneL0G6g+C2hJmZUxwN+wiyOLZDiB66G/Tp6kCBur/epiYNCeoMcE3YEITzj4njzlvhN+Q==
X-Received: by 2002:a05:600c:2319:b0:4a1:877b:d4e0 with SMTP id 5b1f17b1804b1-4a1c66bdcafmr171831755e9.12.1792411391188;
        Mon, 19 Oct 2026 05:03:11 -0700 (PDT)
X-Received: by 2002:a05:600c:2319:b0:4a1:877b:d4e0 with SMTP id 5b1f17b1804b1-4a1c66bdcafmr171831005e9.12.1792411390490;
        Mon, 19 Oct 2026 05:03:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c0894sm20719207f8f.12.2026.10.19.05.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:03:09 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:03:06 -0400
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
Subject: [PATCH net v3 2/8] um: vector: honor virtio net hdr conversion
 failures
Message-ID: <554a7cf11f82676fcadde914c7044dcad9bbd0b5.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1792411304.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0Nt4Mz3WlSLbphXUxMpNFc55ETtq244cJCu3kGXjWIo_1792411391
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_050322_938338_C612F1FD 
X-CRM114-Status: GOOD (  11.99  )
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

virtio_net_hdr_to_skb() refuses packets whose checksum metadata
it cannot make sense of, but the vector raw transport ignored
its return value: rejected packets went on into the stack with
their metadata unvalidated.

Propagate the failure.

Note that a follow-up patch will modify virtio_net_hdr_to_skb()
to return a negative value on error and a non-negative value on
success.  This is why we don't just propagate its return value
directly.

Assisted-by: LLM
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/um/drivers/vector_transports.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

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
 
-- 
MST


