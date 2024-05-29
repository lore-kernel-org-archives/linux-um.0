Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC77C41513
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 08:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WhT7vPzxtNXfJ177esJ//rKkzjj7fQm96oIYSEDxdaM=; b=YSfoafGfkrCIC+1nEmBa0mbNyD
	bZ0/MJuiyIOb75Wip9XHtOIAIDsOVWH4JnP3dHpwPdF8ZM57vkopRD+eYI+Qa1b1FgKZV/kq9Y4Oa
	qE2WLOU+vRVpetG3P0OZEHRbbbwaDVMfsWolJadEWM7zXr4vaj8hqx1d39s3UNqBc2BP98jOihHDp
	x7bCbABxTiZjOxrwi91pk1EiaY8Doek6kNog8LM73S0AXiETAxff/iWMRp5VCQY7VMSTuL0x8BxKf
	uDKZSlybNwU35QRhu1GliKx20rS0xLe9gjgnydupx2gksO0HvV647F5XWDRCUu+qbPUdCFVIKNYV3
	9ucZd2og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEhz-00000003PCa-1eLV;
	Wed, 29 May 2024 08:30:55 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEhu-00000003P9r-3hUG
	for linux-um@lists.infradead.org;
	Wed, 29 May 2024 08:30:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 47202CE1665;
	Wed, 29 May 2024 08:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC01C2BD10;
	Wed, 29 May 2024 08:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716971448;
	bh=okobbeHOzXq6ivMGxWAQOlHqPIeKQZDwNC64vcjjQ6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oJHg4EaC6VLoBZLA2tkfhAXWRViSHX90IfPOto1y2u0MBzS2lz8peI4cgrhwJmiR6
	 j9IGX6ydtNHZbJidgJPmMLDbdMXz0lQ2SjJFcgOj/ZzOZSBuyzHMbC9X6txlhFCKjq
	 zicWj7/lpaI7DNz0gaj1s72zKODzpr9MW0uRepDVL9LHZlHfiRvRJLXPYCR5+1kuWl
	 1WzRU4j7uDZm8UVS5ixrUgADkNSKzvq4M0wIXGo6299fOfN++X+wdoS1ukfz0V0jSB
	 OymHRmFQtxJAOdroVyR9aNThRLSfqkLHyDmmUaVQP0WnD4PbxrI2HzlwMAzSkKWaIa
	 Mi/WLM+Dn9sPQ==
Message-ID: <cf5628a4-50e5-4397-9633-c00a3df2a2df@kernel.org>
Date: Wed, 29 May 2024 17:30:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] block: add special APIs for run-time disabling of
 discard and friends
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, Josef Bacik
 <josef@toxicpanda.com>, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 linux-um@lists.infradead.org, linux-block@vger.kernel.org,
 nbd@other.debian.org, ceph-devel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org
References: <20240529050507.1392041-1-hch@lst.de>
 <20240529050507.1392041-13-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240529050507.1392041-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_013051_136573_44E97C99 
X-CRM114-Status: GOOD (  10.29  )
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

On 5/29/24 14:04, Christoph Hellwig wrote:
> A few drivers optimistically try to support discard, write zeroes and
> secure erase and disable the features from the I/O completion handler
> if the hardware can't support them.  This disable can't be done using
> the atomic queue limits API because the I/O completion handlers can't
> take sleeping locks or freezer the queue.  Keep the existing clearing

s/freezer/freeze

> of the relevant field to zero, but replace the old blk_queue_max_*
> APIs with new disable APIs that force the value to 0.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

With the typo fixed, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


