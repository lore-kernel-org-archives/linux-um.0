Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD64CC6B33
	for <linux-um@archiver.kernel.org>; Thu, 15 Oct 2026 12:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pEV7NzYtQRgE9IRDA9odxEpqlMO8W0BmhwXqYIjgqPM=; b=D3H//iGINqgn4/omo+bUJnvGt6
	dAY6CLmwmSdwGx+4uB0KSmuN4E+v315yLeA9wwJFmgQx/CNqJnJazYahycSVpeYUXaguP0pRpSjwd
	cmdRc3Gcfndtw85FU5gwUmJ07mQcH8RW42lNuPdsBYFNR5A/v4DL2e/Nj48vcsR4VxWfKkhrRx9hc
	Ojaq18cq9p6sK7yXc6FF8iuq5gVU301EiG8nXyfpy7NXZUdMKNqdwA0HoK4/ZvA36Aq6jsFo7oNDY
	llJs1hnLECm4d8z0AqYza/XCdJj4QG7KL4w58dmL1kWY9WXcgo/FJGDu0/Dad4FVHfJXmRYJUsey0
	lfjf/gog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHKm5-000000008zz-2Dge;
	Thu, 15 Oct 2026 12:41:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHKm2-000000008z0-0zzT
	for linux-um@lists.infradead.org;
	Thu, 15 Oct 2026 12:41:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pEV7NzYtQRgE9IRDA9odxEpqlMO8W0BmhwXqYIjgqPM=;
	b=TqDiMMtB7wU5HpDpYLJGNVXchL7dmP1dnT9e8LsZUXgEBVUESnf6hzwhkRxHYcpOuwGEps
	84piTYnR3ygOwZQRwfiiL4Bx5axK8DIziZySBkYLIbQqRvxmeUYo+O+n0/wOTuz92h8dTu
	EerAlAa31U0T1dUlxz2bCXi8vPWYChc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-EjFcrR0mOhmH0oXVWudfKA-1; Thu, 15 Oct 2026 12:41:26 +0000
X-MC-Unique: EjFcrR0mOhmH0oXVWudfKA-1
X-Mimecast-MFC-AGG-ID: EjFcrR0mOhmH0oXVWudfKA_1792068085
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48af4046a3bso4113523f8f.2
        for <linux-um@lists.infradead.org>; Thu, 15 Oct 2026 05:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068085; x=1792672885;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pEV7NzYtQRgE9IRDA9odxEpqlMO8W0BmhwXqYIjgqPM=;
        b=YZx83uPuO82bvAV6SUPbPRGBE5Ohv3oXyXAk3CwJ8FS1PEFN+gibIbRSvIWFUTfzCt
         yTyhIjw+0/lIA2v5UAmHfR9G+Ja1ZrEYgdhboRAFeeSEs4PMI6iVbzCi9yg5IZIaexwO
         GiBkVkbyoYAG8GKdr4Lw/jUcPH5+K9NZN6y+4jB2PJe7n6Pl540gaEAt7DQnbP01mFFn
         gNz/uaPagKbhVwYEl7sJ1gUEj+tUdF4qRNBI7+GKzEuwwmN0m4Gfp6MchuL1Fff0Rha5
         WGtvc96rfKBTLkD10lmgn8CwMl09T2oETuL0fA/O+cxj0dPepJ7b+xqDbsFBNbONkydC
         TuGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBE54QjU01Oj2kANJnpEpSjzK0Z5V4uBw1v8+z9s8E7oRui46eugHVg4fCyKAysYWpTgvNdezvcQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYIz9m1kiZvKpXXAsIxKFBTKfn86qcWjOBOXuQad/5KcGzzBfT5R
	CiXAlAxM82LVj+1XbPNhE26n1Yq03yCoXeaNxPWU4QjT3BxkRmrQG3Wc9PtGZ7wkzwgoOKC8Rtk
	ul3kMJExgs3TuAz3WBfztvAAuQrNRllTcKKRG7Jkt2Wu1liPwObHk8+s0huaJb30SzA==
X-Gm-Gg: AYBFou2U8Jsth5t9/GXA4YNa61NP0RzCgXTOPeKDjcigek0e9A2PHvR1aAADa0RIxqm
	mC0cP09Nm7IY5uj4Po8+5ihH8gazLv/0G0EtxfXMofRnjiDSvnCvyIBsRK2mKOiEcskx6YBGNYz
	VIFg+0vtSZeIGrMf8JzseW2mBqnlpmNT0lmXXGI6Rx9SCIQhraoxbJF2X+Icl56J+FpgucFrnvF
	7ulqGsLiUI3lw42fSA1OzZT/yXBRcBDUdwRzdTmZrTruxFiOTvP1b1ZqqtXL68xt9n6p8BC1mKt
	Dsy+sha5+gB/TahO0UUR5qN6CqmT69RqUQDqvcO70I7QEOjMBrpPMTzIqxISUn2X8sJM9A==
X-Received: by 2002:a05:6000:1868:b0:48d:db43:9187 with SMTP id ffacd0b85a97d-48dece6d67amr10912254f8f.16.1792068085125;
        Thu, 15 Oct 2026 05:41:25 -0700 (PDT)
X-Received: by 2002:a05:6000:1868:b0:48d:db43:9187 with SMTP id ffacd0b85a97d-48dece6d67amr10912175f8f.16.1792068084547;
        Thu, 15 Oct 2026 05:41:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de09693c7sm23198836f8f.4.2026.10.15.05.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:22 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:41:20 -0400
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
Subject: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr conversion
 failures
Message-ID: <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1792067836.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DIChjjT5RB52fLpKCxWosAwuo2dnZcDPNoznVYvwSmw_1792068085
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_054130_348087_D5146773 
X-CRM114-Status: GOOD (  10.75  )
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


