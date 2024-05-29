Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58100C25B75
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=td/mUnvGAjJDcWSs3tGvSHgb5DJpa2lkOlDy4HPIdVk=; b=nRBc1IXZT1pmcOqCfuH6chy6Zf
	VoP121AQFMJWTzBhzU9s8zexo/wFY4WUZJX5Z09FLiyTKjSqod6nIUkewh8ue6eB3kn0rCq064YxD
	LwMpR7dFmE+Wm6wpMoFSvTK7a0dK13iMqJ+ycOGWasDzwqmq/8ChI+lFa+g5eVx2ZifJE2nIMOJqF
	u/QpXOcpUTH4ngl1vm6SMJEZiR8cPZiiRS9iqLKe+GXO+PpfmDixe0O1Rr81EMuRrL+GVmEFyM8aJ
	M5DmhBCbASBrRuX5qTdDlvGuseC5Rrz5GmZBqoYUG1yf7Ccg9IiInINlWTccsop2w/HfP4CzTnuBF
	sd/nmUXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEfS-00000003O1h-2n8C;
	Wed, 29 May 2024 08:28:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEfP-00000003O0v-3ymd
	for linux-um@lists.infradead.org;
	Wed, 29 May 2024 08:28:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0AABA62064;
	Wed, 29 May 2024 08:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF68BC2BD10;
	Wed, 29 May 2024 08:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716971294;
	bh=4xLTsI+g+6PM4GZdcp6tkOURF5lktb+4fm2gix3vClQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=creCoCfkg1r9P0k8mhbQwfgzqAswZmiHcWn5Bd1MuoZI86SxYC6hCoH0KS7axJpRP
	 T5h8NZUH+144AFLShb1Ye209bRfiGKQfICluAxPCjIl31GxjbCY/ZZO9BCNN2JyPxs
	 KI2ckBHEkR0/WvEE3z6RgUJOVV2nWrAL1xRk0dgjzNMb2/4WydlFDV4Vv9Q9Exms4t
	 zw1nCtAcJ7pSBxyqVgpFzXBd4oJqfsn4Md73ZGniohT92LzP2SC+w4HfaZP9jPfdIk
	 B1KifcBYlefe27lPs+SGjeRu5o3YScEpjkE/6WSWgxZ1cgJ6Uev8aMv3ZeVlm9xQqD
	 86KgS37/4vtFA==
Message-ID: <89f98897-bfb4-48d1-9b60-d793fde9fade@kernel.org>
Date: Wed, 29 May 2024 17:28:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] block: remove unused queue limits API
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
 <20240529050507.1392041-12-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240529050507.1392041-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_012816_059389_355499CB 
X-CRM114-Status: UNSURE (   7.43  )
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

On 5/29/24 14:04, Christoph Hellwig wrote:
> Remove all APIs that are unused now that sd and sr have been converted
> to the atomic queue limits API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I think that disk_set_max_open_zones() and disk_set_max_active_zones() can also
go away.

-- 
Damien Le Moal
Western Digital Research


