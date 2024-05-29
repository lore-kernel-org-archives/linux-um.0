Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA50C25B75
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 08:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JrfsEdqW8t76QkNdfni2MJDPPhUidWHhl2UbrZhcXvU=; b=EZ+Q1VNShBZ8nf35brmmmEE3OV
	N3C6ePfyjv3t+NQ5nZZh4WYLIcR7q0MB2MO2UnQadPeKsOijnxHMwj4IWQVymJU+u42ARFTVSIDkw
	kg2wUxR1r0/FG5PH18w/uD2iVPAq7Xzbr4SJdRfYUlsK/rj5z7Xj9LTaxO4dY48Ytz6IG4wnSUw4V
	L0rvPxCzpCRKPf8GV1CbIYAElRR13+cMILiwJ8f+JoRrS3RQlTdBGhWd5V0JKkdOSLMs1PTlhkE3T
	SyXBviKRD6CtIe7OzNG1sz7K95vScZ5lHjnVIfTBaKqxN7oa6Q3aHjfkrvWbH3DKXdBgYeEeXO7SI
	nZGdcK0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEQ5-00000003JMl-1NOi;
	Wed, 29 May 2024 08:12:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEQ2-00000003JLp-19jy
	for linux-um@lists.infradead.org;
	Wed, 29 May 2024 08:12:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BFBE9623A4;
	Wed, 29 May 2024 08:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7666DC32786;
	Wed, 29 May 2024 08:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716970341;
	bh=6hbYxOsQLA742vo6TjIi/DCNFqZKNxvrO5GmFHCpV44=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R5mS/igRnNYSuaOU/WungJiFXByfPmU52aV3/8lDlnahx3fw8xYGEgm9I0GwjGMLI
	 rxgEHuZC8FN59Nts7D7mlYOVBxUtXbONIbSuFZA/nsChkRReh17QPPy3Nln5IcP01O
	 bsT5Xv1cO9MaQHL1Y0r23CFCdo5I/pmKCJKFQuVPp2FGd5eU3g8CUn1vaagml+SwH/
	 VFaQ6/MQ6XcCtKYl3ZsNtZ6oahfm06jpUk78jThj1RR2tPWitAJRbqdrAgZ8cH96NI
	 HA2Qjk0f15qnfydLy1JSV5a8XNMA+v8I41uKRHJ4B+z8Gf4xJOm2ZPo9UslIKFHhn/
	 xR//bL6vRZCpw==
Message-ID: <dd7a2835-8c38-4b52-aaea-f80064ccd22b@kernel.org>
Date: Wed, 29 May 2024 17:12:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] sd: add a sd_disable_write_same helper
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
 <20240529050507.1392041-6-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240529050507.1392041-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_011222_401654_7115F523 
X-CRM114-Status: UNSURE (   8.39  )
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
> Add helper to disable WRITE SAME when it is not supported and use it
> instead of sd_config_write_same in the I/O completion handler.  This
> avoids touching more fields than required in the I/O completion handler
> and  prepares for converting sd to use the atomic queue limits API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


