Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69F0C54E4A
	for <linux-um@archiver.kernel.org>; Fri,  8 Mar 2024 10:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/WMTCS5EEHI7Het25Mi+GdZWmz1h4wDpCgQX+p2F+kw=; b=wzPU7WI5MB5EDBKEXv4nK+NgLB
	c4O+jJtgn+sebDTGa0/7GNR0DxdWRFuJMUeh18/PhotPAN83AHimJOUMt7dwwJeWPEq6nHc1ywt0T
	igYfcmXU862ZiNK2Xfi7/aPrmyy5vosY2M6vbOG6jm5K/nav9hrKPePjo7RyxtlFifRzLmrbRRItR
	Fuz08nJaP4599DSr15bEpXRZSjxBMwYmr0HcrbkOGxe1jgQDOxQOkRusT0IsD6TVZFmlfFFvmbgnn
	GHMissa2nE59mTB/H0R9FhBw3+9cFLB8EjchN3n5ahUjP1tpPb5d1FzCKT4xv7Hmg+7b+wnlwYdb3
	Ww+eK6Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riXKI-00000008jXH-0cRs;
	Fri, 08 Mar 2024 10:19:42 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riXKF-00000008jUD-0YO3
	for linux-um@lists.infradead.org;
	Fri, 08 Mar 2024 10:19:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709893179; x=1741429179;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q1N/xDWWH1N2mESqkCTav+THxX2BdxiFo16ZnUREngs=;
  b=I/1qWUiEDiIBqaCAdcI8Y/kh69g24EKQXNnFTJDQQ6KcnM2KlrVOJVCE
   bgMHOE7L7qKCwiGyAzqN+jZBKTwj8wtbWE0rmP1D+KyphXnqXGC0vrJ0p
   9Wib1IJJFmpNYEsEhSe9IgBGFF+6lSNap5XsYTmKOfPFYilEKcXl3hiPv
   xsbEFEZSlqwz+EemBtTOUz1Gldc9rXpnkbs83dA2gmMyNnCCQIs0inwW6
   O1RXR+GAYfvOa4IeC8msuuSnCEjke+aopvrkoX8U1bTJBaBEHmGCjUjUn
   pes1EFXfEYt1bvytFuBwuJ1WuWukfOWkKxRe11cZzzeytXq4MNrusfLHi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="22132940"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="22132940"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:19:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15004974"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:19:27 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 8 Mar 2024 12:19:21 +0200 (EET)
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
    Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
    Johannes Berg <johannes@sipsolutions.net>, 
    Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    Bjorn Andersson <andersson@kernel.org>, 
    Mathieu Poirier <mathieu.poirier@linaro.org>, 
    Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
    Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
    Vasily Gorbik <gor@linux.ibm.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
    Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org, 
    platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
    linux-s390@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH vhost v1 2/4] virtio: vring_create_virtqueue: pass struct
 instead of multi parameters
In-Reply-To: <20240306114615.88770-3-xuanzhuo@linux.alibaba.com>
Message-ID: <8f77a787-0bb7-96ad-0dac-f8ef36879ae3@linux.intel.com>
References: <20240306114615.88770-1-xuanzhuo@linux.alibaba.com> <20240306114615.88770-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_021939_213171_E0AB5064 
X-CRM114-Status: GOOD (  14.69  )
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

On Wed, 6 Mar 2024, Xuan Zhuo wrote:

> Now, we pass multi parameters to vring_create_virtqueue. These parameters
> may from transport or from driver.
> 
> vring_create_virtqueue is called by many places.
> Every time, we try to add a new parameter, that is difficult.
> 
> If parameters from the driver, that should directly be passed to vring.
> Then the vring can access the config from driver directly.
> 
> If parameters from the transport, we squish the parameters to a
> structure. That will be helpful to add new parameter.
> 
> Because the virtio_uml.c changes the name, so change the "names" inside
> the virtio_vq_config from "const char *const *names" to
> "const char **names".
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>

> @@ -60,38 +61,25 @@ struct virtio_device;
>  struct virtqueue;
>  struct device;
>  
> +struct vq_transport_config {
> +	unsigned int num;
> +	unsigned int vring_align;
> +	bool weak_barriers;
> +	bool may_reduce_num;
> +	bool (*notify)(struct virtqueue *vq);
> +	struct device *dma_dev;
> +};

kerneldoc is missing from this struct too.

It would be generally helpful if you are proactive when somebody comments 
your series by checking if there are similar cases within your series,
instead of waiting them to be pointed out for you specificly.

-- 
 i.


