Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BF6C4345F
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 08:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PMfy89R+1zueDcez+T8fuS2gCg5z0xhHRL2bNInR0Ew=; b=fa7hr6bI8kXNh5KXytucU8b2Fq
	qvCPML+p9N+v1tzSLe3Gj7uyWbEsqYJ3wdUbqJdT9EXx/jZKT2NnkSuWTQgUTxle0TlePez9zvzpy
	NlNZT84sPjXTw2bTjU0batf69NZRGc1WtdDInD/maMs0SumGE9lSgtoffj+ILyzbBCvaUySCXJezT
	jNE9w6No6QTWOmLZa+ueEJXEA4Fb+FX6UDqDoOLwmDMXAHV2VEbHXvgn8uLjE7oYJpQdhtFta5m7J
	vngfMnKx4rYpy2pUfzC8tQudGW3PaVXWljqIMIPZObmm+sHCQtJXuSv54e0Fm7UlwzZgZJoLutaQS
	J4ky3D5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzBF9-0000000GPtv-42eg;
	Tue, 23 Apr 2024 08:11:12 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzBF6-0000000GPsL-2pcx
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 08:11:10 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8F901647A83B;
	Tue, 23 Apr 2024 10:11:04 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id gstg3scYW05B; Tue, 23 Apr 2024 10:11:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D933C647A83E;
	Tue, 23 Apr 2024 10:11:03 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gvF2eYIkDevt; Tue, 23 Apr 2024 10:11:03 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id ACD99647A81C;
	Tue, 23 Apr 2024 10:11:03 +0200 (CEST)
Date: Tue, 23 Apr 2024 10:11:03 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <539232323.17201.1713859863502.JavaMail.zimbra@nod.at>
In-Reply-To: <15d5da65079d072856ef5e8d88040df2095bb6b7.camel@huaweicloud.com>
References: <20240307104926.3531358-1-roberto.sassu@huaweicloud.com> <1743ad022502d64042fa7db4d847a988bb90cbdc.camel@sipsolutions.net> <15d5da65079d072856ef5e8d88040df2095bb6b7.camel@huaweicloud.com>
Subject: Re: [PATCH] um: Add winch to winch_handlers before registering
 winch IRQ
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Add winch to winch_handlers before registering winch IRQ
Thread-Index: qqHtS+MauW85VnvROeFWmuL67kgQcQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_011108_879836_6D2C25BC 
X-CRM114-Status: UNSURE (   7.73  )
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
> Von: "Roberto Sassu" <roberto.sassu@huaweicloud.com>
> An: "Johannes Berg" <johannes@sipsolutions.net>, "richard" <richard@nod.a=
t>, "anton ivanov"
> <anton.ivanov@cambridgegreys.com>
> CC: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-um" <linux-um@l=
ists.infradead.org>, "Roberto Sassu"
> <roberto.sassu@huawei.com>
> Gesendet: Dienstag, 23. April 2024 09:22:31
> Betreff: Re: [PATCH] um: Add winch to winch_handlers before registering w=
inch IRQ

> On Thu, 2024-03-28 at 09:25 +0100, Johannes Berg wrote:
>> On Thu, 2024-03-07 at 11:49 +0100, Roberto Sassu wrote:
>> > From: Roberto Sassu <roberto.sassu@huawei.com>
>> >=20
>> > Registering a winch IRQ is racy, an interrupt may occur before the win=
ch is
>> > added to the winch_handlers list.
>> >=20
>> > If that happens, register_winch_irq() adds to that list a winch that i=
s
>> > scheduled to be (or has already been) freed, causing a panic later in
>> > winch_cleanup().
>> >=20
>> > Avoid the race by adding the winch to the winch_handlers list before
>> > registering the IRQ, and rolling back if um_request_irq() fails.
>> >=20
>>=20
>> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
>=20
> Thank you! Richard, are you going to pick this up?

Yes, it's already in my local queue.

Thanks,
//richard

