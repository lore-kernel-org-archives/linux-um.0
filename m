Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FB5C27C53
	for <linux-um@archiver.kernel.org>; Wed, 19 Jun 2024 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TrxAc+Uu30dWHZppC8CN0wQM7I31e2d3aLis3drkvvE=; b=qc+kl9Ah1U4CcvFcF5VOviiRYZ
	GCpdCpI+PM6lr4bzdKl3MYRht1xDuOufyBDYxWYPXddkNA838FdEEbpVkjVIrkxMKo/cY45agWytF
	n3P70XEqdhht8gbNTJkF8OqyCigZgHWzK5aRmMeAIGKbK+Rt6xM5B5K0fWXgXy0sh2K9zmnjgVC0s
	/rn5SZTKP9+NfKM+4/6no1Hfuq6PaDJwJQF/a2xydzkbpoPElYGJKgLjgwDWvedOuD+nQwUZ3eLoY
	f/IxgLhrmJW7JygR0yWcQEPRssDLLqwzvGvAHrV5VY2+37xstZuyeyYacOPlXPSKukSUOWRcG/6fv
	FLwnqJ2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJwBg-00000001Ug4-1KcJ;
	Wed, 19 Jun 2024 14:21:24 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJwBb-00000001Ud9-3B8R
	for linux-um@lists.infradead.org;
	Wed, 19 Jun 2024 14:21:22 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-6f799fc5af3so329116a12.3
        for <linux-um@lists.infradead.org>; Wed, 19 Jun 2024 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718806879; x=1719411679; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TrxAc+Uu30dWHZppC8CN0wQM7I31e2d3aLis3drkvvE=;
        b=fHCgF0uhO0nuyZqlRpelUr61VBjxZeFBghsqWgKhlDVVMs+UVVexUSBKvR/bwYnNaa
         nQAg7yUSEN5KMyPr7VNWeiLV1fcMsp8ybe46RfZQIeJ9ho1qSxiu1Dd95H4BWUiDK2Xw
         ujwJ/kqkS2sT0+9uCWIWuX+CLpStuQTswEwbKkWKBHchKg3jD0MwM+8KTuPOMVFvSoJ8
         /PTP9DiKBffeouR00305aC34047ynfsn1SacdwQM0E/sm2xpmzKntxttj8D2QzyVUldW
         CSxagGXV4PyATsSznZymvCCFLSnzaT9Eagn5NYReu/WhqRgjXauozi3w2zg18TkopjDe
         fMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806879; x=1719411679;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrxAc+Uu30dWHZppC8CN0wQM7I31e2d3aLis3drkvvE=;
        b=VhfK94CTFrEJbcywKfDt1rHF2VtTqt14bdajO3khS9j3UVv09RhXOSRxacqb9NfxHH
         aLUM3HqIpp4QVkddfEJhy3P/t0YViN+nsiMZKYIMelVqjOfaFvMNZGWQMWTqRJ2Foi7J
         7Il5youHD7LcteBv/w9BFsWEupmLgbRCShfvkB+Wz+pNCyP3XIDIGZtCdqg3hKiaiQAn
         A9O2G1dCyT1xksbO6utlfurQRn+RmisX4UfsK7Dls3MntrlYM/YdA86CLHYI7WjZbOfu
         KZvpsPbyy/641dfbgxBIWnVHYLFMDn1CkMtWzWsQYgRws+jvk6BR8OR9dl8qOgN7RSY5
         f8PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJTDQotjVpunNLuVCI9SRZND/gyw72w5hHhrobqQvIzn9fH5+GdZQfmE68VlSsFQBjbFNhJK1AufO7RvKFN3OIHbaffduwhzxn4fsQ
X-Gm-Message-State: AOJu0Yz1tdRxn59cHZ9b5p3qM7wWUDHVh8o04XGfdta1IVm1724VdalS
	XNcSATOZ+yTmqr0/vuxyHYLk9E8oanZaKj8sdiEJIcSnhqjNi/vYesAVIyQdPEI=
X-Google-Smtp-Source: AGHT+IGlNYahWungPdY/VG0D2i+/kOzAqG/9vIEbq77BhnEO6pEhdeI5ihGxkaZBKQBmSE54SEc3pA==
X-Received: by 2002:a05:6a21:33a5:b0:1b8:622a:cf7c with SMTP id adf61e73a8af0-1bcbb727134mr2697727637.3.1718806878609;
        Wed, 19 Jun 2024 07:21:18 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6b110sm10739431b3a.153.2024.06.19.07.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 07:21:17 -0700 (PDT)
Message-ID: <e8e718ca-7d3a-4bce-b88a-3bcbe1fa32b0@kernel.dk>
Date: Wed, 19 Jun 2024 08:21:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: move features flags into queue_limits v2
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Richard Weinberger <richard@nod.at>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai3@huawei.com>, Vineeth Vijayan <vneethv@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
 drbd-dev@lists.linbit.com, nbd@other.debian.org,
 linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20240617060532.127975-1-hch@lst.de>
 <171880672048.115609.5962725096227627176.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <171880672048.115609.5962725096227627176.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_072120_984938_D95B4A83 
X-CRM114-Status: GOOD (  12.25  )
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

On 6/19/24 8:18 AM, Jens Axboe wrote:
> 
> On Mon, 17 Jun 2024 08:04:27 +0200, Christoph Hellwig wrote:
>> this is the third and last major series to convert settings to
>> queue_limits for this merge window.  After a bunch of prep patches to
>> get various drivers in shape, it moves all the queue_flags that specify
>> driver controlled features into the queue limits so that they can be
>> set atomically and are separated from the blk-mq internal flags.
>>
>> Note that I've only Cc'ed the maintainers for drivers with non-mechanical
>> changes as the Cc list is already huge.
>>
>> [...]
> 
> Applied, thanks!

Please check for-6.11/block, as I pulled in the changes to the main
block branch and that threw some merge conflicts mostly due to Damien's
changes in for-6.11/block. While fixing those up, I also came across
oddities like:

(limits->features & limits->features & BLK_FEAT_ZONED)) {

which don't make much sense and hence I changed them to

(limits->features & BLK_FEAT_ZONED)) {

-- 
Jens Axboe


