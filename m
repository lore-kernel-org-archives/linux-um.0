Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E7CC25B74
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 19:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dyGzZSWLsyackA37XVq9nl023b/Svu5aWeAkdF5uPBU=; b=uZ3j8yrpibA949a6+tgbBndOQc
	3dHk5tFEHjc0sJQ0CMH2pVFxiIWFueoCOzPwTQ+8cPhvYXeoSYKBWabiDHIOHdHPsTOIT6qO3eatD
	5hzxxdHw2djlmdVWEaCZ69OKEmGvJB7ftURO0z+xvOFAz+Afhv6+2cj9HF004nNESEMVHucVMnrus
	RuRTxGl0wQ2KIJTnGKl/gPEB4b/ZRlCuC6aChf+yZ+4GVH62Yb3i0vKOC1z+tIDd1DvpbvWamgeLN
	NVEwynUpdEhQeBkt9kGOk8h7T5vQ90sdchr/kpUyEQ6wrLDp6/86Kx+x6eIe+Wy6ipujujaHvgmCC
	sUWg0FYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCll2-00000008Gkt-2rE2;
	Thu, 30 May 2024 19:48:16 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCll0-00000008GkI-2Y7F
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 19:48:16 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Vqxcs6krTz6Cnk9T;
	Thu, 30 May 2024 19:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717098489; x=1719690490; bh=dyGzZSWLsyackA37XVq9nl02
	3b/Svu5aWeAkdF5uPBU=; b=rGDN10KGvDcmbfFgFHYGEoAseaR0fagJcQ3Kgqep
	Lubtq290OW2C91K9XeG9czurQf/wRzgWunDsFsAMxwo9wkZ+qvmKm4R0a1IhEFZs
	mDWx9FVqmwxJ1uh0jSOQryGjPbUDq3am1SqtPcwOYoYJeBhb7NS+0SA896mRwdax
	46is36KI4H8l2gh+0pU4iA/zQI9dYtDmKkBX014QQbhNpPugXqH9dZ3vHZGJc29x
	QNtcdSGsqF3KHp+AUYXr1LTxQON8ZUdXzrzE864yWEALccGzPTaLHZ74IyVMr54h
	4/Z8+E6et0bHB2aWboLglX7RhsaK/9E7/5fftwo1zhVw2w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ZPBeIfQpf7PL; Thu, 30 May 2024 19:48:09 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Vqxcl3Zhlz6Cnk9F;
	Thu, 30 May 2024 19:48:07 +0000 (UTC)
Message-ID: <55cbf9eb-a52c-4d1f-aaac-5d426b60d436@acm.org>
Date: Thu, 30 May 2024 12:48:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] sd: simplify the ZBC case in
 provisioning_mode_store
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
 <20240529050507.1392041-4-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240529050507.1392041-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_124814_755228_6FB7F77F 
X-CRM114-Status: UNSURE (   9.30  )
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
> Don't reset the discard settings to no-op over and over when a user
> writes to the provisioning attribute as that is already the default
> mode for ZBC devices.  In hindsight we should have made writing to
> the attribute fail for ZBC devices, but the code has probably been
> around for far too long to change this now.

If Damien's feedback gets addressed, feel free to add:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


