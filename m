Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8264AC44536
	for <linux-um@archiver.kernel.org>; Wed, 22 Jul 2026 14:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5n/1lHgYumypq0tDRKtD2mnMhu28osAZ8FForf8ddW4=; b=UmFD9K785LtlNZmHgQ69z20vcB
	RpW8fAFRDab8A7eF9jof2M1+Mm6R09EP6I81QIA1CbutAPgrxhrmTp0Mx0BmEjxlkZkLE/HnO8p5f
	mgNEooLOwMaOX7vmM7nHbINL5XLLdOFlFlRmQK3wa2SsCi0/tkvXIsP9glEQ7o909U6l9zrpKatTP
	g5tWYckvjF7oU/fHED/6LF4KCZA9jOc+4Fy8AS25NeYewnL3ML38abEWNIzC+qD2iMCv4SIv6g262
	02H6hZkzlxlg5EDgyGAqr3Eo2TzWdESuz+FQAQpyVjv1JX4UWMLijxF+tiTlQsE0wAs5nFlQg4fjT
	Cx+xbVgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmYGE-0000000C4xO-2hAS;
	Wed, 22 Jul 2026 14:49:26 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmYGB-0000000C4vE-3Ygc
	for linux-um@lists.infradead.org;
	Wed, 22 Jul 2026 14:49:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5n/1lHgYumypq0tDRKtD2mnMhu28osAZ8FForf8ddW4=;
	t=1784731763; x=1785941363; b=D0lRvZUKJyvmuUjQZpqSaQEyaRe1gFs9Wb70i3MOhWawDYg
	tM29CrwR7KKCB0qaer26MZa2bbbOQAn1y0L6Cqgg5oEkA/odOW53blgyk6QOvSuLhk56EsOm59xfz
	LX5EDjCnq3QrP2aR0OCxAS10ydg3Xj6iviwlmtpkXtQeFja58GDV+YWrEKL4BMRcwY2KVYjszF9Bo
	UDHwVPPrg60x5DMKbRaSYJPG5t28EvQmvwXi4RaII+wKvjCeRzKpmMSiRcjG4KcI9GvkBZd2iQNNG
	pajU7HPMyLdexiv9qYHXO6nWP1/513gmhI2m/rY/qbjYHKZWcVVOCCGXYo8x7a0w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmYG1-00000004pEu-0Y1M;
	Wed, 22 Jul 2026 16:49:13 +0200
Message-ID: <6385309c68d6d8a928a01f421b54e1cdf8001c97.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] um: add uml_kmalloc_array() helper to avoid
 potential
From: Johannes Berg <johannes@sipsolutions.net>
To: iamhswang@gmail.com, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	akpm@linux-foundation.org, dave.hansen@linux.intel.com,
 tiwei.btw@antgroup.com, 	rppt@kernel.org, kevin.brodsky@arm.com,
 snovitoll@gmail.com, linux@weissschuh.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 22 Jul 2026 16:49:12 +0200
In-Reply-To: <20260120112938.463596-1-iamhswang@gmail.com> (sfid-20260120_123032_467740_95AB1171)
References: <20260120112938.463596-1-iamhswang@gmail.com>
	 (sfid-20260120_123032_467740_95AB1171)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_074923_887892_B878C704 
X-CRM114-Status: UNSURE (   6.33  )
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

On Tue, 2026-01-20 at 19:28 +0800, iamhswang@gmail.com wrote:
> From: Haisu Wang <iamhswang@gmail.com>
>=20
> Add uml_kmalloc_array to avoid potential dynamic multiplication
> overflow. Since in Documentation/process/deprecated.rst,
> the preferred way is avoid the open-coded arithmetic.

Personally, I think it's kind of pointless because the only two users
have small static arguments ... but if you want to continue with this
then
>=20
> +extern void *uml_kmalloc_array(int count, int size, int flags);

the prototype should probably match better and use size_t, size_t,
unsigned int?

johannes

