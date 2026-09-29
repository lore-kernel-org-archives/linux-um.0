Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BA5C9832A
	for <linux-um@archiver.kernel.org>; Tue, 29 Sep 2026 06:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=02wBacn/5Rib87FHKIB9l+9dtE7aqkTEx0Vx9kxYemM=; b=cWWKaiHivlAHfJqdgMmMbXGzXI
	zI4mnrYrT49+jls5V4eXyhj9/pNXHo7ShuzCbP7GoKSEqdPoFfoga/a2ULYDU/80P6yl5P9MQs1Z1
	r/trEsNguEdifSWhSaAsym18LdIcuVxJUUv4cSsdEzw5Xh7jiPOg1+wHbhOXWtP7x/mJ70nbubz1E
	FA/1LHCjumg08JOCV0QcNZbSyC6zui4aXOSGQ+0s+iPN1bJZM83wxp9+R9falfCuZEqBCSOvjbveH
	MTRqAaEj6iS+urZtCgvXebV96QSHrSx97z38T3qDuKE9DgK3EKELEpll4ZAg2Tav6lInk+BrG5mOn
	D96ezTng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBRNZ-00000002SGd-3YT5;
	Tue, 29 Sep 2026 06:31:53 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBRNX-00000002SG0-1Du2
	for linux-um@lists.infradead.org;
	Tue, 29 Sep 2026 06:31:52 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1xBQxx-006b3W-2Q; Tue, 29 Sep 2026 06:05:25 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1xBQpv-0000000FjgF-3FV5;
	Tue, 29 Sep 2026 07:05:23 +0100
Message-ID: <623372e1-dd03-431d-b613-4592d1505093@cambridgegreys.com>
Date: Tue, 29 Sep 2026 07:05:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Fix outdated URL in user_mode_linux_howto_v2.rst
To: Chaohai Chen <wdhh6@aliyun.com>, richard@nod.at,
 johannes@sipsolutions.net, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-um@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260929035006.2201371-1-wdhh6@aliyun.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20260929035006.2201371-1-wdhh6@aliyun.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_233151_344835_EDA77335 
X-CRM114-Status: GOOD (  15.29  )
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

On 29/09/2026 04:50, Chaohai Chen wrote:
> Using an outdated website results in an error:
>    E: Failed getting release file http://deb.debian.org/debian/dists/buster/Release
> 
> It works successfully using https://archive.debian.org/debian-archive/debian .
> 
> Signed-off-by: Chaohai Chen <wdhh6@aliyun.com>
> ---
>   Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index 9224bea5ee9f..c4d5d08e2bab 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -123,7 +123,7 @@ jfs, etc will work too.
>   
>   Create a minimal OS installation on the mounted filesystem::
>   
> -   # debootstrap buster /mnt http://deb.debian.org/debian
> +   # debootstrap buster /mnt https://archive.debian.org/debian-archive/debian
>   
>   debootstrap does not set up the root password, fstab, hostname or
>   anything related to networking. It is up to the user to do that.

That is the historic archive - you have only out-of-support distros there.

That line should change to

 > -   # debootstrap buster /mnt http://deb.debian.org/debian
 > +   # debootstrap trixie /mnt http://deb.debian.org/debian/

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661

