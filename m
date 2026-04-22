Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6998EF94CD9
	for <linux-um@archiver.kernel.org>; Wed, 22 Apr 2026 07:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YHNRGC1hGWc6m3ZzcDaW9en/CqZpzjUfDH3bqt0lyZw=; b=vBJVQ5eO3A0XKLF8JGgJZg25N+
	8WJk4RUGLzIJGQwD7d6Y1duXkAozvy+twuDaIFJBObQ0RMtgnUau/NhWjR7FWtgutGRh+NZrtiklh
	3pPZ3QjT8K0Zf33vlZlb1iEl4tK890fET/Fv0Cy0UoHhWoky7HMbpiK5StziwHw4zx26CAdCbPLts
	BAJg0RsvRVMwUPIiccY8GS+kVAMQ5e1TVnVMEMv0/6YY3AhSK9qkD8UoS2v6vDCrsTVhQb4CGU3Fr
	LGbk1jNSfRRbxGsw9wgNdyfIykGuIntytT7xJs1+6IrsYylQ5v7g+0TXScPzSc6aL7sJw7/EklHh1
	pt/XxCvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFRc5-00000009hAT-1lh6;
	Wed, 22 Apr 2026 07:03:09 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFRc2-00000009hA4-3GIV
	for linux-um@lists.infradead.org;
	Wed, 22 Apr 2026 07:03:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YHNRGC1hGWc6m3ZzcDaW9en/CqZpzjUfDH3bqt0lyZw=;
	t=1776841386; x=1778050986; b=wJX1KPQc6S5TmpHv74CjYS8ePA1kWs2754l/HFA8cNMxh+/
	t2IJLZaDzfXl4m7uUUiGhFvmB0HZRxIn+bayT+rl58kKcQA+i9vWYCHPROwENAPbqozqjSMZbzr3C
	sJSQSR4XmDVGhzYM2Yl67UgnIKc/R9ubqJbEwXvxp5IvaoG5d4WqsVeBz2sB/Zs7Kjb7DrqvWzog3
	2K7qLYpUdhQ1ne9nERw3IwuK+Q6eqp8O2N5PcCUpWSCO8MjbYZ5BPeHwz0tavEtUyQA+meSDW70Ua
	dFMWnKOzMXmKuF3GkYK23cauUwdyWBJhAZQvbWljqbZ09NRCUcscEah/u4uQHaMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wFRbx-000000067S7-1ywB;
	Wed, 22 Apr 2026 09:03:01 +0200
Message-ID: <2fd57f98e3149ba56c83994a9181e92a0104cfe3.camel@sipsolutions.net>
Subject: Re: [PATCH] um: vector: fix NULL pointer derefs in queue-less
 transports
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Bommarito <michael.bommarito@gmail.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 22 Apr 2026 09:03:00 +0200
In-Reply-To: <20260410203028.3717914-1-michael.bommarito@gmail.com>
References: <20260410203028.3717914-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_000306_815327_5748DFC1 
X-CRM114-Status: GOOD (  13.15  )
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

Sorry, I didn't pay much attention to this before...

On Fri, 2026-04-10 at 16:30 -0400, Michael Bommarito wrote:
> TAP transport sets neither VECTOR_RX nor VECTOR_TX, so
> vector_net_open() never allocates rx_queue or tx_queue.  HYBRID sets
> VECTOR_RX but not VECTOR_TX, so tx_queue is NULL there too.
>=20
> vector_reset_stats(), vector_poll(), vector_get_ethtool_stats(), and
> vector_get_ringparam() unconditionally deref these queue pointers,
> causing a NULL pointer crash on SMP or with any lock debugging option.
>=20
> Guard all queue pointer accesses with NULL checks.

I see how that fixes the crash, but maybe you could write a few words on
why it's still correct?

> -	spin_lock(&vp->tx_queue->head_lock);
> -	spin_lock(&vp->rx_queue->head_lock);
> +	if (vp->tx_queue)
> +		spin_lock(&vp->tx_queue->head_lock);
> +	if (vp->rx_queue)
> +		spin_lock(&vp->rx_queue->head_lock);
>  	memcpy(tmp_stats, &vp->estats, sizeof(struct vector_estats));

I could imagine for example this memcpy() observing a torn write or
something like that and getting strange results out?

Or is that just not a thing because UML is (still) mostly non-SMP?


Also I think there are related issues that wouldn't show up for a broken
configuration, such as if create_queue() fails to allocate memory and we
get an inconsistency between tx_queue / rx_queue pointers and VECTOR_TX
/ VECTOR_RX flags? Though I'll admit that seems highly unlikely.

johannes

