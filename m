Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04223C25B7C
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 08:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tjrwQjoyCY0dCJ8119HoHoQUzDelBWJA1jBgFRi0PLo=; b=oc80I2Wh2q84L2jbKX9AOwpv71
	6f9TWJAdli9rJ8TmX0ilYySgQHrHJm/IPalaB4oLabpBuuXz/gNXuEbAe7BFmNu3diltN+7pJDYRR
	fHtwMxZUGllPMzFFoPCIuvcTHVbJ++oJAEgB/JI9QcGBxZgW8WhkEHidBWh0GW7z8SqEkKujRJxJ6
	Oot+TbbTf0fqYQsCAeAuyXmLa7DYgiLsra4gVEDpX98alo0/q1OPvDGgN+eSMs4oPYZwagFc10tGF
	LbuPN9G711GM7+aCc6YUW91pKfbMcGbnTI0p0tyPArOoARcxvbUp93Q1FmJF6qM3IcSFNUvDekEMe
	ydoVEEjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEcY-00000003NQl-2lQN;
	Wed, 29 May 2024 08:25:18 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEcU-00000003NOs-3dkj
	for linux-um@lists.infradead.org;
	Wed, 29 May 2024 08:25:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id ED81CCE1185;
	Wed, 29 May 2024 08:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34391C2BD10;
	Wed, 29 May 2024 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716971112;
	bh=68h8q5F+j4pjKEcxNZSHuDAUqZpgnW57uKiQqJYjvXk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cqyEaNLJFYd4VgaxK4xOgO1fLB7/V2NkEYcZNMj3ccG2Mzvpp61LRxO5H4wNFOXas
	 9i9P5vApYqzNiVftsPqH6+3ivxqZDbQQpXB9SIohRK0TdnoPp833Z44jgkjFhNZuhY
	 BGPG5IuhLO8Vo39srFS1asTLrRf87QTWOJrOiQEM6H9VY7vVFKAL0M8AaZGrySb+3e
	 wtua7SU6aKnlakSQaBr/SFZqCqkbfJyWm4sHhHK/vx2ZqIcj/ebCP9P4hluFoJ78kb
	 xa2RVmjSw0F9dLWXjsdQcxM1ZvFiEoX8BWzuuviifbIpZoK74eW2DiuDsdsaVYZzqk
	 NPfPYWCoLxCZw==
Message-ID: <1048ffa4-36bb-4d72-9abf-a8e2dfc874c2@kernel.org>
Date: Wed, 29 May 2024 17:25:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] sr: convert to the atomic queue limits API
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
 <20240529050507.1392041-11-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240529050507.1392041-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_012515_114801_79A11F5E 
X-CRM114-Status: UNSURE (   8.63  )
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
> Assign all queue limits through a local queue_limits variable and
> queue_limits_commit_update so that we can't race updating them from
> multiple places, and free the queue when updating them so that
> in-progress I/O submissions don't see half-updated limits.
> 
> Also use the chance to clean up variable names to standard ones.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


