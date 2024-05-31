Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80878C25B75
	for <linux-um@archiver.kernel.org>; Fri, 31 May 2024 09:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V7TiTdx/nEWXXgHHbHN78B+YsjlKDnX0w9LWVG0G2x4=; b=Yvcj9RKp5Zsa1xxN96TG+h3Ee1
	8rVlWECKSPkZ/C1JyQ25UKpxweYvZCuhUGnzCVBVqXuFEN4A2itZOfIsFSyXiR9iwOKUe1PfkhRoy
	hlI8jFaH8tn0CoLUZln3DTTYQbIwSsge91AtmUlvrMPDycCX5irXgPP+caX5UbV7zlUW4hczuWSGq
	69SqyNZhohvtG2qtcaf44RiApX7zG8ry98ulmZAcOYBTykkCgkxjnhIxCjnQgh89VDRRmVJnF9B1V
	WMbOYKFjsyiYC6N4GUQVcqrCGmBFBOCVEs15dMYwZ0a0AkdayJPFDuitE+TvNnQgmHw53bRxzTqk/
	t6QBHJcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCyG1-00000009k7a-08Xz;
	Fri, 31 May 2024 09:09:05 +0000
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCyFy-00000009k6Q-0kGE
	for linux-um@lists.infradead.org;
	Fri, 31 May 2024 09:09:03 +0000
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-25076dde95eso532007fac.0
        for <linux-um@lists.infradead.org>; Fri, 31 May 2024 02:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717146540; x=1717751340; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7TiTdx/nEWXXgHHbHN78B+YsjlKDnX0w9LWVG0G2x4=;
        b=DgbNtpARljMWu/4iiPPZzIobFDhSiPo+B7H8ygSIGALUnCdEBMmbh0ePaars/rZgQ/
         lDb78+iv5n00TsCyBS62cZ9SopKbvvw0dIgcSqO+jeEY+tWmTZsLC4apvbXxgCvMbTcB
         PIHEz6cU2eVnhYBHhgMenkWKnNGo5fU9j84lyBkINqIkxf4wiop69AHL8aOJxOr0CiWR
         /a58dzAuIMCL8ewVeWHMTJIaYFzktD0dt6ZgRVUMS719A6mb2PVn5N+CQpUEc4E/Mp9D
         rIo2iPqLYJI2Ne/bwJsFDwFWLFL2JYkt2q5611i0OsRL7pirPnJpDuKER85ExuYxeHEs
         x65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717146540; x=1717751340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7TiTdx/nEWXXgHHbHN78B+YsjlKDnX0w9LWVG0G2x4=;
        b=YdtI+4lKFDjMd8o/u8hgs+R8mIf3YH2hJAxO7xNgYMqwW/wQ7dkzJAtja+Tv2i+Ru+
         eARbeK0JrWMGS779plkptYFklxZevhyc0x5BrtGhxi3vCDgrqSsEs+n7MqD8oqVf4cpP
         c7WqvR6i+hlTg7TlWdy6VtJRTuLYrrkOtPExmfs9CWVDE6MlwLla91OingwffD7fgJdk
         Sys/mAG68EedD/tATRyxCkA22ti1lPaGmOxBttBeOXm77JGj0q1tfAwZxZtr7gaSNk8n
         6e0Q+Xmf1nCQwaNge23l0FJ5KcKXHsE8AfRfI8JSGTpqTmxMF2ghrgLqnbJWU0Uxysnm
         WVKg==
X-Forwarded-Encrypted: i=1; AJvYcCXtptWBs/oNguz5DWuNtB6O8AYzFi0wEM0DX5FketJYicYu1VnqMOzVAltSSIycHsg+ZBuCYaP4mUGlxaMLnaBt39PSu2E9IKXqDAcR
X-Gm-Message-State: AOJu0YwZu4VmQO8bk3R4j5ym8SN3hTNHBnzlTCBcISIh5Xe+JR9xXJak
	V6V3kAXdE7vrwfp8n+eJnMFtbYhw0zLsgqEWy4PLbV2MvO4DkcMY+5In1UxgfdNgX1VMfZLzUhC
	u9V+Buk+CbGh53fvStaX8PxBRlcM=
X-Google-Smtp-Source: AGHT+IHoKiJiwn0RUfGlBR1LOXIQjJEAP/TieA174CPldpRPuDqgZrspO+vxp9UsllxKnQz9RUjusbGg9aknaFlS5Ec=
X-Received: by 2002:a05:6870:9346:b0:250:6422:86a with SMTP id
 586e51a60fabf-25065b70997mr1985845fac.10.1717146540364; Fri, 31 May 2024
 02:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240531074837.1648501-1-hch@lst.de> <20240531074837.1648501-4-hch@lst.de>
In-Reply-To: <20240531074837.1648501-4-hch@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 31 May 2024 11:08:48 +0200
Message-ID: <CAOi1vP_mY-a7aiWod-eVz8xuhGz4mHBBoZZgr2FoxS5wVUym3w@mail.gmail.com>
Subject: Re: [PATCH 03/14] rbd: increase io_opt again
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Josef Bacik <josef@toxicpanda.com>, 
	Dongsheng Yang <dongsheng.yang@easystack.cn>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, 
	nbd@other.debian.org, ceph-devel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_020902_247365_0FEA2767 
X-CRM114-Status: GOOD (  20.06  )
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

On Fri, May 31, 2024 at 9:48=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Commit 16d80c54ad42 ("rbd: set io_min, io_opt and discard_granularity to
> alloc_size") lowered the io_opt size for rbd from objset_bytes which is
> 4MB for typical setup to alloc_size which is typically 64KB.
>
> The commit mostly talks about discard behavior and does mention io_min
> in passing.  Reducing io_opt means reducing the readahead size, which
> seems counter-intuitive given that rbd currently abuses the user
> max_sectors setting to actually increase the I/O size.  Switch back
> to the old setting to allow larger reads (the readahead size despite it's
> name actually limits the size of any buffered read) and to prepare
> for using io_opt in the max_sectors calculation and getting drivers out
> of the business of overriding the max_user_sectors value.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/rbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 26ff5cd2bf0abc..46dc487ccc17eb 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4955,8 +4955,8 @@ static int rbd_init_disk(struct rbd_device *rbd_dev=
)
>         struct queue_limits lim =3D {
>                 .max_hw_sectors         =3D objset_bytes >> SECTOR_SHIFT,
>                 .max_user_sectors       =3D objset_bytes >> SECTOR_SHIFT,
> +               .io_opt                 =3D objset_bytes,
>                 .io_min                 =3D rbd_dev->opts->alloc_size,
> -               .io_opt                 =3D rbd_dev->opts->alloc_size,
>                 .max_segments           =3D USHRT_MAX,
>                 .max_segment_size       =3D UINT_MAX,
>         };
> --
> 2.43.0
>

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya

