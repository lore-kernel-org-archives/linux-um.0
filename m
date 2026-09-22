Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F6AC982F1
	for <linux-um@archiver.kernel.org>; Tue, 22 Sep 2026 05:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CF3XLaCrxhkvQd9YB+62gDKmay5ProHUjjadncIq5pA=; b=mx8Zq0yJcrcMY+05bJkaBLQiK9
	SzAGBL/XCKs3OY8IyBQqg/QEQAKEdPV1iui1Wo8stEcfNmzwEBP+Rquot48jkAAk+RSdcF5iAnQ/L
	PX3VVpXms/3PwaW+zpvA2gDBDZzKSYTsoOxTqsBYD+FAxlw2WXx1fWGrlKWrfTsva49uyNqXitavR
	TcaORwDW9fzouFZ5DIAhRSiE025FPuGznamemeLSWdvOL0W+2UrT/+lsR0JbF+VdcpHZib5VIjb9O
	g1Ub6dPPTqW/JuuBg8XZGbXHOQerqCdzQIm6N4O5AmpsZXdLiNdS26eBCDzIt7apygerLerb1Mom2
	gmquNRBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8tU3-00000004IW3-2lhc;
	Tue, 22 Sep 2026 05:56:03 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8tU2-00000004IVU-01p2
	for linux-um@bombadil.infradead.org;
	Tue, 22 Sep 2026 05:56:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=CF3XLaCrxhkvQd9YB+62gDKmay5ProHUjjadncIq5pA=; b=kgPGwvsNYRMNWZ/nDdfp2nuIKZ
	jUbDyWDplYDY5q9JBEhRfzWVeoL0XdZCw8kX11cqtRMXEWpcD99sy2F919+Ljxl85XzZSIYZQCGjp
	1ncKAE9eHhNhEvXuFQ1Se/h2m0V90ysUpvsBWfhNKnPXrDxX/kkZeKOziqQlUiY12HRF+32ninJlp
	dQ6HjryYAmmNeNw7/5VaZAMzp/tc9biJwC6LzLDjmvAyUXV4ZbWlLJJHXnrfiHFswrIH/Xikp3Skz
	Nrm+kidmVpgeoEzS9dDnKMnziD1lq7WrX0fovHpRW+nqIHVlZ4RUejOZWku5UeLLBolSBFM1ibO+B
	Qtjgq7cw==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8tTn-0000000D8cU-3hCi
	for linux-um@lists.infradead.org;
	Tue, 22 Sep 2026 05:55:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CF3XLaCrxhkvQd9YB+62gDKmay5ProHUjjadncIq5pA=;
	t=1790056547; x=1791266147; b=fFe+XL5LRv8gWLoJHwV1osv3ORmjGqmlsffAyxHzdR2CRaR
	0RDZARA98ERRLQnFUiSslYd/WeX4Jp0ayxHX/i/CEHQF0lo4JIuC56gf3J2EwMsn7R1vLpbyzXbAe
	VZNLOZwFsN9QztKYYmMGqvVVKdICunhzuHmCLLvPLPxks3OioOasbgANReZv3Fy9z3NpJtP/JUEqa
	uWMQ2LtQQCKhtWxE77GzNTB6BvfubFlzjAcviwrEKJJq9L0FshqEPSeUU+f6IJW7fDS9/udhu8RmT
	1nWRsz8L5YLyZa7h7PI2UhWIfZ/Az7yfw7SM4UAYb1jvu1i5taBUfWysPZg4qXdQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x8tTW-00000006hzD-1D9w;
	Tue, 22 Sep 2026 07:55:30 +0200
Message-ID: <b2d23b4a7cb6af54a5575436823d82442d6f6cc6.camel@sipsolutions.net>
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
From: Johannes Berg <johannes@sipsolutions.net>
To: Paulos Yibelo <habte.yibelo@gmail.com>, "Michael S. Tsirkin"
	 <mst@redhat.com>
Cc: netdev@vger.kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com,
 	willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 eperezma@redhat.com, 	xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
 pablo@netfilter.org, 	fw@strlen.de, phil@nwl.cc, razor@blackwall.org,
 idosch@nvidia.com, 	dsahern@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, 	pabeni@redhat.com, horms@kernel.org,
 linux-um@lists.infradead.org, 	virtualization@lists.linux.dev,
 netfilter-devel@vger.kernel.org, 	coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 07:55:29 +0200
In-Reply-To: <CAHv8Y_4OKdVkigToBmXXhhUxu+EL2iWVADZJ=LS4CGqBATgU5g@mail.gmail.com> (sfid-20260922_074449_202856_128C51A3)
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
	 <20260922030310.8684-2-habte.yibelo@gmail.com>
	 <20260922005353-mutt-send-email-mst@kernel.org>
	 <CAHv8Y_4OKdVkigToBmXXhhUxu+EL2iWVADZJ=LS4CGqBATgU5g@mail.gmail.com>
	 (sfid-20260922_074449_202856_128C51A3)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_065556_383646_115E6912 
X-CRM114-Status: UNSURE (   5.55  )
X-CRM114-Notice: Please train this message.
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

On Tue, 2026-09-22 at 01:44 -0400, Paulos Yibelo wrote:
> If this sounds good to you I can get started on the modifications.
>=20

No it doesn't, go away and don't just keep sending LLM output without
ever even bothering to look at it.

johannes

