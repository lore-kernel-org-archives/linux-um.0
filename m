Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B552C982FD
	for <linux-um@archiver.kernel.org>; Tue, 22 Sep 2026 03:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B5rs7+ILfA3J/8r3zuBgSBRVCSTxSnXx2oYi6bmrhLI=; b=qpWM/UGcnvN6PMyYGiD4YKs7Co
	mn5Wayu6bzeYsd56vIhtNfvJC1thfzLg+OeS03TNqmsS/Xtd3PcPlMuZslVj2IeuUQUsjjrGHjpB/
	sirpxgUOK+u6YtdR6eig1tA3/UAYWajhTMIIE6FuWxwBn+j9ZgqR/BC3ZOY2sFVDAPaZP0sdhFRT4
	2uar6CwGZ6p8fxq9IHqVwm08KtLR1aiXW1LKAxwwpcSaeirzeZrKimrIp8ER5Q3UimwUc4J0NFRb0
	/jF1T3GVCuADRA+r2BeewTQkS6icDp73f1s+LJ4wxQS+uPvlkwEU9JDsVOEg9iGOq8tmt7vMVrVmy
	AkycnUVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8qn3-000000042dc-20wv;
	Tue, 22 Sep 2026 03:03:31 +0000
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8qmv-000000042bq-2Utf
	for linux-um@lists.infradead.org;
	Tue, 22 Sep 2026 03:03:23 +0000
Received: by mail-yx2-x11.google.com with SMTP id 00721157ae682-85d43db0c17so37452807b3.3
        for <linux-um@lists.infradead.org>; Mon, 21 Sep 2026 20:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790046200; x=1790651000; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B5rs7+ILfA3J/8r3zuBgSBRVCSTxSnXx2oYi6bmrhLI=;
        b=ONMpbMn76gD7+bjPWHo5aGjekBpgcsqmCuOyLsm4CNWrLCN41Cl/mCXhT5e78znVPL
         qgo+8h1ptzNuH0bvgAYBdiroSvhQAb+A6fNlRrs93YtDeP02P79/GIYJwOSBP9/UKJR+
         gxXjCNqOXwn+Ey80YXcGTGpbIzwp3JgU013NYmzNVs7w6GDiRo8cZZB8dcecYADcAW+D
         x2SfnsWKEmWNsahjOI5UWbeEH9Y7EZ3LfvcUCTxbeOdBaU3iO2o5YkQM2I0Bos0LS2P/
         olkO0SsxjKA/l69zGaJCZxqL/eAbWQxuSj91YALDWzRKVW3aWEtv3JVfVM8F/HXtBm8Y
         LBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790046200; x=1790651000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B5rs7+ILfA3J/8r3zuBgSBRVCSTxSnXx2oYi6bmrhLI=;
        b=w/uofxmiPtIZ4yk/sg6+aYbVg7xnf+7xjMzTAf/xNFAokaOQvQ0FW7GMu9Nl1oADfR
         j4zNoYjmwJDCMYnNQALgQCBmIbXICoa/yZO8ZiOABr4a8G5FIP1dBLOID2oco6VRbjJx
         VctFe4C+r3tgQlZZxHt43UD2emtO55wuTR167XCmWuw6iZV27tp+KAj+eCENQ/TAKAvZ
         FJlmBuPtsyC14MRu/7FWApq5VqSnEFjDPntTMhTlLpipJbz77z7QknhuyTpvtX3U3T/m
         5l0tx37e7ASRsVErV0s1h8g853kB0qiryP0qFA8uocRB+vlmQ3DEkt8LnH1cYCG6jXb+
         lf+A==
X-Forwarded-Encrypted: i=1; AKwUvBytgrAzZTkUPGzYyrKj1iRi++/a1v1nz5U8371rpAjrAV9sM9SL5O5A5iuH4G1eIZg25y9izhLKBw==@lists.infradead.org
X-Gm-Message-State: AFuF++nDCrVOQzmXd6j5e+kzXW3VXpBI+XcVkpd7va9r0631N9rtRz7k
	JzU5BQfjgvroLGLew+8QviQI5gF45EasJojir3Eb85i5Nkj1xGVlcqxF
