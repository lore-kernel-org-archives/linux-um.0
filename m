Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D43FC25B75
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 08:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I6Ry/uCcqfBxXPqvbNbAQhQOTnAWUNrxN/iL2wfCKtE=; b=MC92WeG96pgEoKyyDhTWN7UdwC
	iDar+zmY8qwAhSVge5HOTQFwI3cjXh9uW6EA2rtvihCrM2lbUNW4Oc62hOJDQt6Dhfu9bXkrO5MDd
	jtlQ0ITNOaUW8dt5HZL/fGHckmfOBPF0AKpiXPBn0YeZT4x5zDzeI9C3M/ZnqemBJParoMLYpYX5J
	94oLfc+O6hRHOqtseZ0oLlbXFAOBeb/EKYw+mt/cVHh7aObTXS2LH2gXA0/9uefpbV9Zfb6sg57aK
	t7canGQNV49tcYTI93vT3YRcY5f8TmDz9bV7A47AhdGjq9Ecm0l0DqU8LqYpySBmb6D7wWutFDP31
	7yzkJ2gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEbB-00000003Mlt-1L5Y;
	Wed, 29 May 2024 08:23:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEap-00000003MZg-0bbq
	for linux-um@lists.infradead.org;
	Wed, 29 May 2024 08:23:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6A932626B5;
	Wed, 29 May 2024 08:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C398C2BD10;
	Wed, 29 May 2024 08:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716971008;
	bh=UnLzeIpjO2H8DXobwx0iVT/QPf6bQElmv5UNVtEUT0A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O6oJdroelTELWIStQcjdZBa8C9t0BA8C42VKn5vNrwvO9ZdR3rUrwH3ZLwjFFK0Oe
	 HhiPBOH2XVUERxnnGQ6s891sk9q1DG/PnFL0LkBDnOMmP+BS9Xidu7ZeyiJobkI7Mc
	 aurytkNHgMhSMIO6KEtPbr+B/Lm3Ypkam7hGJBLyD18GZpSe9Cj5EF1Kb2puX7kRs5
	 KKnc0fqXHQGePuNkSVkdaId1TdYlGbhhiavhXQgTW+r4g12/5y6OeB3rzT9MZESuNJ
	 vPo1fpxXY6E38PJ/CvZgo2QxoMoClT9dhzC5WZl2dJPLzL0U0DaPQ4DmDMx98s5JET
	 LA3uCxbs7kWag==
Message-ID: <5e23755e-2473-46e3-98c4-1a1e3fb8bfdb@kernel.org>
Date: Wed, 29 May 2024 17:23:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] sd: convert to the atomic queue limits API
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
 <20240529050507.1392041-10-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240529050507.1392041-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_012331_514363_F4E93C18 
X-CRM114-Status: UNSURE (   8.31  )
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

s/free/freeze

> in-progress I/O submissions don't see half-updated limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

With the above fixed, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


