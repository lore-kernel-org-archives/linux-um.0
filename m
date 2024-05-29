Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A134C25B75
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 08:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d6hJEHkEcqK07Rj/G8T5BOakWCfMNHRd0/bNCbNm/4s=; b=h9GZV07O0HQjlwrY22HAcwzguM
	i5bUpq8O5uQuGgE6fwchgCaPi7fOuEUn8vtak+a1gxcpsGVqFpud5UG+CFdzDvenwmcEvA+YTRhFX
	58SjAljSUamq8qMtZ3Bozj376p+gymBrsU0rXwI+jl6XcPLwoKB0TWsTDiptLOUHGI+H4XqYLRYnF
	fht+3hS2k9HYHB9GjM+HYH5QI8cR5xJzHdws/rB7BjpGpGMIlZ8WGZ8aDFFLH0VHgWQ5nu0jmi64E
	4dGXH0F+QJLnA5Sg90XIzr3mlcVTwHHycfWpk0tuNUO60JdouWlXViLvUeRwEkcHhVzPqxONxfvue
	EuSH9+5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCELs-00000003HzE-2sAA;
	Wed, 29 May 2024 08:08:04 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCELn-00000003Hwv-0mRa
	for linux-um@lists.infradead.org;
	Wed, 29 May 2024 08:08:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 34657CE17E7;
	Wed, 29 May 2024 08:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775ACC2BD10;
	Wed, 29 May 2024 08:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716970076;
	bh=03smAZVJ+ZngbkLzugn+0eqk3vVwA0F29enlttGAPng=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bpShr1IttagkOMnjhsCdo/g2zCZdY/J9hEgnQoOTkwd/TZHIkKASoDSf8+3m+pnEU
	 5dgEnznMnW+pmlqrkv7jTaUFTY8kya1x2kUeM5RGbZFNTb0NPcdTvktgyScpIfQiJz
	 9SYMygauOoY+shIGTFDnwWQBHpng4+D37VR3bFWoOFjpfjsD6ALyH7jGpvSUfQiild
	 6MYzCPhcHg2QsVviU+udRgGt0N3LKskHM5NeZnp90eaxAQpCTzBcjNqXPPgoNsWukV
	 tC4NqjBN6Q6n3ZjWDlVJ+cmaEz8hv6lMBRlGWijOn043mJOWWcO86EQJdQiEIrkwsT
	 sU1UkJ18oQYDg==
Message-ID: <24cad983-a1a0-4983-989d-79bcc9fd8a0a@kernel.org>
Date: Wed, 29 May 2024 17:07:53 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240529050507.1392041-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_010759_452339_067E2900 
X-CRM114-Status: GOOD (  18.51  )
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
> Don't reset the discard settings to no-op over and over when a user
> writes to the provisioning attribute as that is already the default
> mode for ZBC devices.  In hindsight we should have made writing to
> the attribute fail for ZBC devices, but the code has probably been
> around for far too long to change this now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/sd.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 3dff9150ce11e2..15d0035048d902 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -461,14 +461,13 @@ provisioning_mode_store(struct device *dev, struct device_attribute *attr,
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EACCES;
>  
> -	if (sd_is_zoned(sdkp)) {
> -		sd_config_discard(sdkp, SD_LBP_DISABLE);
> -		return count;
> -	}
> -
>  	if (sdp->type != TYPE_DISK)
>  		return -EINVAL;
>  
> +	/* ignore the proivisioning mode for ZBB devices */

s/proivisioning/provisioning
s/ZBB/ZBC

With that fixed,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +	if (sd_is_zoned(sdkp))
> +		return count;
> +
>  	mode = sysfs_match_string(lbp_mode, buf);
>  	if (mode < 0)
>  		return -EINVAL;

-- 
Damien Le Moal
Western Digital Research


