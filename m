Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94700C5DF94
	for <linux-um@archiver.kernel.org>; Mon, 24 Aug 2026 14:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HesIIA5t8gsnUSv4wqfVndklpG//1dx3Rdk/w4jri3c=; b=THR0wtTEIeKHPPb6kSsTiPTFuE
	B4JfOBpVlf+fkmPvQLERPEpzOLVOBXITxAimduK4L1TJKA5kqH17OdnHWVdIxsDKVXazYwyuwTMbD
	ES+p5QMwHmldwFbj/pBTKXQZupRM01xqHLZ1tDccGNXuwXT6Wfl/lhbUiFsPbaMh5Eua0KpWkIC+t
	pEb8PlyEa2EFDfb1xpXWdPr/7sz6di7xr4LbLRpxdjk003/Br9ZNDQRl8d8/vBZ0t9KpgkO53IRXK
	yV7feaKYZFav+rjw4rAE4G+qOfwV9uXBLX50ty+TFYJfn5aEYAdpbnPQWmcUB549yZ7IYUKfBZpOc
	ALHXhWOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyVf5-0000000Gmyi-0SR8;
	Mon, 24 Aug 2026 14:28:31 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyVf0-0000000Gmwe-3vPR
	for linux-um@lists.infradead.org;
	Mon, 24 Aug 2026 14:28:29 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 87E45100D04;
	Mon, 24 Aug 2026 16:28:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id T4tmBHccRicX; Mon, 24 Aug 2026 16:28:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id AEE591A8CE4;
	Mon, 24 Aug 2026 16:28:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0JMMrpWcnDJK; Mon, 24 Aug 2026 16:28:14 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 36E2F298569;
	Mon, 24 Aug 2026 16:28:14 +0200 (CEST)
Date: Mon, 24 Aug 2026 16:28:13 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: bp <bp@alien8.de>
Cc: Fabian Franz <fabian@isomorphic-ai.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Nikolay Borisov <nik.borisov@suse.com>, 
	"Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>, 
	Claude Fable 5 <noreply@anthropic.com>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	regressions <regressions@lists.linux.dev>
Message-ID: <2060717447.2694.1787581693960.JavaMail.zimbra@nod.at>
In-Reply-To: <20260824142048.GBaoxTQKUUtmflxuyB@fat_crate.local>
References: <20260823201521.2576344-1-fabian@isomorphic-ai.com> <a02b160a-874f-491c-987b-4d7eb0d35a9f@leemhuis.info> <20260824092300-3e9a9d58-b273-421b-a4bf-5609ccb9ab49@linutronix.de> <CAKbYdNEK0TUy+W5g_yGuP-JCC9CQwmeO0q95rYhcebZYB9vLUw@mail.gmail.com> <20260824142048.GBaoxTQKUUtmflxuyB@fat_crate.local>
Subject: Re: [PATCH REGRESSION] um: Fix cpu_feature_enabled() build breakage
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF153 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix cpu_feature_enabled() build breakage
Thread-Index: VSL7nbNuM0bzsbTKs+Cto7cnhTuI5A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_072827_130048_84A1C4C4 
X-CRM114-Status: UNSURE (   3.23  )
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

----- Urspr=C3=BCngliche Mail -----
> Von: "bp" <bp@alien8.de>
>> However, getting the minimal patch for um in ASAP would also be good,
>> as a broken master is not nice for development.
>=20
> It happens during the merge window.

Agreed. Nobody got hurt. All hamsters still alive.

>=20
> UML folks, you wanna take Thomas' patch or should I route it through tip?

If you don't mind, please carry it through tip.

Thanks,
//richard

