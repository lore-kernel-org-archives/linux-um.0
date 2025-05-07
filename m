Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6422C3ABC0
	for <linux-um@archiver.kernel.org>; Wed,  7 May 2025 11:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IdnAOnCRq90p308A+UdFioQ4SgHht6IUlP0dVVbjW0U=; b=o3kxkm+BBHoCXyszgJER4fwmpP
	B5yn0jZPQLRyi0gnWOBDKX+8UVWKWpnaWTKxgsY600IGc4sa1IvaDT8zru2MV08eDqdjVSpF4bxX/
	Enq8xOOoUMtolbP9WSgwTjOECveuaTdr7DUYiPYBQUNzW6QUqJk5YL9CELwDgKiKqdZiLYA4ZDqgB
	NYi6IDi0EqIU5HWh9SC0X+NUkxUarWH6sghoyqcBHJjc3PbosCP5nF2YgI54uI/SU2ya87BlRQidq
	nemzooruKWwBE67IONb/VchQHbWJfV+Ga1Jv/2QAV3fRmHhEwqjcB2FLcKUPJpkV28uCDdKN8aDNn
	z1WqHY3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdKT-0000000FHOg-3TUF;
	Wed, 07 May 2025 11:52:49 +0000
Received: from out0-201.mail.aliyun.com ([140.205.0.201])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdKQ-0000000FHNo-0m22
	for linux-um@lists.infradead.org;
	Wed, 07 May 2025 11:52:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1746618760; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IdnAOnCRq90p308A+UdFioQ4SgHht6IUlP0dVVbjW0U=;
	b=BfvEqMyWHfXVAwnA42+wxD/MIGIQPe4Ihw3SaedwcNIm0p84vnno0fCazV/Rf7DxykIcUeifjOLXSzkuzrPVLpXAaYgZuX7l1QPYO2Awynygy2AomHnzIf7t3OObV80E2M9PoxGacwUqvOarrnlHCKaz5zp4nF6l6atdV+MfbRY=
Received: from 30.174.106.64(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cgyj98E_1746618744 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 07 May 2025 19:52:35 +0800
Message-ID: <2ac70b02-7841-4355-ae71-5b57a6ce15e2@antgroup.com>
Date: Wed, 07 May 2025 19:52:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: remove obsolete file entry in TUN/TAP DRIVER
To: Lukas Bulwahn <lbulwahn@redhat.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
References: <20250507071004.35120-1-lukas.bulwahn@redhat.com>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20250507071004.35120-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_045246_723830_DAAC2F8C 
X-CRM114-Status: GOOD (  11.47  )
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

On 2025/5/7 15:10, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 65eaac591b75 ("um: Remove obsolete legacy network transports")
> removes the directory arch/um/os-Linux/drivers/, but misses to remove the
> file entry in TUN/TAP DRIVER referring to that directory.
> 
> Remove this obsolete file entry. While at it, put the section name in
> capital letters.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9c166503cc6b..34a55e3ff863 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24981,13 +24981,12 @@ L:	linux-parisc@vger.kernel.org
>  S:	Orphan
>  F:	drivers/net/ethernet/dec/tulip/
>  
> -TUN/TAP driver
> +TUN/TAP DRIVER
>  M:	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
>  M:	Jason Wang <jasowang@redhat.com>
>  S:	Maintained
>  W:	http://vtun.sourceforge.net/tun
>  F:	Documentation/networking/tuntap.rst
> -F:	arch/um/os-Linux/drivers/
>  F:	drivers/net/tap.c
>  F:	drivers/net/tun*
>  

I missed that. Thanks for the fix!

Reviewed-by: Tiwei Bie <tiwei.btw@antgroup.com>

Regards,
Tiwei

