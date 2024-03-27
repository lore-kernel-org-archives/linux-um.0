Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB22C47DD9
	for <linux-um@archiver.kernel.org>; Wed, 27 Mar 2024 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ji/rWTCYCDETPz30w/C0Fn9V81Ahsz6xzMHIOuFMEiw=; b=Ue82aOZ4YN8ZEMoWhm5PNqCeC3
	zYHAz++peR2+Rprr1oRZ//sYcooCQRGdRaLvqEn/yT+FMPaC9nrvDC8z1mVuWucEKjtB3Ihmi+eal
	QIrDiYkVlePiuR4uuykBD8lD74oBa1IY4cTJi/1IY0KMbXwPGVK9RvjkZNoW4SpVCotk/ZGA6Czzi
	H1XbmA18yajDK5V/xA+o1yEMkqgIbq3BM+GqnhCIXZbFbLHb9RkHfqXAPxdC9o4/zESwQYsLYmbTW
	v0WPhhySPBNXpareMZckvVjCGR2mLczRumLDdQv40L+TkQcugVOpzu4OLRBag1UX26OKHXDys2ZEQ
	6Cbx0cAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpVa1-00000009vY8-2cDX;
	Wed, 27 Mar 2024 15:52:45 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpVZy-00000009vXb-2p23;
	Wed, 27 Mar 2024 15:52:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711554762; x=1743090762;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qW/fd5BsHMv42OERGvBEWgfMs2nJ8WYa2Q4ev1Mj2bE=;
  b=GM6fiX/KWb2SvgMdZ06xGUflF/tlwS7KtbZr6bBL1KJnJPA5KZgxl5ym
   4Lq9Ga9Rxhox/VQfjRLd24Mpyr+vEbwnvBoMSPR1T84fGYLv+XvZSdnks
   /m3yt31ccAgLylJBkXlfh2A07QrqsfBXyrvhPpLE0SPxS7jbRh0bKDqHJ
   XqNoO8BJGCrg8vaX+yc1kw4rMB6u28ej+8gsb0ptbZ9ZmOErYKQ2vC97V
   h+NMmo5CQ2DGM8rNMxvWWCKNTRo4UL5HaRAFY1P9y6h/Z4hOZxMcGZbiR
   ax2nhnuGsp3bLKHoKQy4d+wjNGvOGIu5svNAxNZJoyCDeVd6th/g3oLYx
   w==;
X-CSE-ConnectionGUID: DQManDoQQOqdHHVAhHdoRw==
X-CSE-MsgGUID: HsRneY1FSBiuvQsE6JfZpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17302212"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="17302212"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:52:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="20816491"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.56.222]) ([10.212.56.222])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:52:37 -0700
Message-ID: <2757205c-8a58-4619-bed1-d511812d5a18@intel.com>
Date: Wed, 27 Mar 2024 08:52:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/22] nvdimm: virtio_pmem: drop owner assignment
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Olivia Mackall <olivia@selenic.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Anton Yakovlev <anton.yakovlev@opensynergy.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev,
 kvm@vger.kernel.org, linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
 <20240327-module-owner-virtio-v1-18-0feffab77d99@linaro.org>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240327-module-owner-virtio-v1-18-0feffab77d99@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_085242_764581_4FA4CB84 
X-CRM114-Status: GOOD (  16.18  )
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



On 3/27/24 5:41 AM, Krzysztof Kozlowski wrote:
> virtio core already sets the .owner, so driver does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> Depends on the first patch.
> ---
>  drivers/nvdimm/virtio_pmem.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index 4ceced5cefcf..c9b97aeabf85 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -151,7 +151,6 @@ static struct virtio_driver virtio_pmem_driver = {
>  	.feature_table		= features,
>  	.feature_table_size	= ARRAY_SIZE(features),
>  	.driver.name		= KBUILD_MODNAME,
> -	.driver.owner		= THIS_MODULE,
>  	.id_table		= id_table,
>  	.validate		= virtio_pmem_validate,
>  	.probe			= virtio_pmem_probe,
> 