X-Gm-Gg: AYBFou1NEEVWLs5dQ3IDCi9ezFs2RXmLkIkOlm3FKBlBOE31CRS+ilnexhaZuYdiNms
	SOkS6UL0O30b4eCXPUWBKnFC26hHIxRsL4Lv6/eW3sGsfEoDNc2fDueA6v7nRenSJ2lfCVaaNcS
	Qyij0XfiLT9mC6HXGuRx2Vz4qlRUei28B2iSOUQ4QMHNpYSmo7JZB1wIuc7IHzvImm90LLEXl/L
	hRrpgDNLWzhT5g5WNQvPZceChgsnRoqZjZWJKrh9l6LpkwJZk+k3eLBKDkG0Y6YOMpjZIgRtxrY
	qqdQ46/RdI+iiQ8VVtxhgRZogu1bbuRr++q74J4tXT2/s6b6z0XnnKClLcnSDgQadutbo4g1S/Q
	omqMhBYtokFZWajciGsrZrgIgtFhZP3rQDgUcj1P6pRujgu063SCVI3aWzKAVwBiLWKSkS8/Ghj
	2aTwyGVFp1/66HPWi6dPdX+uGj6wmSsZqCnGLUSSkt/O1UyXhjL0TLCUpmdwS0xsxo+EudQOH9U
	I11hnOM1X5M2BD/x3xsjkOm/5lKk1tekDMy6XoIiXTDG2bA8AG5gpL+80pEa/KsfoalFGsY
X-Received: by 2002:a05:690e:138d:b0:668:1c09:aef1 with SMTP id 956f58d0204a3-6717fc7e75dmr3816179d50.6.1790046200291;
        Mon, 21 Sep 2026 20:03:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:2875:43a3:e345:710c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a2c1b02abdsm1471447b3.17.2026.09.21.20.03.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 20:03:19 -0700 (PDT)
From: Paulos Yibelo <habte.yibelo@gmail.com>
To: netdev@vger.kernel.org
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	mst@redhat.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	razor@blackwall.org,
	idosch@nvidia.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-um@lists.infradead.org,
	virtualization@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v6 2/2] ip: reject partial checksums covering network headers
Date: Mon, 21 Sep 2026 23:03:10 -0400
Message-ID: <20260922030310.8684-3-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260922030310.8684-1-habte.yibelo@gmail.com>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_200321_707838_7398A4F7 
X-CRM114-Status: GOOD (  15.59  )
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

ip_do_fragment() and nf_br_ip_fragment() complete a CHECKSUM_PARTIAL skb
before reading the IPv4 header length. ip6_fragment() and br_ip6_fragment()
complete one after parsing the IPv6 header chain. A virtualization
interface can supply a checksum start which, after link-layer removal,
still points inside that parsed network header.

skb_checksum_help() then writes the completed checksum into header bytes
the stack has already consumed. For IPv4, changing iph->ihl after routing
and validation can make fragmentation copy beyond the skb's logical linear
head into transmitted options. A negative checksum-start offset is rejected
by skb_checksum_help(), but only after a WARN_ONCE which can panic a
panic_on_warn system.

Validate the checksum start against the parsed header length before
completing it. For IPv4, read and validate IHL first, retain it, and
reacquire iph after skb_checksum_help() in both implementations. For IPv6,
use the length returned by ip6_find_1stfragopt() in both implementations.

Compare the signed checksum-start offset with the bounded signed header
length so integer promotion cannot bypass either boundary.

