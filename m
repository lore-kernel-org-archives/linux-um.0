Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7ABd-003BYM-9Y
	for linux-um@lists.infradead.org; Fri, 01 Jul 2022 06:31:30 +0000
Received: by mail-ed1-f70.google.com with SMTP id x8-20020a056402414800b0042d8498f50aso1091956eda.23
        for <linux-um@lists.infradead.org>; Thu, 30 Jun 2022 23:31:26 -0700 (PDT)
Date: Fri, 1 Jul 2022 02:31:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v11 25/40] virtio: allow to unbreak/break virtqueue
 individually
Message-ID: <20220701022950-mutt-send-email-mst@kernel.org>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-26-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220629065656.54420-26-xuanzhuo@linux.alibaba.com>
Content-Disposition: inline
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, kangjie.xu@linux.alibaba.com

On Wed, Jun 29, 2022 at 02:56:41PM +0800, Xuan Zhuo wrote:
> This patch allows the new introduced
> __virtqueue_break()/__virtqueue_unbreak() to break/unbreak the
> virtqueue.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

I wonder how this interacts with the hardening patches.
Jason?

> ---
>  drivers/virtio/virtio_ring.c | 24 ++++++++++++++++++++++++
>  include/linux/virtio.h       |  3 +++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 5ec43607cc15..7b02be7fce67 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2744,6 +2744,30 @@ unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
>  
> +/*
> + * This function should only be called by the core, not directly by the driver.
> + */
> +void __virtqueue_break(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> +	WRITE_ONCE(vq->broken, true);
> +}
> +EXPORT_SYMBOL_GPL(__virtqueue_break);
> +
> +/*
> + * This function should only be called by the core, not directly by the driver.
> + */
> +void __virtqueue_unbreak(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> +	WRITE_ONCE(vq->broken, false);
> +}

I don't think these "Pairs" comments have any value.


> +EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
> +
>  bool virtqueue_is_broken(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 1272566adec6..dc474a0d48d1 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -138,6 +138,9 @@ bool is_virtio_device(struct device *dev);
>  void virtio_break_device(struct virtio_device *dev);
>  void __virtio_unbreak_device(struct virtio_device *dev);
>  
> +void __virtqueue_break(struct virtqueue *_vq);
> +void __virtqueue_unbreak(struct virtqueue *_vq);
> +
>  void virtio_config_changed(struct virtio_device *dev);
>  #ifdef CONFIG_PM_SLEEP
>  int virtio_device_freeze(struct virtio_device *dev);
> -- 
> 2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

