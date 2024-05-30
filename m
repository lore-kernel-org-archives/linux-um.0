Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C79C25B74
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 20:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HAP2WXDhccKrBY2e7nb7eVhKKMZLSAfPEEOn8QVjvBM=; b=STe+NNZF1v+1kW1ExPjzHJp2lY
	8sLxEubCLWmg/yeNEYSGwCafb26ui56FxorLx1O51K6Vvv5YY3XSzPi3z6FS2RL7jh5vK1O9hjtqc
	DM8YGgSPykN5ufLSHnsgrT77B8jGjpT1G19ZFJI9fDdgx5ZkRgYOl4vhJxlEfbIS3OUEvqWtKb1il
	Xrdf6ES1Vk/bUCtKp5O87mPId/FowLn3jCiWAkpXXkA0GY0CrSn0Jln8ZqiRoNcGq/so6aOzbqyPX
	BRf8KJNBFI7kJeyoCtsdwm/yy7Q2nTRbX9Bg8SlFhwVZhPAJXsGWmMJ94/BlsrZb9bDV5Qs6+Fp7c
	L2sqBFuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCm4S-00000008Ifm-0GH3;
	Thu, 30 May 2024 20:08:20 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCm4P-00000008If9-29dD
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 20:08:18 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vqy411LtgzlgMVW;
	Thu, 30 May 2024 20:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717099693; x=1719691694; bh=HAP2WXDhccKrBY2e7nb7eVhK
	KMZLSAfPEEOn8QVjvBM=; b=obeHdmp9YsUXuOZQLqScMEmH6Ih7ZfY/4iMCkRPI
	LYigt/zOg1B/psGhSXL1A6Nun9Xb4ACnTmneav70Y/d2lCEMW1iyAULS0JOi7N+M
	4D0Z++5JAW5CvV9F2QsCWiTxD25HQJrjl8jRDIIicgxUnyiQBaH4qocTpaXWsRpQ
	NFHwx9+r/3FZrmIkDJAMiSIYHaIZ4Dz1EiaeUipwbed35LdTnRzrbsLX4Btd/RQ/
	RHjxP9YfAad0XG4VPmEW2MotDp1hU4Cf4txtLNGvfUWjW59v/jqig6nN1/pf0pbD
	Jb5Rn6a1EQX7UKGspz9POkgxHq+rMXXDAO1vlh1wffB6ow==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1HkePWDZ3j6e; Thu, 30 May 2024 20:08:13 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vqy3w21PZzlgMVV;
	Thu, 30 May 2024 20:08:12 +0000 (UTC)
Message-ID: <f4bf4ccd-04fe-4067-a658-270887abb50d@acm.org>
Date: Thu, 30 May 2024 13:08:11 -0700
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240529050507.1392041-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_130817_595634_77580CBC 
X-CRM114-Status: UNSURE (   7.11  )
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
> Remove all APIs that are unused now that sd and sr have been converted
> to the atomic queue limits API.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


