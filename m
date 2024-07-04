Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14650C30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 06:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yNVNsBn8ea+Cly7pLstkqf0C9cFB/u40kSRJIhuu1Gs=; b=vOL8kIl0A6d0x1imWIngq+sA4N
	FVOPiamZCu1hPv5s/vB64ejSFqT1qC2/CvE8w6BBEfn3gHkfmZMl1HeZb3cftVz1dtRS7X6EBZEU2
	F3jHdJ/gybTgZfqq5xQ/87BvwxswQfYxA50L0BjVhNQ+8L2yPLyrbmyB1nFNj7hNySDaIyrZvNt69
	HjQYuAj7B8cRxaZsjsTEWIhXOU3u0exnegWkTPDz+5hh52vI9MakqzCB/37na9/8UNuD46jo2W+/r
	+VDwlCq9pP4viSS9yjYSjFkm9s3lYLHR5tBv4z4qjDFFwK1zkjq3/LDcNWE2xdO1srRkFZ147u6gw
	eIRyneWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPGQI-0000000COrq-3GQM;
	Thu, 04 Jul 2024 06:58:30 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPGQF-0000000COrL-2cWw
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 06:58:29 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sPGQE-005c6d-3x; Thu, 04 Jul 2024 06:58:26 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sPGQB-0079I9-1y;
	Thu, 04 Jul 2024 07:58:25 +0100
Message-ID: <24db44e6-a02e-4b14-ab2d-cb16a8273a8a@kot-begemot.co.uk>
Date: Thu, 4 Jul 2024 07:58:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: line: always fill *error_out in setup_one_line()
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20240703172235.ad863568b55f.Iaa1eba4db8265d7715ba71d5f6bb8c7ff63d27e9@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <20240703172235.ad863568b55f.Iaa1eba4db8265d7715ba71d5f6bb8c7ff63d27e9@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_235827_701389_0B9DD029 
X-CRM114-Status: GOOD (  12.59  )
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



On 03/07/2024 16:22, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The pointer isn't initialized by callers, but I have
> encountered cases where it's still printed; initialize
> it in all possible cases in setup_one_line().
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/drivers/line.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
> index d82bc3fdb86e..43d8959cc746 100644
> --- a/arch/um/drivers/line.c
> +++ b/arch/um/drivers/line.c
> @@ -383,6 +383,7 @@ int setup_one_line(struct line *lines, int n, char *init,
>   			parse_chan_pair(NULL, line, n, opts, error_out);
>   			err = 0;
>   		}
> +		*error_out = "configured as 'none'";
>   	} else {
>   		char *new = kstrdup(init, GFP_KERNEL);
>   		if (!new) {
> @@ -406,6 +407,7 @@ int setup_one_line(struct line *lines, int n, char *init,
>   			}
>   		}
>   		if (err) {
> +			*error_out = "failed to parse channel pair";
>   			line->init_str = NULL;
>   			line->valid = 0;
>   			kfree(new);

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

