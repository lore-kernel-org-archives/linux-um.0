Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FC0C47073
	for <linux-um@archiver.kernel.org>; Fri,  5 Jan 2024 00:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AMhyMtdv7vfgDVMMzdQpRo6XibttV5UhqpDcQLmQbis=; b=BWCJxEyPSvgBXwUUZzr68mUhb9
	6ClRE7AbkBk04oUm5QIow5FQG/RPkDDmKcw64WxMuv5xdydeBmS0EFn4MH1NLZ1qLQvPNiOBU/0bW
	9KvsA+QpeV6jKlsNEbl8kWzHOFke9WfRsnuzlfAhR6U+qgi4Dlf51W/44L3GyUJzivI7WIhdSCvxJ
	9qp/ZVAFj3sUgcb1qNwUEXNDfc1UJarnQlUJMUYMugJWu1yHjM0WPbe+FFL5zBXR9Kh/giNDphHwc
	3LPhKR5VBnOAJ1oMLgNiiqtnYd3p4niTvmR4+v4UMAsAIUgGllTT1h4aTe70Oyuqtz9XUJrOTRyhV
	fwRPv7Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLY6x-00FeOJ-0U;
	Fri, 05 Jan 2024 00:30:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLX37-00FUJW-12
	for linux-um@bombadil.infradead.org;
	Thu, 04 Jan 2024 23:22:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=AMhyMtdv7vfgDVMMzdQpRo6XibttV5UhqpDcQLmQbis=; b=CrBQ8/af2zxcpRkLocH5KoqISv
	fdhZDs9fjAH6G3t0RTEFD5WM03ygVVeBFefGbjB3bw2+UWx3KUD2XjDitTrzft9cyZnsUxirb10/S
	kuliud8kHne52fGFlDUEQ9zEqnh1Lth3mcxgoO9qGR145whlqK8T2povK0d2XIoK9+pg0z5rxLyQO
	tVNx9qxwMmC09yXEjf/z0SqFfXfvNbRwasxVJRJpfCCvvQDsRUGWllQai4SLFdwrc/oF9cxOewgUr
	D02GG5CdWoYQdVvGkXNZkWD26MPsKIQLwvZS0EnHO1Frt11tv48SN1W1KhahNyOKsaaoUhJgT9Pq6
	XRLTsozA==;
Received: from lithops.sigma-star.at ([195.201.40.130])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLX2v-0069hU-1h
	for linux-um@lists.infradead.org;
	Thu, 04 Jan 2024 23:22:43 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id DA17D626FAE6;
	Fri,  5 Jan 2024 00:22:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id yD_ZKLh5XoAP; Fri,  5 Jan 2024 00:22:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7780F626FB00;
	Fri,  5 Jan 2024 00:22:11 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VpwcTByJ0DTB; Fri,  5 Jan 2024 00:22:11 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 550FF626FAE6;
	Fri,  5 Jan 2024 00:22:11 +0100 (CET)
Date: Fri, 5 Jan 2024 00:22:11 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz, 
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Message-ID: <435201914.200552.1704410531143.JavaMail.zimbra@nod.at>
In-Reply-To: <20231215121431.680-1-petrtesarik@huaweicloud.com>
References: <20231215121431.680-1-petrtesarik@huaweicloud.com>
Subject: Re: [PATCH 0/2] um: improve UML page fault handling
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: improve UML page fault handling
Thread-Index: 3x5bOAmY5/XfwxP9N8Jncq5xgr1IZw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_232241_757912_D4C83E48 
X-CRM114-Status: UNSURE (   7.17  )
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
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>, "linux-um" <linux-um@lists.infradead.org>, "=
linux-kernel" <linux-kernel@vger.kernel.org>
> CC: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, petr@tesarici.cz, "P=
etr Tesarik"
> <petr.tesarik1@huawei-partners.com>
> Gesendet: Freitag, 15. Dezember 2023 13:14:29
> Betreff: [PATCH 0/2] um: improve UML page fault handling

> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
>=20
> Improve UML handling of segmentation faults in kernel mode. Although
> such page faults are generally caused by a kernel bug, it is annoying
> if they cause an infinite loop, or panic the kernel. More importantly,
> a robust implementation allows to write KUnit tests for various guard
> pages, preventing potential kernel self-protection regressions.
>=20
> Petr Tesarik (2):
>  um: do not panic on kernel mode faults
>  um: oops on accessing an non-present page in the vmalloc area

I think this is a good thing to have.
For the implementation side, this needs to use the oops_* helpers
from kernel/panic.c and taint the kernel, etc...
See arch/x86/kernel/dumpstack.c die() and friends.

Thanks,
//richard

