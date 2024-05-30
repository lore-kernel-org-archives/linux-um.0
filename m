Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AB5C25B74
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 20:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+yfFxI5vXGgBtiGU+D99/ljEG0kpvZXmxQcSkudrr9s=; b=RNQ/++yFuujBnTWU02eG8CmWRj
	RPL1/ft+/kTAtxMtuD0+l6+BR/WEDqzE5SL/WLNY32VZ5dqD0UPCkSidy7EmrwtI9HRW4S0fR6Yc4
	HZOKrjixou8njsyr0mpURHWL0fOGC50+4tfJinOMTSKGs0DtjivkWb17/lNMRl/Cygckhqh+q52BX
	R9eTdmJe9ogHRpVzpwZw02ksGAMUSicp0rQLi0WLxJ5MZlPPDwY6Wp9jhakDudx0oQJ7hFKxfl6Os
	NUTmityjRzc88Zmfyo3X8x9Z+e/B+MmS+TBzn5ocnJNsn55O9/PwEcl+rEIxZlYNDSC+93kfEogL7
	d01ZhAlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCm3k-00000008IW8-1o3K;
	Thu, 30 May 2024 20:07:36 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCm3h-00000008IUo-2mKr
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 20:07:34 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vqy352wXTzlgMVW;
	Thu, 30 May 2024 20:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717099644; x=1719691645; bh=+yfFxI5vXGgBtiGU+D99/ljE
	G0kpvZXmxQcSkudrr9s=; b=SqjKoZZdpT4MNXYDyRUM4JuIL15+lNbQrcfJuZsH
	5i+fsrz5hnUl5DlaKW9QovdJ8SbgPABGz/lXk+zTUX3IvVSOZF4hWm47ReZABvHU
	1s1mscyI3oBlHP5Trs1lvEnLVrL3MR78iVb0m7+89cOwsGpuvycL4ADEymuw7yOK
	9MD9bMpEl08HInq9MOQgt8+vi3M9lBRE3UqeLb9J4kdp+Fh7/qcGLKjRlZCsb8Bx
	RHiqCZS/DM7HHcWymvBmLE2Q9l8U7sARF6UgjfX76g9qvw1SryWswVnTVCdSLau+
	ynch4c8cn09wBIf16ogwWgDF+qVJWH9byKOSFXu+7Qieag==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rlAwti_y4elY; Thu, 30 May 2024 20:07:24 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vqy2z2TfbzlgMVV;
	Thu, 30 May 2024 20:07:23 +0000 (UTC)
Message-ID: <53fc8442-e27b-4e05-b93e-7b39b9146cce@acm.org>
Date: Thu, 30 May 2024 13:07:22 -0700
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
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240529050507.1392041-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_130733_756444_C34A0FDC 
X-CRM114-Status: UNSURE (   6.93  )
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

On 5/28/24 22:04, Christoph Hellwig wrote:
> Consolidate setting zone-related queue limits in sd_zbc_read_zones
> instead of splitting them between sd_zbc_revalidate_zones and
> sd_zbc_read_zones, and move the early_zone_information initialization
> in sd_zbc_read_zones above setting up the queue limits.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


