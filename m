Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE7DC46CD2
	for <linux-um@archiver.kernel.org>; Tue,  2 Jan 2024 22:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lBOv2jm2vjkJK88t9NbUPVCUIzSLH16o/dGCZ37tOWs=; b=juiLOz6/BIZxWZ6xzNlr9mh+eF
	qWyDasRaUQicJdMP1repdAV+2LgdNkGZOWMtgIWi7snsDa9a5ggsnbbDdT+vxEJ3T5OvRiBlDFooW
	PoPhFNvy2eIgNDiVv85uFuiu6Tp1ClyLzEfOwjzv14gQ10Sdg3JelvlTY779ai5HNy4Yd8xvdvtWb
	K9U1MPeDN0UX1zGdplZ6STLnxuBrpoYoB+MijH7tJAOsTT1rLSmMUVMYRliKdxd7s9QU1UhZdPl7a
	z6BAYhyKGjkGvY+Fz5kVphj9kFkX5h1HyVlEF5PigVcHdZ7Q3WZoafJ54V/2975yATYNFPZ7OgPE0
	bgLNOm3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKn0y-009BTw-1U;
	Tue, 02 Jan 2024 22:13:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKn0u-009BSt-0a
	for linux-um@lists.infradead.org;
	Tue, 02 Jan 2024 22:13:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704233610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBOv2jm2vjkJK88t9NbUPVCUIzSLH16o/dGCZ37tOWs=;
	b=VDPTMf5OxULvpZCYcKScKLu7iVFgJUuUKZS/iwoRBkk401XwjnpVwqPLwtKLQfqAEkG+59
	7UGgUjhPf4S0sN9Jbe2faQKD/Z3gQzoqg4M0nZ8Y8R9fnxRsiGtSwAb1eWyKwpMqWHmnSq
	GxjkqMOjTzasekLMqlNengK5hfHKEAo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-CxtBSZRON5SLptPmRGHpJQ-1; Tue, 02 Jan 2024 17:11:56 -0500
X-MC-Unique: CxtBSZRON5SLptPmRGHpJQ-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5f03e3e39f5so59460417b3.3
        for <linux-um@lists.infradead.org>; Tue, 02 Jan 2024 14:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704233516; x=1704838316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBOv2jm2vjkJK88t9NbUPVCUIzSLH16o/dGCZ37tOWs=;
        b=HnK9TuzekggeJ7pzgAZv6YbPQQ1WEyVdMJON5te46SaNLjF7EkRaz7XD7JTiwCaXnl
         Oqt+dUZ1zLdtjTrIYFIodoOVdBZuMV4+BO2AN/pdUeyWSboFmUyUCIYgq3GKR8xXCZZ1
         nEgQNzOnmTWoKXcniGyvb8XiK0bfha/JZBUdDg9MKXYFQcWohsuNOqxMfUuo52w6Ng/l
         wVri49f1nh6KkhY/vz3E/Rrrd3q8k92ydTUCRjcIyBnMZpKsZdu2aoOlNG+kZWy3DKl3
         kETECKh0C0eTD4W/l50jMDsWoQeuEXcAZhGb3vAT2wCfEgRc0FgNEknbGvkHR/q4QPKr
         xaPw==
X-Gm-Message-State: AOJu0YxKPLwGDHZM6FG7RKX7TxXqX4QbP0O9kiAJT2DfdncaJnS7fFUZ
	zz8XnkFr1XpSfs7KlPLbuPpSfY3OS0wYH2Qpy4xhLau8QV8/EDmRp6l0rIbrvr2r3FVjhp3FplL
	KNYwhCsvF5Qgcubbji/XS/IUhKBPgFB7X8QjGwfXmHX5ZZwR5
X-Received: by 2002:a0d:e615:0:b0:5e7:5246:8f7b with SMTP id p21-20020a0de615000000b005e752468f7bmr10650775ywe.79.1704233516168;
        Tue, 02 Jan 2024 14:11:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnz4shpbyeonHylop6FDEDEEVcbaCqR7iBp2aclsXjzz7g8rllaGLNWxCJxvlxS1qvAvVXIZDM72VDn9UiZCA=
X-Received: by 2002:a0d:e615:0:b0:5e7:5246:8f7b with SMTP id
 p21-20020a0de615000000b005e752468f7bmr10650769ywe.79.1704233515934; Tue, 02
 Jan 2024 14:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20231228075545.362768-1-hch@lst.de> <20231228075545.362768-4-hch@lst.de>
In-Reply-To: <20231228075545.362768-4-hch@lst.de>
From: John Pittman <jpittman@redhat.com>
Date: Tue, 2 Jan 2024 17:11:19 -0500
Message-ID: <CA+RJvhwg3YXAzSk81nMGw=_3OMo6P=XcXBUFUAXSBcyXH6gkDg@mail.gmail.com>
Subject: Re: [PATCH 3/9] block: default the discard granularity to sector size
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Josef Bacik <josef@toxicpanda.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Coly Li <colyli@suse.de>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, 
	nbd@other.debian.org, linux-bcache@vger.kernel.org, 
	linux-mtd@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_141332_310532_6BB63E7D 
X-CRM114-Status: GOOD (  18.59  )
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

Hi Christoph, is there a reason you used 512 instead of SECTOR_SIZE
from include/linux/blk_types.h?  Thanks!

On Thu, Dec 28, 2023 at 2:56=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Current the discard granularity defaults to 0 and must be initialized by
> any driver that wants to support discard.  Default to the sector size
> instead, which is the smallest possible value, and a very useful default.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-settings.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index ba6e0e97118c08..d993d20dab3c6d 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -48,7 +48,7 @@ void blk_set_default_limits(struct queue_limits *lim)
>         lim->max_discard_sectors =3D 0;
>         lim->max_hw_discard_sectors =3D 0;
>         lim->max_secure_erase_sectors =3D 0;
> -       lim->discard_granularity =3D 0;
> +       lim->discard_granularity =3D 512;
>         lim->discard_alignment =3D 0;
>         lim->discard_misaligned =3D 0;
>         lim->logical_block_size =3D lim->physical_block_size =3D lim->io_=
min =3D 512;
> @@ -309,6 +309,9 @@ void blk_queue_logical_block_size(struct request_queu=
e *q, unsigned int size)
>
>         limits->logical_block_size =3D size;
>
> +       if (limits->discard_granularity < limits->logical_block_size)
> +               limits->discard_granularity =3D limits->logical_block_siz=
e;
> +
>         if (limits->physical_block_size < size)
>                 limits->physical_block_size =3D size;
>
> --
> 2.39.2
>
>


