Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F8FC54798
	for <linux-um@archiver.kernel.org>; Thu,  7 Mar 2024 12:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vZrP6YRVW2GHLPRtAaE9DopasK3y6Q45R38RwWpD63A=; b=eRKuS1CTLhsxl55sPT15WP8R7W
	u3tfN/lYbEvedU6hRjCq7UIWjtNkdO/VLFEdjdpGrfeYCTdghZX/LMkPnNt/ZhL+DYrvKlMZJYoFI
	bdm8r/1nEwfgCd2Mqf1q1k1zWUCN+7QBOdHRz5o7mq7iFDMprVRSfw5hXY14lx/dKwYg80l45uaV4
	23mobzUiickO+QLZKtVzHjAy200YIX+a+I1gzrde+WnY9KKLdiAm1TaDPNEYHBydPlH8x6jRUPDeF
	3xh28/KF47Y9rEHfc5wT09Jbj2TuaWT/FM0HXkiIazERzR9M3FuwrVbUCDwFonQ4muasdElJrxKJS
	ruOloR0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riD6Y-00000004bzp-3wap;
	Thu, 07 Mar 2024 12:44:10 +0000
Received: from frasgout13.his.huawei.com ([14.137.139.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riD6V-00000004bwn-3gtB
	for linux-um@lists.infradead.org;
	Thu, 07 Mar 2024 12:44:09 +0000
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Tr7r06Jc3z9v7HR
	for <linux-um@lists.infradead.org>; Thu,  7 Mar 2024 20:28:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 1E0801400D7
	for <linux-um@lists.infradead.org>; Thu,  7 Mar 2024 20:43:52 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBXTBWAtullIlHjAw--.4316S2;
	Thu, 07 Mar 2024 13:43:51 +0100 (CET)
Message-ID: <2d70513e9f84e650ef1ede5a8ae5960a9de782bc.camel@huaweicloud.com>
Subject: Re: [PATCH] um: Add winch to winch_handlers before registering
 winch IRQ
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, Roberto
 Sassu <roberto.sassu@huawei.com>
Date: Thu, 07 Mar 2024 13:43:40 +0100
In-Reply-To: <20240307104926.3531358-1-roberto.sassu@huaweicloud.com>
References: <20240307104926.3531358-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwBXTBWAtullIlHjAw--.4316S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF45Jr4fCF4UAFWDZFW3Awb_yoW8uFW5pF
	WagFnavrWSqa10ganrJa1qyFWxAws7Gr1Uur1kK345ZryUXr9aqF1rGa42qF1DAry7Jr93
	Xr4F9a9xuayDAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr
	1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj5sXFwABsh
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_044408_209481_2F740CD2 
X-CRM114-Status: GOOD (  16.46  )
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

On Thu, 2024-03-07 at 11:49 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Registering a winch IRQ is racy, an interrupt may occur before the winch =
is
> added to the winch_handlers list.
>=20
> If that happens, register_winch_irq() adds to that list a winch that is
> scheduled to be (or has already been) freed, causing a panic later in
> winch_cleanup().
>=20
> Avoid the race by adding the winch to the winch_handlers list before
> registering the IRQ, and rolling back if um_request_irq() fails.
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Fixes: 42a359e31a0e ("uml: SIGIO support cleanup")

I see that before that commit there was the same ordering (list_add()
before um_request_irq()).

Failure from um_request_irq() should not result in executing
winch_interrupt() which could call list_del() itself. Then, it should
be fine to delete the winch in the error path.

Roberto

> ---
>  arch/um/drivers/line.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
> index ffc5cb92fa36..d82bc3fdb86e 100644
> --- a/arch/um/drivers/line.c
> +++ b/arch/um/drivers/line.c
> @@ -676,24 +676,26 @@ void register_winch_irq(int fd, int tty_fd, int pid=
, struct tty_port *port,
>  		goto cleanup;
>  	}
> =20
> -	*winch =3D ((struct winch) { .list  	=3D LIST_HEAD_INIT(winch->list),
> -				   .fd  	=3D fd,
> +	*winch =3D ((struct winch) { .fd  	=3D fd,
>  				   .tty_fd 	=3D tty_fd,
>  				   .pid  	=3D pid,
>  				   .port 	=3D port,
>  				   .stack	=3D stack });
> =20
> +	spin_lock(&winch_handler_lock);
> +	list_add(&winch->list, &winch_handlers);
> +	spin_unlock(&winch_handler_lock);
> +
>  	if (um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt,
>  			   IRQF_SHARED, "winch", winch) < 0) {
>  		printk(KERN_ERR "register_winch_irq - failed to register "
>  		       "IRQ\n");
> +		spin_lock(&winch_handler_lock);
> +		list_del(&winch->list);
> +		spin_unlock(&winch_handler_lock);
>  		goto out_free;
>  	}
> =20
> -	spin_lock(&winch_handler_lock);
> -	list_add(&winch->list, &winch_handlers);
> -	spin_unlock(&winch_handler_lock);
> -
>  	return;
> =20
>   out_free:


