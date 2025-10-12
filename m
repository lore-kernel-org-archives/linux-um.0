Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05183CCD187
	for <linux-um@archiver.kernel.org>; Sun, 12 Oct 2025 15:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AsZBCHDpjPnDyG10nk7FYMuNUry3QIymQfwNVLRl4UE=; b=qgbfjEfJx/Q5xrxgDxCbdOnvLH
	YOhJ1hZeU/f/Eq3wclSGwgdl2tr8KgZkH9sTU1I3sy0PlBllTUJFQCU2hhrtwm39eyu51zlXHrfnI
	hcQ0mxiIJhafX1J3kXCRFQFKLpFN9My/U0FvZG94ZtrbwTcI7MAdvS8p0iEpkQ84fHsfLgpS19xwu
	i922TVdHR+3RJ1p4Q5FC9ekRQYlJyYEOeC4y3v+DldrvMRhqLTCI+ccv6ywAPRP8xZfylJvPm4t6N
	muUOCkzjfpFO2oujPeuAMIvR9B10i59v6y5XfRPgriUksRADEtjyUUv2XelBR3ZrsOQrvZeuvr/lv
	A6V4X0pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7yCT-0000000BVET-2xpP;
	Sun, 12 Oct 2025 15:41:33 +0000
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7yCQ-0000000BVE3-21i9
	for linux-um@lists.infradead.org;
	Sun, 12 Oct 2025 15:41:31 +0000
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-7ae21804971so1243460a34.0
        for <linux-um@lists.infradead.org>; Sun, 12 Oct 2025 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=geoffthorpe.net; s=myprefix; t=1760283689; x=1760888489; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsZBCHDpjPnDyG10nk7FYMuNUry3QIymQfwNVLRl4UE=;
        b=Um4c+sOQLG76H1y12pQYvJ5gyIAn/C6cwj6kClctBSxD/W7zPx/ltDFZdAdhxWhxdp
         kCIW43sNokRIwCoO6VA9y+Hbn0CDBZ2KnQ8xPFmWEyxsMb18rnsnmdoxIXONXWbUtc/S
         KItaZdKbEYwQJZ+E5RySBU++Ef/SbJMajpq/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760283689; x=1760888489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsZBCHDpjPnDyG10nk7FYMuNUry3QIymQfwNVLRl4UE=;
        b=KP7FAgVNQHNzRWoqZdFLIm3fXi723nTjfONjEbzaSfzcomIg5SVMKK7RXnToc/KVuR
         2/zxr6sHt7xRWHaybQvTY3Yp/Qak3aumyLLrE/coJwG4b1X7K1rEfyWXFeKGGQH9/dEf
         0JbvYjnm8ekmr3e5af2vMzVvgcV8BaLscbmYfYg2N2TbAqZv3J5PM0jCEJw5YLkso9Zp
         EaG5o8aUhchQCqn8EqB3xFCq+aCEuX3GHdrxpiX9b6YkuUa9HxC+fws/mldgmX6N/fcH
         1ny6lAIg4d6zh5wPleCWQ5O1UbQd0vzlqxmh3JWPXCgCrJSnePbbZDVkekOI8TzEUqeX
         H31Q==
X-Gm-Message-State: AOJu0YzRRrCeGBhZWS8qU9+CQilyy6wOKUic3aSl39IgAaDr0MIaHQIb
	OBEdL87ADpDHqgu8GwXMwKQOZdQ/x74yhbKYbcan3lZ5k9oB0Vhrq6RHY5rRiccLXJc=
X-Gm-Gg: ASbGncukFZkYRfyVdpQjlsiR6zy8t7MIYb0Fot1cd12B3XBbUwAW8xhlOIG/8K8+FSI
	Kz7e+U9cBQnxqSLPaSAxwYISWtFdZwuxgjDjqFxTP5l+i6dWNSEwEs64rB6AGnfvGC3PWLZ+gds
	exyPbMJgXFQAgJKcw3K9Czrg5bzjfcAmH0B42eUgwcjMfol2OpoYOhaXfy6CJxcLaiH5NLTefCQ
	wp3oTFXpSvpbZIpFmvK+md09uUM951EhaP0yo1vu4z0FsBt2J9cl+cF/tXR8g7r76FZb4TQEvOu
	++eptUiIZ9asqxJfZh8CbeBTzsi1pyCHAWHO6idpHH0S1DYdRWeZIjPpCWtUOczGpREGWxIgkbX
	VFGVR75p7Oq4NkPlah268c72mjLGXQSvgAPsIRPOsvYR2JtfRgHH0A/KR2t6SMstaV5LbCyg=
X-Google-Smtp-Source: AGHT+IF9NDY+8m6VpMu3v6jH/T/LAqqWGozqjs1br7mm7E9KlJ1VI3+VPNzQbbC2rM2RglpwUwSs4g==
X-Received: by 2002:a05:6870:3647:b0:365:6984:3d6 with SMTP id 586e51a60fabf-3c0f771946dmr7588916fac.34.1760283689032;
        Sun, 12 Oct 2025 08:41:29 -0700 (PDT)
Received: from [192.168.0.120] ([201.103.139.132])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8e80a38sm2722404fac.15.2025.10.12.08.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 08:41:28 -0700 (PDT)
Message-ID: <100e0c55-a016-491a-ac41-89e640851771@geoffthorpe.net>
Date: Sun, 12 Oct 2025 11:41:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostfs: Fix only passing host root in boot stage with new
 mount
To: Hongbo Li <lihongbo22@huawei.com>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 brauner@kernel.org
References: <20251011092235.29880-1-lihongbo22@huawei.com>
Content-Language: en-US
From: Geoffrey Thorpe <geoff@geoffthorpe.net>
In-Reply-To: <20251011092235.29880-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251012_084130_632626_1F300766 
X-CRM114-Status: GOOD (  18.38  )
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

(This time, responding in plain text so the list-server doesn't reject. 
oops.)

Yes, I've tested your patch and it has fixed the problem for me. Thanks


On 2025-10-11 05:22, Hongbo Li wrote:
> In the old mount proceedure, hostfs could only pass root directory during
> boot. This is because it constructed the root directory using the @root_ino
> event without any mount options. However, when using it with the new mount
> API, this step is no longer triggered. As a result, if users mounts without
> specifying any mount options, the @host_root_path remains uninitialized. To
> prevent this issue, the @host_root_path should be initialized at the time
> of allocation.
>
> Reported-by: Geoffrey Thorpe <geoff@geoffthorpe.net>
> Closes: https://lore.kernel.org/all/643333a0-f434-42fb-82ac-d25a0b56f3b7@geoffthorpe.net/
> Fixes: cd140ce9f611 ("hostfs: convert hostfs to use the new mount API")
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/hostfs/hostfs_kern.c | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index 1e1acf5775ab..86455eebbf6c 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -979,7 +979,7 @@ static int hostfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   {
>   	struct hostfs_fs_info *fsi = fc->s_fs_info;
>   	struct fs_parse_result result;
> -	char *host_root;
> +	char *host_root, *tmp_root;
>   	int opt;
>   
>   	opt = fs_parse(fc, hostfs_param_specs, param, &result);
> @@ -990,11 +990,13 @@ static int hostfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   	case Opt_hostfs:
>   		host_root = param->string;
>   		if (!*host_root)
> -			host_root = "";
> -		fsi->host_root_path =
> -			kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
> -		if (fsi->host_root_path == NULL)
> +			break;
> +		tmp_root = kasprintf(GFP_KERNEL, "%s%s",
> +				     fsi->host_root_path, host_root);
> +		if (!tmp_root)
>   			return -ENOMEM;
> +		kfree(fsi->host_root_path);
> +		fsi->host_root_path = tmp_root;
>   		break;
>   	}
>   
> @@ -1004,17 +1006,17 @@ static int hostfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   static int hostfs_parse_monolithic(struct fs_context *fc, void *data)
>   {
>   	struct hostfs_fs_info *fsi = fc->s_fs_info;
> -	char *host_root = (char *)data;
> +	char *tmp_root, *host_root = (char *)data;
>   
>   	/* NULL is printed as '(null)' by printf(): avoid that. */
>   	if (host_root == NULL)
> -		host_root = "";
> +		return 0;
>   
> -	fsi->host_root_path =
> -		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
> -	if (fsi->host_root_path == NULL)
> +	tmp_root = kasprintf(GFP_KERNEL, "%s%s", fsi->host_root_path, host_root);
> +	if (!tmp_root)
>   		return -ENOMEM;
> -
> +	kfree(fsi->host_root_path);
> +	fsi->host_root_path = tmp_root;
>   	return 0;
>   }
>   
> @@ -1049,6 +1051,11 @@ static int hostfs_init_fs_context(struct fs_context *fc)
>   	if (!fsi)
>   		return -ENOMEM;
>   
> +	fsi->host_root_path = kasprintf(GFP_KERNEL, "%s/", root_ino);
> +	if (!fsi->host_root_path) {
> +		kfree(fsi);
> +		return -ENOMEM;
> +	}
>   	fc->s_fs_info = fsi;
>   	fc->ops = &hostfs_context_ops;
>   	return 0;

