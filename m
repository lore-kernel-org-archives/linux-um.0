Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F102C54798
	for <linux-um@archiver.kernel.org>; Tue,  5 Mar 2024 11:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2aGSvKvCNWIjUy7uNDjH5KlGt5S13ZRbTMwPUlivQrM=; b=jYDW97Feh/rUntEILa91WgCxwm
	6PNG0p3mcppQjIFKtB6JZVYjtRVZDsLGNR+2aZQ0hG/i8qwp/o03b1JeMhmgVwx34aEzZCHLBq8rg
	exIB7vrby2a4mV1AFDA1gm63CSXqbTX+DuAPd1MkzAbnt0UcODb2i6rWpG03QB2QxK6ooQMJHdm6K
	WKMpkp1Ah5EYmlKGAvZaSqFg5TQ6TPIB7Zfn8xY+/v2B4XkXBK4njfXiey+msN6Wm0GldLeSbcSd8
	ciyzCKHfn+aM7rzdimjFiRR3dxaMpqWOyyOyJgoxFADQznFjedZnL98DiPvaND89MJgK7Qu0HWwpr
	rZy/T1TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhStm-0000000DKVm-3RUg;
	Tue, 05 Mar 2024 11:23:54 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhStk-0000000DKUq-0ah3
	for linux-um@lists.infradead.org;
	Tue, 05 Mar 2024 11:23:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709637832; x=1741173832;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JyjwkuHnYBoLTGojfsVzV+696GFqnuVrIlOLCLHz8hA=;
  b=jjZfntbX06y9B4LTH3JdgjR1l+aynxtxS80urZtccngZC0SCrrWHBvEQ
   ufTsUDadKdyF/4G4yTIXBKW7u6/1UKOJB3Sgzvzg8GBpe3b8/ba91dvwL
   ABehRYXde7H0/eKgkFcvGHNZBD+ZyS6hKmnUWJqsbz+1vHnss2ty3uY4z
   V1yVAXEG1coPZ1s0f6Y0pNzm0X5Qd3l5JE/wNcN7S83VGM3GF5z+LbXXH
   GepN4ontI1JKa30VysF/c8PT9my4HC/L67/gz+suf6XB2/rP0lzh+P+va
   /hkDHGOUgmvv3+QcNcAKcDTLEtv5uLUA4aoKZL8lw3nwIZeU7S9OOtnc7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4040100"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4040100"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 03:23:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14031011"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.51.37])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 03:23:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 5 Mar 2024 13:23:25 +0200 (EET)
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
Subject: Re: [PATCH vhost 1/4] virtio: find_vqs: pass struct instead of multi
 parameters
In-Reply-To: <20240304114719.3710-2-xuanzhuo@linux.alibaba.com>
Message-ID: <f0ff7ef2-ba67-4091-efad-dc8eb8042dc3@linux.intel.com>
References: <20240304114719.3710-1-xuanzhuo@linux.alibaba.com> <20240304114719.3710-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_032352_282645_22712C71 
X-CRM114-Status: GOOD (  26.86  )
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

On Mon, 4 Mar 2024, Xuan Zhuo wrote:

> Now, we pass multi parameters to find_vqs. These parameters
> may work for transport or work for vring.
> 
> And find_vqs has multi implements in many places:
> 
>  arch/um/drivers/virtio_uml.c
>  drivers/platform/mellanox/mlxbf-tmfifo.c
>  drivers/remoteproc/remoteproc_virtio.c
>  drivers/s390/virtio/virtio_ccw.c
>  drivers/virtio/virtio_mmio.c
>  drivers/virtio/virtio_pci_legacy.c
>  drivers/virtio/virtio_pci_modern.c
>  drivers/virtio/virtio_vdpa.c
> 
> Every time, we try to add a new parameter, that is difficult.
> We must change every find_vqs implement.
> 
> One the other side, if we want to pass a parameter to vring,
> we must change the call path from transport to vring.
> Too many functions need to be changed.
> 
> So it is time to refactor the find_vqs. We pass a structure
> cfg to find_vqs(), that will be passed to vring by transport.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  arch/um/drivers/virtio_uml.c             | 23 ++++-----
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 13 ++----
>  drivers/remoteproc/remoteproc_virtio.c   | 28 ++++++-----
>  drivers/s390/virtio/virtio_ccw.c         | 29 ++++++------
>  drivers/virtio/virtio_mmio.c             | 26 +++++------
>  drivers/virtio/virtio_pci_common.c       | 59 +++++++++++-------------
>  drivers/virtio/virtio_pci_common.h       |  9 +---
>  drivers/virtio/virtio_pci_legacy.c       | 11 +++--
>  drivers/virtio/virtio_pci_modern.c       | 33 +++++++------
>  drivers/virtio/virtio_vdpa.c             | 36 +++++++--------
>  include/linux/virtio_config.h            | 51 ++++++++++++++++----
>  11 files changed, 172 insertions(+), 146 deletions(-)
> 
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index 8adca2000e51..c13dfeeb90c4 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -937,8 +937,8 @@ static int vu_setup_vq_call_fd(struct virtio_uml_device *vu_dev,
>  }
>  
>  static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
> -				     unsigned index, vq_callback_t *callback,
> -				     const char *name, bool ctx)
> +				     unsigned index,
> +				     struct virtio_vq_config *cfg)
>  {
>  	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
>  	struct platform_device *pdev = vu_dev->pdev;
> @@ -953,10 +953,12 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
>  		goto error_kzalloc;
>  	}
>  	snprintf(info->name, sizeof(info->name), "%s.%d-%s", pdev->name,
> -		 pdev->id, name);
> +		 pdev->id, cfg->names[cfg->cfg_idx]);
>  
>  	vq = vring_create_virtqueue(index, num, PAGE_SIZE, vdev, true, true,
> -				    ctx, vu_notify, callback, info->name);
> +				    cfg->ctx ? cfg->ctx[cfg->cfg_idx] : false,

