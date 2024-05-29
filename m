Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B06C25B7C
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 08:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ELEaihPHfH00D/fUhhic2rR3H3HJI39/rhv1FsM+pU0=; b=rLlBsW1d6QivOAyKoemTdTsjlm
	tXF7j+P0QHtDSuJ3KSwVvO9oFbXhBV5mMHB6eVYilT7Qilr9hQeB7LVhgAuZO/0DUdvTrGES5m7uk
	/bs5AWWsk6LBi7GrtxEJg5qhWgwpPyhMMmk5A0qJEjxp57lio9Cu0RXU1W7z9x7BpiOZ8TRlgFrSU
	G6pta44Cu4subu0fZkLyxYsAyPoPM3z0cZ3/jyg6dL228WVdp8BU2pD6FXVnkM9FOIpBzO322HSyE
	qpo9TFAS84deHlwLre63oeaJUfXVwLcdKpOxWfqhQmhN5XxVnh6VNhAnr4wmP/IqvDSKcjYnuMd3b
	7fEJZViw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCERN-00000003Jhb-0to3;
	Wed, 29 May 2024 08:13:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCERK-00000003Jgi-18bM
	for linux-um@lists.infradead.org;
	Wed, 29 May 2024 08:13:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3C0E662064;
	Wed, 29 May 2024 08:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D31C2BD10;
	Wed, 29 May 2024 08:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716970420;
	bh=QIo4uCV5OL7C/0lr7uj7aSJrY6ALOm2KSU2WDuE+n9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vs/JsUarWt+IojFVJmO8nf1xEFuiF80vD56DlthacWxH/uEfpxVkJo1Nrcs6QZxxq
	 Pmn0gMPmiWSbKF+Fz7knbH+rHcLuGSe7ESzyXmY7MGFw0ToZ2p3ayTMoQggCPIYWWr
	 MbIzeTTCJHYhB2LGdxbLZD0TC+R1ByZ434lytDh+Xyz5Ge0KqL5crvujQZtunoVYKi
	 Ams3qK54YyXYWj2unBULezBx87cSmwZtQ1w7qW3/AqQIfpG9VhjpHgpg/JcGjxTlgB
	 qC8UPDqbQ6kQNgqB5asVxdm9rrmo7slKA3lDydzmgHK3fffKyb9ERgIY/7/ky4cbSE
	 bwm1JTmXJj9Eg==
Message-ID: <5248688e-4832-4243-b0d3-04ef6f459aa4@kernel.org>
Date: Wed, 29 May 2024 17:13:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] sd: simplify the disable case in sd_config_discard
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
 <20240529050507.1392041-7-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240529050507.1392041-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_011342_465900_2DB35D0A 
X-CRM114-Status: UNSURE (   8.37  )
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
> Fall through to the main call to blk_queue_max_discard_sectors given that
> max_blocks has been initialized to zero above instead of duplicating the
> call.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


