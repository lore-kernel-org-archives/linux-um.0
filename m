Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69F2C25B7E
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 19:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=41y1G1yWB6PRjXPqqWESihB4DpKvKPtS6LjA52lk1aM=; b=S6GoBnuaypthEQxStggj/yuXNB
	d7zSfrNy+t624JxPbuAF99OYtWinnO74gzeVMhtcpzgA2g7d/oV5/mfQpnqx1NJIKMSqLWSEFXcTk
	reABnqTIQQGAU7rMVHIa2v7TFGEvoh9K5CdAITeURje0L4AilPjpRjp7cPOipK5AvCrjj8Xo23tGY
	pcKYYSpAIPYe9A+kvE+s2ZZE4cXXDABA+G/CqAfx/hEEJ8onuDFz3yIPKEsS9efhxhgasbThQwWax
	rWu/WinqRLC+hZS+z0OpVZaVCj+dTq6El2uTRtvxFsEzHUs1xWSudVbDLVzHwpQewiF/NTYAOcLLI
	C7l5/D8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCllL-00000008Gpe-0ZCG;
	Thu, 30 May 2024 19:48:35 +0000
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCllH-00000008GlP-3GJQ
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 19:48:34 +0000
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-24ca03ad307so719320fac.3
        for <linux-um@lists.infradead.org>; Thu, 30 May 2024 12:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717098498; x=1717703298; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41y1G1yWB6PRjXPqqWESihB4DpKvKPtS6LjA52lk1aM=;
        b=PvuU1ZTldqgGJ8ZAwC7jYDW7owFsAKvFEOvdAldkNuaXw93ZjtJ4TstFhZCVkh1Brr
         a89vz+FbCNIDnORWpmhYkiNdnl0gqo0wtesud1YKkPgzLPASM8L8+LOkUWnijCzovp1Z
         VyJg3cA+5RGyv0XwrlEcWmkiKn45ApaiCqn3g2IIWm5Pw05OO1B/qB+OC+M6VQlZ4pby
         9+uXFNBn3lciPrH9XlAsdAtD0du8ga9XK0M9692eZutGMInSY9aso5fd52HDmRYnjgL6
         8rPhlU+RW/3p2eJQS7dk0cnwT91UG8J/THjx0pz7HABM+tfUwj9bDl9Cs5rTjH9BZrZg
         XU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717098498; x=1717703298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41y1G1yWB6PRjXPqqWESihB4DpKvKPtS6LjA52lk1aM=;
        b=iUsYbBfMdJFUIDzenB8eWPHOXr8Y61VJDBItgXUa3Hz5ugaNsy/Kap8xYqB5IfjIVI
         zuIwknTf7KufnHKXQJ7eumiSZIHxpYO19RWaNvNjY7Z2AdR/dSuOIJOi5Lc8oRzBIywv
         PNLtue8I46uXtOlCKACUrIbuIEe4/43c51jUC44i8wsKEvpcBCyEKCJzAlYCpaLPtve5
         hYf6q6bjZYVstXUYc083gTYeQlepT3G5qNfSzQfn/V6XwK7XvdTBFE6JqSXgAFmYyj5n
         A4i3C1skuiwTfIS5X99bLDsYhCu0NkRirNY7xZeIARirgwI61wwIlL0a1+9FIfDsLvt7
         KN7w==
X-Forwarded-Encrypted: i=1; AJvYcCXMjOPEQpQzAEEZI5LWOFUcjXvBgEze4mwtG5o0ngX7MHvXYZXshdf2ty41IGlw6bwZ0QAmfl9vgS8ZCpjyPtAgQthO3vQqF/I+2RtP
X-Gm-Message-State: AOJu0YyTe9LcWM6rWXA5qQhocga3bEc+MsXkjYzdQDqzAhCNU8N7fJUf
	+ZVEnZkXif7yf5nlKkqcfawsrMhxPuxOdfyCdMnriUseFOP1+n/kJ7FNC2UOcz0oYGp8b18dqvL
	UFAqBGcE6FaOn9ZsTT7feiO+Z4/U=
X-Google-Smtp-Source: AGHT+IGxcLZtvGZ8VsT8cGFEuW/elxJjHWgoM8RDpdS5UpADe97i5sefwnR8gwVFsz1jHFTWagn8cx64x4raaIJwd/s=
X-Received: by 2002:a05:6870:b492:b0:250:6f7c:495 with SMTP id
 586e51a60fabf-2506f7c0a24mr2683166fac.9.1717098498330; Thu, 30 May 2024
 12:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240529050507.1392041-1-hch@lst.de> <20240529050507.1392041-3-hch@lst.de>
In-Reply-To: <20240529050507.1392041-3-hch@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 30 May 2024 21:48:06 +0200
Message-ID: <CAOi1vP-F0FO4WTnrEt7FC-uu2C8NTbejvJQQGdZqT475c2G1jA@mail.gmail.com>
Subject: Re: [PATCH 02/12] block: take io_opt and io_min into account for max_sectors
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
X-CRM114-CacheID: sfid-20240530_124831_876954_E3D19F97 
X-CRM114-Status: GOOD (  22.97  )
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

On Wed, May 29, 2024 at 7:05=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
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
> Note that rd picks a different value for the optimal I/O size vs the
> user max_sectors value, so this is a bit of a behavior change that
> could use careful review from people familiar with rbd.

Hi Christoph,

For rbd, this change effectively lowers max_sectors from 4M to 64K or
less and that is definitely not desirable.  From previous interactions
with users we want max_sectors to match max_hw_sectors -- this has come
up a quite a few times over the years.  Some people just aren't aware
of the soft cap and the fact that it's adjustable and get frustrated
over the time poured into debugging their iostat numbers for workloads
that can send object (set) size I/Os.

Looking at the git history, we lowered io_opt from objset_bytes to
opts->alloc_size in commit [1], but I guess io_opt was lowered just
along for the ride.  What that commit was concerned with is really
discard_granularity and to a smaller extent io_min.

How much difference does io_opt make in the real world?  If what rbd
does stands in the way of a tree-wide cleanup, I would much rather bump
io_opt back to objset_bytes (i.e. what max_user_sectors is currently
set to).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D16d80c54ad42c573a897ae7bcf5a9816be54e6fe

Thanks,

                Ilya

