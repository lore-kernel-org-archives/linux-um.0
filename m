Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E830C25B7C
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 08:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tBOOEd8TOR03h4KUVYtMQCruGCyQqUGdbvoHDb9iNkI=; b=njtlMHbXn2F5EWZUgm6sc1MOn0
	WEhjuhCFoP3ySeFFSvJA5EmjYxYTXZBUxqkNyXvrBhPc/bodWgI7hN5OtLfSEAS+oG12HMGeIxktZ
	67CRejuYQV0bFBFAz3UwVOGjO4fzupum2UlDCvMYYjKg55MGUF3ybyT0MvM4wmdCzKCynyq2cOX9o
	KS1jKsqB8TExVUd95ap0PK3QbXo+TIy33+FsbwyJGmldGJkeAKWI1fBxNdjlR9v6BND7XX4ef+7gZ
	Ig1FrgMwDwM2SwXD6A0NpLTmWk112jzbM7rGqynYeZqXKQ86Subg7xW67wEkLYJglrCSEoDx/dAoQ
	WjpxbBKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEW2-00000003LOV-0uk0;
	Wed, 29 May 2024 08:18:34 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEVy-00000003LLK-3dj9
	for linux-um@lists.infradead.org;
	Wed, 29 May 2024 08:18:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B51DBCE1717;
	Wed, 29 May 2024 08:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058B3C32786;
	Wed, 29 May 2024 08:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716970707;
	bh=tdLgkL/G57QWDQYIQEXqBgxXMvBYXtk7Q684oBRA8MI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LtR3Oh2agCU9HURoDtBiUh7iTJLGV4B2vVD+qBUmDBqW0QyV3eFxvnbTWLYWNw50G
	 RB5F6E5jmfbwdx4YKjiEpROnk6sbnVvAIqXTJDWEejc7ZNcxGoEWiuHV14ngXeucKK
	 3MdK9HGPHlJYvUXI/8tUaQ0uLgAUaBXFpEhxviGN3usBWl1+GVSFyj7trFfsAdECb8
	 GTGIG7ne+XR/vEI89MNuxclVJdVem1+wTntjOmKx7Ai3Wvm2rt9icq/wfCzCOfhHWj
	 IZ28O7umJrgJMRyP+GPGCXscEvF3FCY+uz4C0cntcL17ACYS8VsyxIYO/y9XSQCsU4
	 hNmwuFFXE3C5w==
Message-ID: <633e78ae-eed4-4437-a6f7-e8c5e22756c8@kernel.org>
Date: Wed, 29 May 2024 17:18:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] sd: cleanup zoned queue limits initialization
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
 <20240529050507.1392041-9-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240529050507.1392041-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_011831_112113_F54D6E85 
X-CRM114-Status: UNSURE (   7.31  )
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
> Consolidate setting zone-related queue limits in sd_zbc_read_zones
> instead of splitting them between sd_zbc_revalidate_zones and
> sd_zbc_read_zones, and move the early_zone_information initialization
> in sd_zbc_read_zones above setting up the queue limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


