Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C120EC27C44
	for <linux-um@archiver.kernel.org>; Fri, 31 May 2024 09:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JHySJ52Pl0hABImbEf8CzUryCpcO6Vzdug5aWyPJAWM=; b=Jhvz9eBNwXoBj0hcyI9WJzC11G
	hR9cGRlaXEte2UC8oxD6XtJVg4SCYP4m2eoFHAvjSatnsmmsW1G1Y6EgElWjuIXWxo7a4Y/09B6L5
	HordrwiqPdMazoyj9G8TZf9vovX4E/1mLDKcX3HdQoqjxCfbQ/Sm6r/wuJzAxPjZiq8csZyakB2XO
	iGjuItCmcQ99Xjhxpr81p8NYgPlsiMm+Tqeks9/gi4QTqZPTGQJjDQFzwlAxfJlbMPOrH58qShbhX
	r86bejTY0WePCuLfhw0eI15NclGz0tZdElqjgHw1x6YSbNgca68nYrTbpMgW0KnxZ/jt16Yypoee8
	kzs56a+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCyI9-00000009kbj-2DXy;
	Fri, 31 May 2024 09:11:17 +0000
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCyI6-00000009kb6-3FGZ
	for linux-um@lists.infradead.org;
	Fri, 31 May 2024 09:11:16 +0000
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-24ca2f48031so890667fac.0
        for <linux-um@lists.infradead.org>; Fri, 31 May 2024 02:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717146672; x=1717751472; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHySJ52Pl0hABImbEf8CzUryCpcO6Vzdug5aWyPJAWM=;
        b=IO3l6rT0ygG/0LCskgOuoRuXpkYIl1wfDQ/TD0eOoZR9WjrbvUg9J01IUrG46XkYDu
         3kq6xXNc6oF/v7F8qCBxfP0VdXdIbuK50wlowAyyCsPk2dLLJNoBpEXCfqu33ctWB4Eg
         rSmGWz3AyJMBPg1USpIAAYlAN3+Q/Xgh1nv8/SS9yQ3NItBWCSSy0xCEGS9HgulLd2Yr
         BykYvdF9pMZQGCbiLb8JHN52CckjzKzzLSCR2T24GPwAxvINhBZ8Z/8j5nfNy/PanVSY
         gVhdX6ZHfOGTCPocAr9fj1VU56ey+JRqJcT1WQKIBZN/7yCBhN9Feg0XGBPPK1pq5f6+
         ILiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717146672; x=1717751472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHySJ52Pl0hABImbEf8CzUryCpcO6Vzdug5aWyPJAWM=;
        b=ZBu+rnl9Q4HBibr0wG3xz6VnxQrl/A6UdNkXjzn5HowP5ldedB+jfUTnUNqCUpgyIN
         jEKoPmPbwqosJbcyt7spdDcIF/hgCir1nB8VGNstc4hY+pMmRt+Wtmkwd/7zo7j6fYeZ
         uLXNoITQl1E4kThJdE+0Sx6b/IqCmooCF7lxtA7T4waGFJMTJJM9AV19mO/3/HqoKW4J
         Xd5w/CaXWXfC7zaWYJ9L4p0YmrnHGzjh9R3Rw4DerVroCfwQnscLdVvkn2yuIWXPCm03
         vZJJPyNG5WM3xJS1N2CoIrRzfjnAOzeAbSFW4suh0pI1sPEdYybC1Hj59veQ/g2/NQQM
         w2OA==
X-Forwarded-Encrypted: i=1; AJvYcCVyl5t5U6T/cVOyvhdzh6CL0GFymoKLSeLy8pJ9Y2viv3H3P1z+1Yw5j2kSJ+lj/zIV4cYl1RI4GtC6L6a4bYbyQFH1fQHNtISjmwYp
X-Gm-Message-State: AOJu0YyJlmBqWKl90jIzZePh5afXFBPSJ4FJgVsFkO77zQ/9D79eVpYN
	Ck3Peqtg/ErcxWTCwzzwzDfAc6UCw/ljOfKfXJatWaysuTbCI9EAUEqAK2pBVEf/0qDKPg6B7OB
	wcvUvlF7w6/Ru5cyx/sir/FIOmk0=
X-Google-Smtp-Source: AGHT+IGvsAs1mcJwvgWnNqWcEhu7b6x8mgHTIAZ0GzBV17r0EcNcgsUewUXES03iA8vPcRMr9oo8aonYpNodLH6h808=
X-Received: by 2002:a05:6871:339a:b0:250:75cd:34f2 with SMTP id
 586e51a60fabf-2508b99ababmr1494585fac.22.1717146672346; Fri, 31 May 2024
 02:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240531074837.1648501-1-hch@lst.de> <20240531074837.1648501-5-hch@lst.de>
In-Reply-To: <20240531074837.1648501-5-hch@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 31 May 2024 11:11:00 +0200
Message-ID: <CAOi1vP-+j-RHLmnDLpsZREnYb_f7QGGhRC9YOgctsFNuE7yM3Q@mail.gmail.com>
Subject: Re: [PATCH 04/14] block: take io_opt and io_min into account for max_sectors
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Josef Bacik <josef@toxicpanda.com>, 
	Dongsheng Yang <dongsheng.yang@easystack.cn>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, 
	nbd@other.debian.org, ceph-devel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org, 
	Bart Van Assche <bvanassche@acm.org>, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_021114_832320_B72700DF 
X-CRM114-Status: GOOD (  17.79  )
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
> The soft max_sectors limit is normally capped by the hardware limits and
> an arbitrary upper limit enforced by the kernel, but can be modified by
> the user.  A few drivers want to increase this limit (nbd, rbd) or
> adjust it up or down based on hardware capabilities (sd).
>
> Change blk_validate_limits to default max_sectors to the optimal I/O
> size, or upgrade it to the preferred minimal I/O size if that is
> larger than the kernel default if no optimal I/O size is provided based
> on the logic in the SD driver.
>
> This keeps the existing kernel default for drivers that do not provide
> an io_opt or very big io_min value, but picks a much more useful
> default for those who provide these hints, and allows to remove the
> hacks to set the user max_sectors limit in nbd, rbd and sd.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  block/blk-settings.c |  7 +++++++
>  drivers/block/nbd.c  |  2 +-

For rbd

>  drivers/block/rbd.c  |  1 -

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya

