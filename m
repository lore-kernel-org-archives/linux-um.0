Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790B1C46CD2
	for <linux-um@archiver.kernel.org>; Tue,  2 Jan 2024 15:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yW0MzlHZomB+YZkCH4YUGFwdNBjbNMVw3h7xePuFXBw=; b=nMtO/deD1jwiFRyqGHbYfM8J8S
	rC4gO9+tO7QuL52levq6CB9yhlxdVW/ZGLZJyG2zqjUaJev80Ez+si6lg3CWIllFlV7QQ4nS+Fa2Q
	Hx51VXGg3Z5gnxVDlqFlX4i8MAumIdf0wf3V2Y4kDFmMaUE/WH3b031SOIboA0pzI2mtGJ7YL+aKb
	T/yNhpuFkoMVunvTDilUq2bPmlbmO4RZsby0RYiP1dSJd5O95pJiPxfBn4hmt7Qdr0OT6ShsJPSj3
	LGdv5TWCvxNDdbl//cp+qPTSK73/6gIPFa+qVBIb3QBVSdThHBMNOCbq4zJSe0mAO/KGL68utODyf
	8HwpropQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKgsm-008Oyv-38;
	Tue, 02 Jan 2024 15:40:44 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKgsj-008OyD-2A
	for linux-um@lists.infradead.org;
	Tue, 02 Jan 2024 15:40:44 +0000
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so67770139f.0
        for <linux-um@lists.infradead.org>; Tue, 02 Jan 2024 07:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704210040; x=1704814840; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yW0MzlHZomB+YZkCH4YUGFwdNBjbNMVw3h7xePuFXBw=;
        b=n5t/HpsQCg8uyryU7VFUSfyryzIYeHYIY2JWkrdsY2i+To3Ck/qWTw5BG7xzt6sS84
         bN6vy1HxmjwJTXeSnVVlgf54357UpO4dwpqEgroXB0P2LRk2YitjJozS6+qksM1RrLYE
         Uj/cuGeqct4NHz0iAMxdzyrrXr8shLGFwdPoFjBDpar+e+JEuA9KE9OiOk1JkdKQZlcm
         dJv14rLglcM356I4DXlgSe4tSiBEMHdla1fn9rKSPaZexVA7p8UGXssPBXaQNWT/Rudl
         OJv9YRNGA9f6HDQFe4CYjSLRExc4+bVPuep/Ul8+115ZTng1ySBwVPVDUtMRyEw4cctG
         Krgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704210040; x=1704814840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yW0MzlHZomB+YZkCH4YUGFwdNBjbNMVw3h7xePuFXBw=;
        b=L8CqO29PsXe6WnkqRHdtatWDAQqOhg3cHJWHmQT7jhQOr8bR+9iAe+yiJJH/tnrB3I
         BVqv2JbDfWiMoxaCiJlqfzmzpaeKeOPUT2OmDWsbGf5BeJv9Zx7ICzSf5XBvIQArDTow
         XZtEDeB6hupEm2bTQ/oDmT/q7TaSAsKZPEm0PRuUEsrJkrobMhDA9Rlp5c7yzl3/Qh02
         iDbcgWSI3W/9DghlbtA9weiX2qVGIG66mLHtCKLoeMwHiOI1gC0PNIvol+2AVmuMdK1u
         Q+nmLE+u9zH6Ncjmy9USi7yP3dp4wkqDpKagWrO9uMpGN3A97KErZFZe2VW4v1tvZEkc
         nU7Q==
X-Gm-Message-State: AOJu0YzR0re7kRwa3QWvliX6AYJEML64YlPd1t2geoqIMendA138Bt4i
	9IYCOG3Dkoy6POO+pdw6S4qUgeLsWF66UA==
X-Google-Smtp-Source: AGHT+IEwoDpWa3DPCL2q3LLo73FXUxeDnS1RhrchV5t+VIVuVtSvXaa44wpnDuL6ftiaSS1FPUs3jg==
X-Received: by 2002:a05:6e02:20c5:b0:35f:ff56:c40a with SMTP id 5-20020a056e0220c500b0035fff56c40amr22286643ilq.0.1704210039707;
        Tue, 02 Jan 2024 07:40:39 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f12-20020a056e020b4c00b0036002c8127asm5354004ilu.5.2024.01.02.07.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 07:40:39 -0800 (PST)
Message-ID: <400dbdbf-e99e-4747-94db-54fb6674fdd5@kernel.dk>
Date: Tue, 2 Jan 2024 08:40:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] zram: use the default discard granularity
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Josef Bacik <josef@toxicpanda.com>, Minchan Kim <minchan@kernel.org>,
 Coly Li <colyli@suse.de>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-um@lists.infradead.org,
 linux-block@vger.kernel.org, nbd@other.debian.org,
 linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20231228075545.362768-1-hch@lst.de>
 <20231228075545.362768-8-hch@lst.de> <20240102011543.GA21409@google.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240102011543.GA21409@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_074041_832248_FC96E175 
X-CRM114-Status: UNSURE (   9.99  )
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

On 1/1/24 6:15 PM, Sergey Senozhatsky wrote:
> On (23/12/28 07:55), Christoph Hellwig wrote:
>>
>> The discard granularity now defaults to a single sector, so don't set
>> that value explicitly
> 
> Hmm, but sector size != PAGE_SIZE
> 
> [..]
> 
>> @@ -2227,7 +2227,6 @@ static int zram_add(void)
>>  					ZRAM_LOGICAL_BLOCK_SIZE);
>>  	blk_queue_io_min(zram->disk->queue, PAGE_SIZE);
>>  	blk_queue_io_opt(zram->disk->queue, PAGE_SIZE);
>> -	zram->disk->queue->limits.discard_granularity = PAGE_SIZE;

Yep, that does indeed look buggy.

-- 
Jens Axboe



