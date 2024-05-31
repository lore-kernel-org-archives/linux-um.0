Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F3EC25B75
	for <linux-um@archiver.kernel.org>; Fri, 31 May 2024 06:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UHfXsuY+pdYsu6JkPOmIMiIuAZ41w4yugEvYSYmSsZg=; b=4MHyM4Llj00ZrdXhpHyYvrlvwL
	jqNG0KqBHEoByk6YCEkSWCkHyYqQskRz3vV/Mdk6gwVQ1oJfUR7T/zfBI2z00+ubikDVSSoZGrQ0H
	8tWehmOp1/lVNGb7PnUCbbOeeVIdR9S0i1dYqJVmiNy1vclkx4ZSe0J+oan2X9RbNyEq3edujXnBf
	FCvT3K7RA+zkLf3EG/vMuvReW8AzSif7ndSxBvl0Ej8EguA/SDXNmkYNj/TZLt83mjI1kYqIGf1ny
	GLpBq+XoDWyu1Cg/5K1BGgSVHf55KVcCbLRCLIBB0IRAvqZgeNTBtx9dArsRd5CStG4swjzgjLCoZ
	sX8P/N4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCw3y-00000009QQt-2w1Q;
	Fri, 31 May 2024 06:48:30 +0000
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCw3u-00000009QQS-1n6g
	for linux-um@lists.infradead.org;
	Fri, 31 May 2024 06:48:28 +0000
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-5b970e90ab8so1030273eaf.3
        for <linux-um@lists.infradead.org>; Thu, 30 May 2024 23:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717138104; x=1717742904; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHfXsuY+pdYsu6JkPOmIMiIuAZ41w4yugEvYSYmSsZg=;
        b=i2NB03y9MQcMZKdwSw+e16WUHI9BMgEmLWSUWckEiMGvj8NRHS2ODtfaRJhZvth7a/
         Czy6srvx8H2vQ/O6dQLyqohVSHlNhP/P3obt5S8HVZO0UsqOJWrcJs/7kOqHOuxr3Yo8
         pczkl2pR8h0eMXD/31wSAQ7GGRpYSRjH+3t1t52M3Ky4Oil2k4RpGLuti5ohr1Gj2n8E
         j8oBlpGFBCZdDRQXikIzZDMjN7zJiMHcWVL764SbWwcQ3Rgl9S2HFrm4c3EY0wIBHHad
         r6ksoBjZQsXNsvIAOF3RauxWw+R3PXo3TJXaq4TzLPUSVeerKHiBRKMYkA+oBdTM49eq
         w/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717138104; x=1717742904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHfXsuY+pdYsu6JkPOmIMiIuAZ41w4yugEvYSYmSsZg=;
        b=aGO9mWqj63+FAuNJXhlnHZA538EnJ3Xr17EskYjBZ/8Ta1RUnkzOT/LKTLEqJ4+RaL
         l6Ba5BAOW592OlWKOZxELZTkCI0EPKXa8UlE6SN3NnhcZLO4KAZBtFDjuGlE/VkXlmGd
         uAjzEEiAQ/yjRnV8A1lhHjG8TUZoSpbNSmIcQpKvBLTFmooqm2kqOodF1seZiJUa2wL9
         pKxmzzd087VGTpzikhdHkhlg75akRn9p+aOwy/bZeE+1aLg5dzAR0k5R1Aa4fxhbvSe2
         RFDj8ei6gywfBxWPoSHPm1Y9dZVxSxVNCndcjMvSzW8ihFw8/27uDJ9NLx1W1IH+/DLQ
         4R2w==
X-Forwarded-Encrypted: i=1; AJvYcCUbHMxHTVBr010u8RrTy3K6knF9y8QaPLWgYGL+X4JPvoVqWu0V733vkSw6xf0LkpB2nhaj1M0+j3/vll/4DGxYXTlL8eBWpdWj2h0+
X-Gm-Message-State: AOJu0Yzplb/FE/4QIhiSO+E2yX3cKMthzol+7MGY2KFdCq8ocS2SybK3
	HJFy4EPcFnXWmODQde5fc/QEwW3SNQcnYJe0FaXJxI5pILhuxf3TPgE81FkFwQVOoqLBGSw1RXV
	Q7GOkXt1NtDO42U6BSVYH0pn8Wu0nlYYinxrVgw==
X-Google-Smtp-Source: AGHT+IEkgVU5yVpc+xeOYwUOJd29bp6vThPd4yP1XUDfgboWzFw/FVhH/FxeC96crk9g7iXBffgH6P0YPBoJ35FyjnE=
X-Received: by 2002:a05:6820:151a:b0:5b9:70f8:4b82 with SMTP id
 006d021491bc7-5ba05e1f5a1mr1238669eaf.9.1717138104409; Thu, 30 May 2024
 23:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240529050507.1392041-1-hch@lst.de> <20240529050507.1392041-3-hch@lst.de>
 <CAOi1vP-F0FO4WTnrEt7FC-uu2C8NTbejvJQQGdZqT475c2G1jA@mail.gmail.com> <20240531055456.GC17396@lst.de>
In-Reply-To: <20240531055456.GC17396@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 31 May 2024 08:48:12 +0200
Message-ID: <CAOi1vP-VXeOH-kShRKv-b=id1zN9tLiqOo8EKpOWoJuQp_Pm1g@mail.gmail.com>
Subject: Re: [PATCH 02/12] block: take io_opt and io_min into account for max_sectors
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Josef Bacik <josef@toxicpanda.com>, 
	Dongsheng Yang <dongsheng.yang@easystack.cn>, "Roger Pau Monn??" <roger.pau@citrix.com>, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, 
	nbd@other.debian.org, ceph-devel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_234826_516761_70A4D1ED 
X-CRM114-Status: GOOD (  23.75  )
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

On Fri, May 31, 2024 at 7:54=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, May 30, 2024 at 09:48:06PM +0200, Ilya Dryomov wrote:
> > For rbd, this change effectively lowers max_sectors from 4M to 64K or
> > less and that is definitely not desirable.  From previous interactions
> > with users we want max_sectors to match max_hw_sectors -- this has come
> > up a quite a few times over the years.  Some people just aren't aware
> > of the soft cap and the fact that it's adjustable and get frustrated
> > over the time poured into debugging their iostat numbers for workloads
> > that can send object (set) size I/Os.
> >
> > Looking at the git history, we lowered io_opt from objset_bytes to
> > opts->alloc_size in commit [1], but I guess io_opt was lowered just
> > along for the ride.  What that commit was concerned with is really
> > discard_granularity and to a smaller extent io_min.
> >
> > How much difference does io_opt make in the real world?  If what rbd
> > does stands in the way of a tree-wide cleanup, I would much rather bump
> > io_opt back to objset_bytes (i.e. what max_user_sectors is currently
> > set to).
>
> The only existing in-kernel usage is to set the readahead size.
> Based on your comments I seems like we should revert io_opt to
> objset to ->alloc_size in a prep patch?

We should revert io_opt from opts->alloc_size to objset_bytes (I think
it's what you meant to say but typoed).

How do you want to handle it?  I can put together a patch, send it to
ceph-devel and it will be picked by linux-next sometime next week.  Then
this patch would grow a contextual conflict and the description would
need to be updated to not mention a behavior change for rbd anymore.

Thanks,

                Ilya