Fixes: dbd3393c56a8 ("ipv4: add defensive check for CHECKSUM_PARTIAL skbs in ip_fragment")
Fixes: 405c92f7a541 ("ipv6: add defensive check for CHECKSUM_PARTIAL skbs in ip_fragment")
Fixes: 3c171f496ef5 ("netfilter: bridge: add connection tracking system")
Fixes: 764dd163ac92 ("netfilter: nf_conntrack_bridge: add support for IPv6")
Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Link: https://lore.kernel.org/netdev/20260920004733.6473-3-habte.yibelo@gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 21 +++++++++++++++-----
 net/ipv4/ip_output.c                       | 23 ++++++++++++++++------
 net/ipv6/ip6_output.c                      | 12 ++++++++---
 net/ipv6/netfilter.c                       | 12 ++++++++---
 4 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 7ecb8a26b..d81ed8692 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -38,18 +38,29 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 	struct iphdr *iph;
 	int err = 0;
 
-	/* for offloaded checksums cleanup checksum before fragmentation */
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
+	iph = ip_hdr(skb);
+	hlen = iph->ihl * 4;
+	if (unlikely(hlen < sizeof(*iph) || hlen > skb_headlen(skb))) {
+		err = -EINVAL;
 		goto blackhole;
+	}
 
-	iph = ip_hdr(skb);
+	/* Complete offloaded checksums only after the validated IP header. */
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (unlikely(skb_checksum_start_offset(skb) < (int)hlen)) {
+			err = -EINVAL;
+			goto blackhole;
+		}
+		err = skb_checksum_help(skb);
+		if (err)
+			goto blackhole;
+		iph = ip_hdr(skb);
+	}
 
 	/*
 	 *	Setup starting values
 	 */
 
-	hlen = iph->ihl * 4;
 	frag_max_size -= hlen;
 	ll_rs = LL_RESERVED_SPACE(skb->dev);
 	mtu = skb->dev->mtu;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a24cc8ee1..fa6a74d20 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -770,16 +770,28 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	struct ip_frag_state state;
 	int err = 0;
 
-	/* for offloaded checksums cleanup checksum before fragmentation */
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
-		goto fail;
-
 	/*
 	 *	Point into the IP datagram header.
 	 */
 
 	iph = ip_hdr(skb);
+	hlen = iph->ihl * 4;
+	if (unlikely(hlen < sizeof(*iph) || hlen > skb_headlen(skb))) {
+		err = -EINVAL;
+		goto fail;
+	}
+
+	/* Complete offloaded checksums only after the validated IP header. */
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (unlikely(skb_checksum_start_offset(skb) < (int)hlen)) {
+			err = -EINVAL;
+			goto fail;
+		}
+		err = skb_checksum_help(skb);
+		if (err)
+			goto fail;
+		iph = ip_hdr(skb);
+	}
 
 	mtu = ip_skb_dst_mtu(sk, skb);
 	if (IPCB(skb)->frag_max_size && IPCB(skb)->frag_max_size < mtu)
@@ -789,7 +801,6 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	 *	Setup starting values.
 	 */
 
-	hlen = iph->ihl * 4;
 	if (mtu < hlen + 8) {
 		err = -EMSGSIZE;
 		goto fail;
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 550965058..d157b6ade 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -942,9 +942,15 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	frag_id = ipv6_select_ident(net, &ipv6_hdr(skb)->daddr,
 				    &ipv6_hdr(skb)->saddr);
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
-		goto fail;
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (unlikely(skb_checksum_start_offset(skb) < (int)hlen)) {
+			err = -EINVAL;
+			goto fail;
+		}
+		err = skb_checksum_help(skb);
+		if (err)
+			goto fail;
+	}
 
 	prevhdr = skb_network_header(skb) + nexthdr_offset;
 	hroom = LL_RESERVED_SPACE(rt->dst.dev);
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index a7025ec87..da7ada12f 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -144,9 +144,15 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	frag_id = ipv6_select_ident(net, &ipv6_hdr(skb)->daddr,
 				    &ipv6_hdr(skb)->saddr);
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
-		goto blackhole;
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (unlikely(skb_checksum_start_offset(skb) < (int)hlen)) {
+			err = -EINVAL;
+			goto blackhole;
+		}
+		err = skb_checksum_help(skb);
+		if (err)
+			goto blackhole;
+	}
 
 	prevhdr = skb_network_header(skb) + nexthdr_offset;
 	hroom = LL_RESERVED_SPACE(skb->dev);
-- 
2.46.0


