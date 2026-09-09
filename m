Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B816DC79FB6
	for <linux-um@archiver.kernel.org>; Wed,  9 Sep 2026 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O982MRz3ZnvJpd6XtX5F47jsQHnBwqKeU3GJ60z6ANk=; b=RPFEuRgtn1OBA/hJbtcvk12/0Y
	d3o1TEqIHFq9/LvyoC5PPq+6/cEyqS2DijTmzpBgQsBTbySyibK9ibGJDVkVsvvjVyw7oASK7rU4x
	Gfr6B67JqmfEOH7AH9m9m2zx4BLTvYRlCab+kXANl+aNaVUvryg+LEKwtFhSciT2rvKH6tZh7IyqM
	vqEDSqpOvVaVwxsubhHgbK8RenMZ5cHLWjMLzD2rZvUr65wpcqT/Cxf/DGuOP31apmUjg8rI8wfKk
	sbYlyz74QViWmUuuvfBKk+rLA9LTIvMOPJgs0YfHHVBEg5KEo4QxAmUv9HcTzLOdTTS/65jXl1AyL
	CLbjty+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4KYF-0000000CEDZ-3HWw;
	Wed, 09 Sep 2026 15:49:31 +0000
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4KYB-0000000CEDO-0kNL;
	Wed, 09 Sep 2026 15:49:27 +0000
Message-ID: <62c2095b-199f-4646-b3a8-b52fdbea36a8@infradead.org>
Date: Wed, 9 Sep 2026 08:49:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: UML: user_mode_linux_howto_v2: Fix bracket
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Renzo Davoli <renzo@cs.unibo.it>
Cc: linux-um@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260909140051.1365758-2-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260909140051.1365758-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

[adding Renzo]

On 9/9/26 7:00 AM, Manuel Ebner wrote:
> Add missing ')'.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
>  Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index 9224bea5e..13acac1c1 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -580,7 +580,7 @@ https://github.com/virtualsquare/sshlirp
>     ``vec0:transport=vde,vnl=vxvde://234.0.0.1``
>  
>  connect to a local area cloud (all the UML nodes using the same
> -multicast address running on hosts in the same multicast domain (LAN)
> +multicast address) running on hosts in the same multicast domain (LAN)
>  will be automagically connected together to a virtual LAN.

I would put the closing parenthesis at the end:
                                            to a virtual LAN.)

@Renzo, comments?

>  
>  ***********

-- 
~Randy