Based on the commit message, I don't understand why this transformation 
was made. It's perhaps some artifact of moving things around but please 
state it in the commit message because this isn't 1:1 transformation 
which would be just ctx -> cfg->ctx

> +				    vu_notify,
> +				    cfg->callbacks[cfg->cfg_idx], info->name);
>  	if (!vq) {
>  		rc = -ENOMEM;
>  		goto error_create;


> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index b655fccaf773..a9ae03904dcf 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -172,9 +172,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>  }
>  
>  static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int index,
> -				     void (*callback)(struct virtqueue *vq),
> -				     const char *name,
> -				     bool ctx,
> +				     struct virtio_vq_config *cfg,
>  				     u16 msix_vec)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> @@ -186,13 +184,13 @@ static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int in
>  	if (!info)
>  		return ERR_PTR(-ENOMEM);
>  
> -	vq = vp_dev->setup_vq(vp_dev, info, index, callback, name, ctx,
> +	vq = vp_dev->setup_vq(vp_dev, info, index, cfg,
>  			      msix_vec);

Should now easily fit to one line.


> @@ -126,10 +124,7 @@ bool vp_notify(struct virtqueue *vq);
>  /* the config->del_vqs() implementation */
>  void vp_del_vqs(struct virtio_device *vdev);
>  /* the config->find_vqs() implementation */
> -int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> -		struct virtqueue *vqs[], vq_callback_t *callbacks[],
> -		const char * const names[], const bool *ctx,
> -		struct irq_affinity *desc);
> +int vp_find_vqs(struct virtio_device *vdev, struct virtio_vq_config *cfg);

Without knowing better, do you expect cfg is mutated inside vp_find_vqs()? 
If not, mark it as const.

> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index da9b271b54db..1df8634d1258 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -96,6 +96,20 @@ typedef void vq_callback_t(struct virtqueue *);
>   * @create_avq: create admin virtqueue resource.
>   * @destroy_avq: destroy admin virtqueue resource.
>   */
> +
> +struct virtio_vq_config {
> +	unsigned int nvqs;
> +
> +	/* the vq index may not eq to the cfg index of the other array items */

Can you try to make this comment clearer, as is I don't understand what it 
means. E.g. what is "the other array"? not eq = not equal ?

> +	unsigned int cfg_idx;
> +
> +	struct virtqueue **vqs;
> +	vq_callback_t **callbacks;
> +	const char *const *names;
> +	const bool *ctx;
> +	struct irq_affinity *desc;
> +};

The placement of the struct is wrong. Now the documentation of struct 
virtio_config_ops is above your struct!?!

Please also document the members of the newly added struct with kerneldoc.

> +
>  struct virtio_config_ops {
>  	void (*get)(struct virtio_device *vdev, unsigned offset,
>  		    void *buf, unsigned len);
> @@ -105,10 +119,7 @@ struct virtio_config_ops {
>  	u8 (*get_status)(struct virtio_device *vdev);
>  	void (*set_status)(struct virtio_device *vdev, u8 status);
>  	void (*reset)(struct virtio_device *vdev);
> -	int (*find_vqs)(struct virtio_device *, unsigned nvqs,
> -			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> -			const char * const names[], const bool *ctx,
> -			struct irq_affinity *desc);
> +	int (*find_vqs)(struct virtio_device *vdev, struct virtio_vq_config *cfg);
>  	void (*del_vqs)(struct virtio_device *);
>  	void (*synchronize_cbs)(struct virtio_device *);
>  	u64 (*get_features)(struct virtio_device *vdev);


-- 
 i.


