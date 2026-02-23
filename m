Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82F6EEC296
	for <linux-um@archiver.kernel.org>; Mon, 23 Feb 2026 21:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=23EdARInHQbn9UQZ4Ze1RUj9umLs+AsB6ZkBrB7Nyg8=; b=OVh/m5zB+UW2RjD40u6rVBhR6T
	S+565dz/OoApdLjXrpcU/7k8OGmCoHzKUNY8dEsQ6nGOmtCdCPN8VtH1ZeGAIMKJNaDsJbJAULPk5
	ZS6tVvALpb9EBQVx0jOb6zVCbGZWaeD7OC1dwGoW4W9aDLDtRZ9yydovMzs9jXs68zORTYQlBWr6Y
	bE8cjYF4jLcLE1K+gFa8Lcmf/oEtjtGmvojFy+c7L++kyBCr/9IB5tTOiavoxZd6xBhbS29Foskdm
	eh+gCSkW23G6x6Ibx6DI4IDSFkTH+T6W4hWc8x9kVPr50mnx+7t0GGDlrHMSCSqCnsf1v5NN7SFGt
	0TpvTLkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vudrc-000000014yF-29Y2;
	Mon, 23 Feb 2026 21:53:12 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vudrZ-000000014xn-2ugV
	for linux-um@lists.infradead.org;
	Mon, 23 Feb 2026 21:53:11 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 08D87244B24;
	Mon, 23 Feb 2026 22:52:57 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id T9J9XODYy7yM; Mon, 23 Feb 2026 22:52:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B31AA244B26;
	Mon, 23 Feb 2026 22:52:55 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Wy8rytRbA5QY; Mon, 23 Feb 2026 22:52:55 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4DAC5244B24;
	Mon, 23 Feb 2026 22:52:55 +0100 (CET)
Date: Mon, 23 Feb 2026 22:52:54 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	Tiwei Bie <tiwei.btw@antgroup.com>, 
	linux-um <linux-um@lists.infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-hardening <linux-hardening@vger.kernel.org>
Message-ID: <905832921.1560.1771883574809.JavaMail.zimbra@nod.at>
In-Reply-To: <20260223214341.work.846-kees@kernel.org>
References: <20260223214341.work.846-kees@kernel.org>
Subject: Re: [PATCH] ubd: Use pointer-to-pointers for io_thread_req arrays
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF147 (Linux)/8.8.12_GA_3809)
Thread-Topic: Use pointer-to-pointers for io_thread_req arrays
Thread-Index: G+WYJ58A7oYNOlTL/FXMTchaZRbPMg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_135309_926620_A303FFDE 
X-CRM114-Status: UNSURE (   8.53  )
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
> Von: "Kees Cook" <kees@kernel.org>
> An: "richard" <richard@nod.at>
> CC: "Kees Cook" <kees@kernel.org>, "Nathan Chancellor" <nathan@kernel.org=
>, "Guenter Roeck" <linux@roeck-us.net>, "anton
> ivanov" <anton.ivanov@cambridgegreys.com>, "Johannes Berg" <johannes@sips=
olutions.net>, "Jens Axboe" <axboe@kernel.dk>,
> "Hannes Reinecke" <hare@suse.de>, "Martin K. Petersen" <martin.petersen@o=
racle.com>, "Tiwei Bie"
> <tiwei.btw@antgroup.com>, "linux-um" <linux-um@lists.infradead.org>, "Al =
Viro" <viro@zeniv.linux.org.uk>,
> "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-hardening" <linux-h=
ardening@vger.kernel.org>
> Gesendet: Montag, 23. Februar 2026 22:43:45
> Betreff: [PATCH] ubd: Use pointer-to-pointers for io_thread_req arrays

> Having an unbounded array for irq_req_buffer and io_req_buffer doesn't
> provide any bounds safety, and confuses the needed allocation type,
> which is returning a pointer to pointers. Instead of the implicit cast,
> switch the variable types.
>=20
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes:
> https://lore.kernel.org/all/b04b6c13-7d0e-4a89-9e68-b572b6c686ac@roeck-us=
.net
> Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-=
scalar
> types")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Tiwei Bie <tiwei.btw@antgroup.com>
> Cc: <linux-um@lists.infradead.org>
> ---
> arch/um/drivers/ubd_kern.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

