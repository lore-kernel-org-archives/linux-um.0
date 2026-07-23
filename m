Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D194C531D4
	for <linux-um@archiver.kernel.org>; Thu, 23 Jul 2026 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6nUgZ+uwgodCms98P3H9HWguo7obuUmfqnEfEb3EMhE=; b=QskdrI3RvHGVweGVTCj8lnGWKj
	LyssF1rTaaXF7RDp9Sm4/L7qmeddWd9xzUYnbU2B8jVF/lNs230DkQ2kmF+RIn7sVWfOevy8RRKz4
	9QahVWKr+8ISvb5P9rJ6YswIdiA6WBxf7fJIoetW/0QvDoMo4FS10pRb0ovw200mIO/f0oBlKxaPR
	3KH+rO4TYmRQnXM27sO1JqC7fFLti3saKBfTahNfdG0FJfTqfvOdXCATLikvkNkCM2JtGgAjhh1gm
	Zvrkyhk33oaLH51DbDZ79CqXcQ4SEuA/aFKt47BxI6UTqV/dhkS07Hh2p8X62LJZipi9sBhph1s09
	6Xv0KVBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmtxp-0000000ERTE-2TTz;
	Thu, 23 Jul 2026 13:59:53 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmtxn-0000000ERSV-13m6
	for linux-um@lists.infradead.org;
	Thu, 23 Jul 2026 13:59:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6nUgZ+uwgodCms98P3H9HWguo7obuUmfqnEfEb3EMhE=;
	t=1784815191; x=1786024791; b=FxSa8EYrVKsQNoUbVjLoryyDuGoTUoHb8YX7upRgZI+9Ee0
	8nKRIMWXYgPbdLErizqV42Ub1ox3aQmmEjrlX6O3aHyT5ALLEVMUAwo8z6R4+xsG5Qy7I2H7Nac/9
	sBVXFfTwVhMMgnGbTruTdR5nSbygyW9JgY1sp1PCubjcu/cl0pmqiZk3DZq1kzY+7FGDIT+LDHXaC
	RvgxXBdawox0aLc7QdkCke6PgBVNPim3RK7+odhRgm601bTkfB3PtLToVsRWOUMhpOiTe+nKmn1a8
	Xpzm9Noe4lNeBLqCNkWf5rvwku4jzpCMbe11KcSHPyOd5GEd6dc+O/Ni6mbjdqWQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmtxh-0000000CYEF-2ytB;
	Thu, 23 Jul 2026 15:59:46 +0200
Message-ID: <879d8f814fdd5291dc2e5570acd4c29fa3c87390.camel@sipsolutions.net>
Subject: Re: [PATCH v2 08/10] um: nommu: add userspace runner processes
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>, liam@infradead.org, ljs@kernel.org,
  Ricardo Koller <ricarkol@google.com>
Date: Thu, 23 Jul 2026 15:59:44 +0200
In-Reply-To: <20260723113633.2184dce9413e.I9f810f3ed177d6dc980cad36c231f8c745dee48f@changeid>
References: <20260723093633.140989-12-johannes@sipsolutions.net>
	 <20260723113633.2184dce9413e.I9f810f3ed177d6dc980cad36c231f8c745dee48f@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_065951_290801_28959067 
X-CRM114-Status: GOOD (  10.87  )
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

On Thu, 2026-07-23 at 11:35 +0200, Johannes Berg wrote:
>=20
> +struct mutex *__get_turnstile(struct mm_id *mm_id)
> +{
> +	return &container_of(mm_id, struct nommu_runner, mm_id)->turnstile;
> +}
> +
> +void enter_turnstile(struct mm_id *mm_id)
> +{
> +	mutex_lock(__get_turnstile(mm_id));
> +}
> +
> +void exit_turnstile(struct mm_id *mm_id)
> +{
> +	mutex_unlock(__get_turnstile(mm_id));
> +}

I should comment on this - it really shouldn't be necessary here, and
the mutex should never be contended. Also, __get_turnstile() is only
needed for context tracking, so I'm not even sure it matters what it
returns (I don't fully understand the clang context tracking).

I was tempted to make the mutex_lock() something like

	if (WARN_ON(!try_mutex_lock()))
		mutex_lock();

but eventually decided to just keep it. I think we'll probably want to
remove the whole turnstile business entirely anyway, and have real SMP
for userspace threads. In fact I started prototyping this as well, but
didn't have time to finish it yet.

So all this really is a bit of just fluff right now and hopefully will
eventually go away.

johannes

