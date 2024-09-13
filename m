Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A49EEE26C
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 11:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G5YKSbIGGJwZKt+cM7/JwW6cjBjwIdOnTqBvn3WlgtA=; b=C7EJoyyaUEjQS79DvgkHdXcJzy
	WGNJnCBki6xIkkchyrdxQwzFbf/KnVeYCRw5UIGjFCz5SaARAAdPsCONh0b0u39jP8CfsKjMIU72K
	GbPK7JbXLDTJmJh5FlIZcWMmYzcPMZqagcd34E4HYbEd97mXPteCDgoxDErs/E/13wraxi1XBJcVQ
	B7ddUFiN4haUOKO8aXuGQKxwI+HDtFegknb4Wisi5yJx/GhjPGpz5XFUFFNImQjqHt71DzlK5LycD
	0jkBBl7PirFo4xmGu8jEDiBGjfpAYVhQ7U7mZH4k4yNWgkecPXXcqglpwWFvjvSIDXdEnnF09md48
	hxe3bB4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp4lj-0000000FmtN-2o4y;
	Fri, 13 Sep 2024 11:47:19 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp4lg-0000000Fmro-26st
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 11:47:18 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 84EFD63CF3E8;
	Fri, 13 Sep 2024 13:47:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id T_RCQa9ilb3Q; Fri, 13 Sep 2024 13:47:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2B41E63CF3ED;
	Fri, 13 Sep 2024 13:47:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YS5U1ojDjXgU; Fri, 13 Sep 2024 13:47:12 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0BD3763CF3E8;
	Fri, 13 Sep 2024 13:47:12 +0200 (CEST)
Date: Fri, 13 Sep 2024 13:47:11 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um <linux-um@lists.infradead.org>
Message-ID: <1283369340.40411.1726228031802.JavaMail.zimbra@nod.at>
In-Reply-To: <0675ab7f16dc0b8f02e4c162f2e42fb66046feed.camel@sipsolutions.net>
References: <20240830153825.1466691-1-benjamin@sipsolutions.net> <CAFLxGvxPM9x9ay7+7Sv4wwPFKM9keZGfy9C2=5Cbk-_BUf88gQ@mail.gmail.com> <0675ab7f16dc0b8f02e4c162f2e42fb66046feed.camel@sipsolutions.net>
Subject: Re: [PATCH] um: add RCU syscall hack for time-travel
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF130 (Linux)/8.8.12_GA_3809)
Thread-Topic: add RCU syscall hack for time-travel
Thread-Index: ejSoEC4Kf1CC590/URCK/e4YibCzdw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_044716_703367_F23B0438 
X-CRM114-Status: GOOD (  10.84  )
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
> Von: "Benjamin Berg" <benjamin@sipsolutions.net>
>> While I acknowledge that time-travel itself is a beautiful hack, I'd
>> like to keep the hacks
>> to keep it working minimal.
>> So, the problem here is that RCU callbacks never run and just pile up?
>=20
> Yes. A simple example of this is doing a "find /". This will allocate a
> lot of inode information which is only free'ed at a later point.
>=20
>> I wonder why such a situation does not happen in a nohz_full setup on
>> regular systems.
>=20
> Had to search for a bit. But, I think the boot CPU will still have a
> tick even on a NOHZ_FULL setup. see the nohz_full=3D boot parameter.
>=20
> It does look like the RCU code might try to force scheduling (tiny RCU)
> or wake up a worker (tree RCU) in these situations. But neither of
> these attempts is going to fix the situation as there will be no call
> to rcu_sched_clock_irq with time-travel.

Agreed. I think having a house keeping CPU (thread) will not work in
time-travel mode.
Kicking RCU whenever a syscall is executed is okay, the question is,
are there other scenarios where RCU work can pile up and no syscall is
run for a long time? Maybe we need to kick it at other places (page fault h=
andler?)
too.

Thanks,
//richard

