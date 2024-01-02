Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72600C46CD2
	for <linux-um@archiver.kernel.org>; Tue,  2 Jan 2024 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g9QVj7o90tQS3H4SwYTPIYauXLnJ6OU7xRh/0KG0CF0=; b=HKscw4w6bSqY+2hMNgTGLMnXa6
	TemwGftObKg+4/qqplamhzvfXDuEQHz6patT2/S0B4UQbJIju9Y6rTc9QTQsHWGugg8iX7CMRjXdk
	dC4sUl/DU/R8WOWYQbbG6u6Z1LqT07f5Qg1IZ4HjPtl4UERL9PXxCx2W5ZVv0OgXRlMVaC4XE5sr2
	Psyf0mf3ofzvl/Cfof2Ifq1uIjLibVWVWZHsbI3/dLxXOkoa4BGSgGh4Le2ZMAeyF21jVgU/Cvvs5
	Pgqda0nlF/eJ6pGNXdif2x6XNGWTooUB9Qkl46hoxjc8hiKgLpN3liyp8pvGRSA+iinYcbWAo5u3j
	8RdQgmtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKgw8-008PKh-1i;
	Tue, 02 Jan 2024 15:44:12 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKgw5-008PK6-1m
	for linux-um@lists.infradead.org;
	Tue, 02 Jan 2024 15:44:10 +0000
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7b8529ce303so122842239f.1
        for <linux-um@lists.infradead.org>; Tue, 02 Jan 2024 07:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704210248; x=1704815048; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9QVj7o90tQS3H4SwYTPIYauXLnJ6OU7xRh/0KG0CF0=;
        b=pIvJbtzCAKIXEAWfXXyOMykX0bPYi0gC9Cj356oYDSwFDCh6NNXR9cnU7DgcSLOgeK
         5+3W4UWndGLd08twxSMP0L9UKBX3qe3V1nCd4tNBKqDqOs0mEil9RHxc8QxUObJaIpLQ
         qe63dLXj+YsP7cSMSNSB9Rcv3PZWc/5swkSlC796D58sXE0cZv5QsHpzVh+R8ASQwEw3
         NU0KTcjfWYO9Qvep0wRNhQlAJmqzHJdmmYk6ZLkXZfTnee66mIBCAiRtKht2KTL47x7y
         NFKDh1CWYjyqOxAj3Ml142Zi1zSbxfjaj1lognSdcQZKF9uyfURYaSNBun6SYKADBoGW
         Mk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704210248; x=1704815048;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9QVj7o90tQS3H4SwYTPIYauXLnJ6OU7xRh/0KG0CF0=;
        b=Fm+2k/XIqqG/UwX/N3cDAhVf6FLDNQliyOypA/q0ZC2cSIwtVUr2+nAaAS9tX4E5/O
         QsnNvy/jLrjJQAc4Mc0s35g91pR7OovTRY1b2kRGMjiBsDMJUXqVkbfgaCHf60dl5dYb
         aFjMGxmC7PlZwU171v4BjL/5px9D0Gl23eD5NA+IbqKJ0v/AdkwZ3u4GA2BKiw0davGQ
         cq9ipFMZegpsKf8Dr8kQ9IpOMlMD6CNYF4eJq40OBDB0GDpBPy/JCfoFd5SyEi1WegMO
         nSTrvzieNxwrKa8IDuHXjsxrb8Kp65lVP+Gq/1usItj0L9fKqy2CT1HKcinSjkxPR1Ga
         c8gA==
X-Gm-Message-State: AOJu0YxxI1RxGt+YRknypL0vyHMGETYS8LfT0XnczR5N6+fWT0w1ZfIk
	p2tMCCPEOQ5bja1gFaSls2hexskXZAvbpQ==
X-Google-Smtp-Source: AGHT+IFaAhZehoDkL/Lq9ymm1RdzzKN/67q+7aSVQpGW7QGqOVV9a9BjzLBm4rE1KB/JklVJV2PhvA==
X-Received: by 2002:a6b:e916:0:b0:7ba:9b40:2648 with SMTP id u22-20020a6be916000000b007ba9b402648mr24056653iof.1.1704210248423;
        Tue, 02 Jan 2024 07:44:08 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca16-20020a0566381c1000b0046dcfbc1bc4sm496784jab.79.2024.01.02.07.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 07:44:07 -0800 (PST)
Message-ID: <f3758a5a-986f-485c-9a6b-c11af20c3aa5@kernel.dk>
Date: Tue, 2 Jan 2024 08:44:05 -0700
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
In-Reply-To: <400dbdbf-e99e-4747-94db-54fb6674fdd5@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_074409_656395_88AA9C3F 
X-CRM114-Status: GOOD (  10.76  )
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

On 1/2/24 8:40 AM, Jens Axboe wrote:
> On 1/1/24 6:15 PM, Sergey Senozhatsky wrote:
>> On (23/12/28 07:55), Christoph Hellwig wrote:
>>>
>>> The discard granularity now defaults to a single sector, so don't set
>>> that value explicitly
>>
>> Hmm, but sector size != PAGE_SIZE
>>
>> [..]
>>
>>> @@ -2227,7 +2227,6 @@ static int zram_add(void)
>>>  					ZRAM_LOGICAL_BLOCK_SIZE);
>>>  	blk_queue_io_min(zram->disk->queue, PAGE_SIZE);
>>>  	blk_queue_io_opt(zram->disk->queue, PAGE_SIZE);
>>> -	zram->disk->queue->limits.discard_granularity = PAGE_SIZE;
> 
> Yep, that does indeed look buggy.

Ah no it's fine, it'll default to the sector size of the device, which
is set before the discard limit/granularity. So should work fine as-is.

-- 
Jens Axboe



