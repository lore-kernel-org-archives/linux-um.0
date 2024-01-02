Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27CDC47077
	for <linux-um@archiver.kernel.org>; Tue,  2 Jan 2024 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ySBFOJIM0DSvIVDKhQcLqvBT2yyLab4gqIewIhfdbtY=; b=B/HqxR1b6Xuipykoqxe83jZ+yt
	hOegRgvc4hPk7Rwh11B28RKW1GnoY8Oc/FcmKqlSU/ShfiOzzAK/Ggs3q129GtT36MYvquehAb2Iu
	d4lOIzdI137UVcY26lmAaNEp8I2eA6tFw2cBkaZsJryjVZEH2/H1MVp5jBkG2voYCnPjcAL71/TPf
	0u8k++JMhRoQ3zV80xNimQptkTNAgZBufdWZJjMQFSCQcKMrKPk9XRfegAnM5NaZ1nhdJPw4xTyTs
	xfqCXFSHfYLkznP5+qJL5cuK7OIR8BKMs+fTgtrQOze03DdAQnxj4Ri8fUlxDOVVzkP0QxRdrf9JB
	JjdxnJlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKgza-008Par-0n;
	Tue, 02 Jan 2024 15:47:46 +0000
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKgzW-008Pa0-1V
	for linux-um@lists.infradead.org;
	Tue, 02 Jan 2024 15:47:43 +0000
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-36016c6e19eso4043485ab.1
        for <linux-um@lists.infradead.org>; Tue, 02 Jan 2024 07:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704210459; x=1704815259; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ySBFOJIM0DSvIVDKhQcLqvBT2yyLab4gqIewIhfdbtY=;
        b=UbR5ql4lmhqDS68ixIqn5BKAK1SDQnFR2/tzDbUyoqlvpvG0GrM8mosW9M/z/n2e3c
         Y4EMv80KNfBRf8OFIPUy0RmJJVsRn/P6rTVWa031Ym9Uvvry1q7CI79iEyMQGyWy+Oue
         VISsUAHl1unepuwktHAHbJ/bv0rGISwhr5WdTQhitWmIuX/81Eh/qCTnu05Tfpqh+h++
         D04ocsWuWyd0iWFjvFDSOIRsHgn48aN93eQLquGxOWHBlDbnWg784nY/n1q2RfrCMmrV
         b+7/rVNwzneHiGmeJbN+/UNw6wohqGlSoIDTJTx2+TRlqmg1x/ms605/Xfj1x2G4R8aN
         zVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704210459; x=1704815259;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySBFOJIM0DSvIVDKhQcLqvBT2yyLab4gqIewIhfdbtY=;
        b=DFo8DNlbK1oinrUXEvkdBRnlwk9iNBzuE712C3RDEd0Z8JPKmBVlrBzfPJxgsJ9UEK
         SEpS30qQbwLEPjsvSZ9T4iUMY35GI1SLazYjdnG6jOFCY0TtYV0EPZAqUtf03qDp1fED
         7P2YBeNmbM093p1yBI+2DdJL08QBLpkt3vH9RmxKOcD0ub6MJwKSc67etUr2ucx3Viuz
         VyRaqqi0KNvR3bs7EPIy7NQ89Fvfr7qqWWcTBcKZXz2Jsoi7L6/ym4kaMgCufb44GUf3
         Lx3T39NqzS0wLZPDf8Lt+yFlYXjGCxQGU+ebA9DOcM7sypA5DqHr1bp6kbhiZ5hPxiEi
         dU1Q==
X-Gm-Message-State: AOJu0YxF+yZCH0FtorcqtfX8yTkhPlHB19PClicsITbmp4gK4YC98fxU
	KghZKViUmkrD25FfSJSdpMI/PY2tUMnZaw==
X-Google-Smtp-Source: AGHT+IFs9GZ/Ey7ptKHRHLLO93hZlIAauQjofaYqCnhw5oeOlPvARiPsQn3KTgYcoEx49b9b2zgL8Q==
X-Received: by 2002:a92:c26f:0:b0:35f:efdc:7738 with SMTP id h15-20020a92c26f000000b0035fefdc7738mr26703798ild.2.1704210459220;
        Tue, 02 Jan 2024 07:47:39 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cb6-20020a056e02318600b0036003f7ce61sm5383610ilb.87.2024.01.02.07.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 07:47:38 -0800 (PST)
Message-ID: <92011368-a4a5-428b-9801-26a6a6a96752@kernel.dk>
Date: Tue, 2 Jan 2024 08:47:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] zram: use the default discard granularity
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
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
 <400dbdbf-e99e-4747-94db-54fb6674fdd5@kernel.dk>
 <f3758a5a-986f-485c-9a6b-c11af20c3aa5@kernel.dk>
In-Reply-To: <f3758a5a-986f-485c-9a6b-c11af20c3aa5@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_074742_555667_997399F7 
X-CRM114-Status: GOOD (  11.55  )
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

On 1/2/24 8:44 AM, Jens Axboe wrote:
> On 1/2/24 8:40 AM, Jens Axboe wrote:
>> On 1/1/24 6:15 PM, Sergey Senozhatsky wrote:
>>> On (23/12/28 07:55), Christoph Hellwig wrote:
>>>>
>>>> The discard granularity now defaults to a single sector, so don't set
>>>> that value explicitly
>>>
>>> Hmm, but sector size != PAGE_SIZE
>>>
>>> [..]
>>>
>>>> @@ -2227,7 +2227,6 @@ static int zram_add(void)
>>>>  					ZRAM_LOGICAL_BLOCK_SIZE);
>>>>  	blk_queue_io_min(zram->disk->queue, PAGE_SIZE);
>>>>  	blk_queue_io_opt(zram->disk->queue, PAGE_SIZE);
>>>> -	zram->disk->queue->limits.discard_granularity = PAGE_SIZE;
>>
>> Yep, that does indeed look buggy.
> 
> Ah no it's fine, it'll default to the sector size of the device, which
> is set before the discard limit/granularity. So should work fine as-is.

Replying to myself again... It does then default it to the logical block
size, not the physical one. Which does look odd, seems like that should
be the physical size?

In any case, this does change behavior for zram.

Christoph?

-- 
Jens Axboe


