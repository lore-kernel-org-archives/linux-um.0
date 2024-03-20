Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C0EC6FD1F
	for <linux-um@archiver.kernel.org>; Wed, 20 Mar 2024 14:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cUeoLhqhxAO/gfIfl0ulk6l/PXX+VNYlpSZYXY02GiY=; b=ZCRd1W2bTuCfYjqFkYjtuelPYV
	x68L1wBjPkhw8zQGUus05+CYMAzhyheNh0KAYcvBtSgz9q0gtg1x4LXekjr4AkLpI16SuSLT4VS9h
	mw4BS4iTeTvUroOhnX/kn4aoLcLZ15m596Uv/UZLi82XokrYqgn9oopLV35ehpc1j2JEItiqjyVni
	AczuvmEvdFB7byUmrdVtc0sVImTeKDVzPDZTHqLwZVry3Sw3890zvooNeGUGbn/x8yNDi5ZGMNwlE
	HhPJlo0s+jQpqoQ3G7HjKaRnAghPJAcbnDE+OJahcZ2UgCtEM3cP6r12BicroClRen+FxxN7bFdWu
	4A8jLlnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmwdV-0000000HNac-0ifZ;
	Wed, 20 Mar 2024 14:09:45 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmwdS-0000000HNXx-0cAP
	for linux-um@lists.infradead.org;
	Wed, 20 Mar 2024 14:09:43 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A464A6451633;
	Wed, 20 Mar 2024 15:09:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ZShp3J1YnL-t; Wed, 20 Mar 2024 15:09:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1E08D6451635;
	Wed, 20 Mar 2024 15:09:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6KDg9rbOOcsf; Wed, 20 Mar 2024 15:09:38 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id ED774645162C;
	Wed, 20 Mar 2024 15:09:37 +0100 (CET)
Date: Wed, 20 Mar 2024 15:09:37 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	petr <petr@tesarici.cz>
Message-ID: <156343757.79841.1710943777684.JavaMail.zimbra@nod.at>
In-Reply-To: <6a62f534-463f-45c4-a5ea-2c1021cf45d4@huaweicloud.com>
References: <20240223140435.1240-1-petrtesarik@huaweicloud.com> <9284cda7-d7e3-4390-bf62-58092e97d1c8@huaweicloud.com> <8d45f94c-bce1-4327-9573-cec254a4e9c3@huaweicloud.com> <1418379493.78340.1710886685735.JavaMail.zimbra@nod.at> <6a62f534-463f-45c4-a5ea-2c1021cf45d4@huaweicloud.com>
Subject: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page in
 the vmalloc area
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: oops on accessing a non-present page in the vmalloc area
Thread-Index: pOp1mjFQTnV9/3sqj8nu+xKmKml6Lw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_070942_352328_6181DD02 
X-CRM114-Status: UNSURE (   3.41  )
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
> Von: "Petr Tesarik" <petrtesarik@huaweicloud.com>
>> Yes. I'm just way behind my maintainer schedule. :-/
>=20
> Understood. Thank you for your reply.
>=20
> By the way, are you looking for more people to help with the amount of wo=
rk?

Yes, help is always welcome!
Johannes and Anton do already a great job but more maintenance power is alw=
ays good.
You could help with reviewing patches, testing stuff, etc. :-)
It's not that UML itself is a lot of work, it's just that $dayjob is not UM=
L related at all...

Thanks,
//richard

