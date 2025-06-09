Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD84C61CE8
	for <linux-um@archiver.kernel.org>; Mon,  9 Jun 2025 18:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Di62zj39Z1xbHT75Mg+bA+4UZmSC8iTw8kT6Ajz3BQ8=; b=b+UCTsD/OifdW8tykhttwCGSTV
	YVm7dcl/vd3AMqiZ4ICqenO7XYh7SQadECtmpsPzeK7GsouMl6v/xLESEHmPduqNGZyN4JfhQRnzU
	XaalE63qFA9uGjhFX39sw3WwrUM7Ojvar57k2JK7F7yZqjPkfwrZgIDx/PjjhmPTHYdZlpxG/Lw33
	4++ksksFRH0Z1W5jo2YAbeOiXuCOUpv+9IRj6iRzO4N9KQEaA9qeWtLjWlynqg9Af5mN0ebyaXMRv
	uTQCoxaBO3Aa46Jgx4aNyvpniKHvV6YjyWhvOTGIa1w/GUg5KS1pLRe1/pscOjZmEeZYsa46GjTYB
	jui43wZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOhSx-00000004vUF-37bq;
	Mon, 09 Jun 2025 18:43:27 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOg6H-00000004mdk-1Ouz
	for linux-um@lists.infradead.org;
	Mon, 09 Jun 2025 17:15:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Di62zj39Z1xbHT75Mg+bA+4UZmSC8iTw8kT6Ajz3BQ8=;
	t=1749489355; x=1750698955; b=UjWOqq0N9Stl7yMyZVfy7ufB82GPQM6jpKxMAqkJcpOpKys
	MZZ2Xh67yOw0hk4ffxVP2Z4UsqegKeFRhtkuqR9KMkCf+0mJKh8baht8Q8GpspRHe48LNIvFoR9qx
	s+mREdthmTpSH61WTrTOYN+R8f9BjoDDpxz5PdodJFs4VTaIyUxjKHwWQZXkJCfUcv23TSUEiaQ+y
	zB2NKCWukViVyewSELlx5V/ma68q+cjU0/JikTnQv0DRoZU8ncvXN7fGH08Oqw/Q2Qk6pP+abIPbb
	lku50doQCX26QJfFa5pTNyZ8XbY49sg7dmla/88yqB2FNN5Oivw3wMdcImZmJGwQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uOg69-0000000EdgS-15nj;
	Mon, 09 Jun 2025 19:15:49 +0200
Message-ID: <370a1b96fb029ef2afe7fcaf4b9daad40804a730.camel@sipsolutions.net>
Subject: Re: [PATCH] um: fix execve stub execution on old host OSs
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, Yonting Lin
	 <linyongting@gmail.com>, development@efficientek.com
Cc: linux-um@lists.infradead.org
Date: Mon, 09 Jun 2025 19:15:47 +0200
In-Reply-To: <6b4428e5ec42c926fcc9b6d2fdb9202fc6e87fe8.camel@sipsolutions.net> (sfid-20250608_203858_438156_E309C860)
References: <20250112140736.1fcb25c3@crass-HP-ZBook-15-G2>
		 <20250607042248.87877-1-linyongting@gmail.com>
		 (sfid-20250607_062301_404489_59405A7C) <6b4428e5ec42c926fcc9b6d2fdb9202fc6e87fe8.camel@sipsolutions.net>
	 (sfid-20250608_203858_438156_E309C860)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_101557_371894_81F6FDE9 
X-CRM114-Status: GOOD (  14.76  )
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

On Sun, 2025-06-08 at 20:38 +0200, Benjamin Berg wrote:
> >=20
> > But my host kernel is 5.4 and fails to compile these pieces of codes be=
cause
> > there is no this syscall in my older kernel.
> >=20
> > I was wondering if you are working on this issue. If not, I will try to=
=20
> > make a draft solution to review.
>=20
> I was not yet aware of that problem. Most likely only the one in
> start_up.c is a problem for you. All the other ones probably pick up
> the correct definition from the Linux tree already.
>=20
> One can probably solve it by moving the code into another file. Or
> maybe by adding an entry for __NR_close_range into common-offests.h and
> using that.

Seems though we might need to add checking for close_range to the
seccomp init though, it's actually (much) newer than seccomp. Or just
not rely on it?

johannes

