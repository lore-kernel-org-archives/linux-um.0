Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CE0C4345F
	for <linux-um@archiver.kernel.org>; Tue, 30 Apr 2024 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZlNg2E7HzzVpYohrQU0ErPYfD/rZVQz7EH6IqJ25n1k=; b=hOl65R6uhnLU2gJ3eECo1wVS/w
	SBo4drgPVfgCQWGl6wJk3N2UFqpbtX2aPh3ASmhVHzPgLLtnlPGB9ck2eLSJ9RADoa+l5hpF8Elm3
	zxTTJ+zleBiy44tTRFfB2602uYa7tFSTFIK+gLEJidqttt+Hzf3W39W4oFwZVnXnesB6/UDj5HSwm
	VkRX5lGQPp3Zo5VdYGP3PZAAae5SerY3OpUl4OIBr0A/MTtdFEIducplOZ1csUG3LIst1b1END1q0
	rTnVW8GNMCVwkD8CYkc8ezaR1Pd3sbHSC24qRkbhy1qMHVGEHOqRd7WLhsVmE1O8ldeU1zHlJCI59
	5nSeeGXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1mRJ-00000006Jhe-11Ym;
	Tue, 30 Apr 2024 12:18:29 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1mRF-00000006JfV-2t0j
	for linux-um@lists.infradead.org;
	Tue, 30 Apr 2024 12:18:27 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C289163D93A2;
	Tue, 30 Apr 2024 14:18:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id apI3nyhC16qi; Tue, 30 Apr 2024 14:18:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2339863D93A1;
	Tue, 30 Apr 2024 14:18:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FxmsUBDv3t29; Tue, 30 Apr 2024 14:18:14 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id EC964647A819;
	Tue, 30 Apr 2024 14:18:13 +0200 (CEST)
Date: Tue, 30 Apr 2024 14:18:13 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	kernel <kernel@pengutronix.de>
Message-ID: <1268129847.49378.1714479493850.JavaMail.zimbra@nod.at>
In-Reply-To: <4bxrtz7jnavmzplkiwzpq62omswpfbogd2pep7ju4jlbum6ccr@xbegqcpfmnf2>
References: <cover.1710056894.git.u.kleine-koenig@pengutronix.de> <4bxrtz7jnavmzplkiwzpq62omswpfbogd2pep7ju4jlbum6ccr@xbegqcpfmnf2>
Subject: Re: [PATCH 0/2] um: Convert to platform remove callback returning
 void
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Convert to platform remove callback returning void
Thread-Index: rvlB922sg11/dDIg8b6HXSbkqYYW0A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240430_051825_893665_99CDEBF3 
X-CRM114-Status: UNSURE (   8.38  )
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

Uwe,

----- Urspr=C3=BCngliche Mail -----
> Von: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>
> CC: "linux-um" <linux-um@lists.infradead.org>, "kernel" <kernel@pengutron=
ix.de>
> Gesendet: Montag, 29. April 2024 09:35:49
> Betreff: Re: [PATCH 0/2] um: Convert to platform remove callback returnin=
g void

> Hello Richard,
>=20
> On Sun, Mar 10, 2024 at 08:52:26AM +0100, Uwe Kleine-K=C3=B6nig wrote:
>> this series converts all platform drivers below arch/um to stop using
>> struct platform_driver::remove(). See commit 5c5a7680e67b ("platform:
>> Provide a remove callback that returns no value") for an extended
>> explanation and the eventual goal.
>>=20
>> Both conversations are trivial, because the driver's .remove() callbacks
>> returned zero unconditionally.
>>=20
>> There are no interdependencies between these patches, still I'd expect
>> them to be picked up together.
>=20
> I intend to send the change to struct platform_driver::remove() to Greg
> soon after the upcoming merge window closed. It would be great if these
> patches made it in before. If not, I'll ask Greg to apply these patches
> together with the change to platform_driver::remove(). If that's your
> preferred resolution, feel free to send an Ack for that.

I've applied them and will appear soon in -next.

Thanks,
//richard

