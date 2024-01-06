Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE57C3DA6E
	for <linux-um@archiver.kernel.org>; Sat,  6 Jan 2024 01:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qT3oZQlZSl6Q++CcuktscPeZvw2bExX2KYu8x/389yU=; b=Hb6Rrsa4neLqPWvnVys9pK3tLP
	7aPsJveWrf8yeFC/o3+B2Y00/USxzYMlhV0ruzBb0gAUiRQpm1uZJEVXfMZAsvMkMh/Dr/gM3/J9j
	C8iGWm1T64el86JhgWxOAHT8iu6ZTi68tL1shVNCrz0/NoakkDfRA38zup4gnvM/pmsrX/MZbDKpV
	36vl9N2mzMhTGq5sK4ilJSGIh3h3uqE/mbNa8XNdyv1EvRIptI5CDdKZePLnSCty1t/Onl2YVzxO5
	PZeRN54T9SIlNOh0kFUfNfqPeI92vNOuquQohMGrx2/tE5xy6P+WtuIN8epe3+T17far/K65ewiCV
	0xYe7Beg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLvYp-000Xzh-1e;
	Sat, 06 Jan 2024 01:33:15 +0000
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLvYm-000XyX-1x
	for linux-um@lists.infradead.org;
	Sat, 06 Jan 2024 01:33:13 +0000
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3606e15d718so1039505ab.1
        for <linux-um@lists.infradead.org>; Fri, 05 Jan 2024 17:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704504781; x=1705109581; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qT3oZQlZSl6Q++CcuktscPeZvw2bExX2KYu8x/389yU=;
        b=BDKAD0JGLYaoX8QU3RpwkrcUzVc1aDBlNvTDcYsFp4DBS6HvVj4sjVMZXBXpwCfTDv
         wveLwioAdRNVVM9sf7IaoUVJEGmUK0dNgYeZQUEepJYr/R6WKJhbHs4MLeEx4bPdKFYY
         rWBBiDqjgmD5He2g3unvPtHsFcB4rZOGEYCHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704504781; x=1705109581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qT3oZQlZSl6Q++CcuktscPeZvw2bExX2KYu8x/389yU=;
        b=nPP4rWDvkOTkM7YSxlVLPWScUFkbu6tH46/iVMofwiZVtDLLZGLYM2BLmSGx7zkY2n
         Ccez1rHd1LJ8dYZF7i/N2xVK0qHwSzRT1wJn9+hpNsbi6bKLkR1RhsA1OM0HjZHCRE1e
         M1OnSOXpDMrRl7QV3tqMaeeLKuSgvdOdniMB0cptHhbYAujCdaO3CyV4SIClYXT+51R2
         yLDkpoR4zyThbx1g8XRWpPLQOe7Jncl0kwXuu1RTugQI+KaZFhh1+2Oecs2vS9NGJt6L
         WEZMYATMsp1WLekfdJJ607GxXvzH3/SVOFnZbmqBz9UYg3xq+agiySTrTejexBsv8PdM
         5FjQ==
X-Gm-Message-State: AOJu0YyUM2a4+M3QIyhTUe6vedx8yQllEYZ1UJ0nwAqaZ8dvtm+I3ppc
	a8ze5+dW7X7xPRdkJ3+xYam1wdtS980q
X-Google-Smtp-Source: AGHT+IGbdqkCX01n0F2LxOJc20c51ndSlx6/hfXSdI3NKdAsCGkhvdsG05i+OtNt2Y/UCPH6C9phNg==
X-Received: by 2002:a05:6e02:1c0b:b0:35d:62f2:1f45 with SMTP id l11-20020a056e021c0b00b0035d62f21f45mr533250ilh.20.1704504780792;
        Fri, 05 Jan 2024 17:33:00 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902b49100b001cf511aa772sm2017224plr.145.2024.01.05.17.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 17:33:00 -0800 (PST)
Date: Sat, 6 Jan 2024 10:32:54 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Coly Li <colyli@suse.de>, Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-um@lists.infradead.org,
	linux-block@vger.kernel.org, nbd@other.debian.org,
	linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 7/9] zram: use the default discard granularity
Message-ID: <20240106013254.GC123449@google.com>
References: <20231228075545.362768-1-hch@lst.de>
 <20231228075545.362768-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228075545.362768-8-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_173312_640525_2BB0284D 
X-CRM114-Status: UNSURE (   9.34  )
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

On (23/12/28 07:55), Christoph Hellwig wrote:
> 
> The discard granularity now defaults to a single sector, so don't set
> that value explicitly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

FWIW,
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

