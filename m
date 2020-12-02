Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkSt5-0002e1-JN
 for linux-um@lists.infradead.org; Wed, 02 Dec 2020 14:13:54 +0000
Subject: Re: [PATCH v2 2/7] um: virtio: use dynamic IRQ allocation
References: <20201202115956.42963-1-johannes@sipsolutions.net>
 <20201202125915.d5cbac8ab2de.Id7bf6cf5659579ac53cce88552126e4d98a74e3d@changeid>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <ecbde0af-49f8-034f-ff74-494dcbea711a@cambridgegreys.com>
Date: Wed, 2 Dec 2020 14:13:40 +0000
MIME-Version: 1.0
In-Reply-To: <20201202125915.d5cbac8ab2de.Id7bf6cf5659579ac53cce88552126e4d98a74e3d@changeid>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>



On 02/12/2020 11:59, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This separates the devices, which is better for debug and for
> later suspend/resume and wakeup support, since there we'll
> have to separate which IRQs can wake up the system and which
> cannot.
> 
> Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/drivers/virtio_uml.c | 22 ++++++++++++++--------
>   arch/um/include/asm/irq.h    |  5 ++---
>   2 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index f76b8da28d20..94b112749d5b 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -55,7 +55,7 @@ struct virtio_uml_device {
>   	struct platform_device *pdev;
>   
>   	spinlock_t sock_lock;
> -	int sock, req_fd;
> +	int sock, req_fd, irq;
>   	u64 features;
>   	u64 protocol_features;
>   	u8 status;
> @@ -409,12 +409,14 @@ static int vhost_user_init_slave_req(struct virtio_uml_device *vu_dev)
>   		return rc;
>   	vu_dev->req_fd = req_fds[0];
>   
> -	rc = um_request_irq(VIRTIO_IRQ, vu_dev->req_fd, IRQ_READ,
> +	rc = um_request_irq(UM_IRQ_ALLOC, vu_dev->req_fd, IRQ_READ,
>   			    vu_req_interrupt, IRQF_SHARED,
>   			    vu_dev->pdev->name, vu_dev);
>   	if (rc < 0)
>   		goto err_close;
>   
> +	vu_dev->irq = rc;
> +
>   	rc = vhost_user_send_no_payload_fd(vu_dev, VHOST_USER_SET_SLAVE_REQ_FD,
>   					   req_fds[1]);
>   	if (rc)
> @@ -423,7 +425,7 @@ static int vhost_user_init_slave_req(struct virtio_uml_device *vu_dev)
>   	goto out;
>   
>   err_free_irq:
> -	um_free_irq(VIRTIO_IRQ, vu_dev);
> +	um_free_irq(vu_dev->irq, vu_dev);
>   err_close:
>   	os_close_file(req_fds[0]);
>   out:
> @@ -802,7 +804,11 @@ static void vu_del_vq(struct virtqueue *vq)
>   	struct virtio_uml_vq_info *info = vq->priv;
>   
>   	if (info->call_fd >= 0) {
> -		um_free_irq(VIRTIO_IRQ, vq);
> +		struct virtio_uml_device *vu_dev;
> +
> +		vu_dev = to_virtio_uml_device(vq->vdev);
> +
> +		um_free_irq(vu_dev->irq, vq);
>   		os_close_file(info->call_fd);
>   	}
>   
> @@ -852,7 +858,7 @@ static int vu_setup_vq_call_fd(struct virtio_uml_device *vu_dev,
>   		return rc;
>   
>   	info->call_fd = call_fds[0];
> -	rc = um_request_irq(VIRTIO_IRQ, info->call_fd, IRQ_READ,
> +	rc = um_request_irq(vu_dev->irq, info->call_fd, IRQ_READ,
>   			    vu_interrupt, IRQF_SHARED, info->name, vq);
>   	if (rc < 0)
>   		goto close_both;
> @@ -864,7 +870,7 @@ static int vu_setup_vq_call_fd(struct virtio_uml_device *vu_dev,
>   	goto out;
>   
>   release_irq:
> -	um_free_irq(VIRTIO_IRQ, vq);
> +	um_free_irq(vu_dev->irq, vq);
>   close_both:
>   	os_close_file(call_fds[0]);
>   out:
> @@ -969,7 +975,7 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
>   
>   error_setup:
>   	if (info->call_fd >= 0) {
> -		um_free_irq(VIRTIO_IRQ, vq);
> +		um_free_irq(vu_dev->irq, vq);
>   		os_close_file(info->call_fd);
>   	}
>   error_call:
> @@ -1078,7 +1084,7 @@ static void virtio_uml_release_dev(struct device *d)
>   
>   	/* might not have been opened due to not negotiating the feature */
>   	if (vu_dev->req_fd >= 0) {
> -		um_free_irq(VIRTIO_IRQ, vu_dev);
> +		um_free_irq(vu_dev->irq, vu_dev);
>   		os_close_file(vu_dev->req_fd);
>   	}
>   
> diff --git a/arch/um/include/asm/irq.h b/arch/um/include/asm/irq.h
> index b6fa6301c75b..547bff7b3a89 100644
> --- a/arch/um/include/asm/irq.h
> +++ b/arch/um/include/asm/irq.h
> @@ -17,18 +17,17 @@
>   #define TELNETD_IRQ 		12
>   #define XTERM_IRQ 		13
>   #define RANDOM_IRQ 		14
> -#define VIRTIO_IRQ		15
>   
>   #ifdef CONFIG_UML_NET_VECTOR
>   
> -#define VECTOR_BASE_IRQ		(VIRTIO_IRQ + 1)
> +#define VECTOR_BASE_IRQ		(RANDOM_IRQ + 1)
>   #define VECTOR_IRQ_SPACE	8
>   
>   #define UM_FIRST_DYN_IRQ (VECTOR_IRQ_SPACE + VECTOR_BASE_IRQ)
>   
>   #else
>   
> -#define UM_FIRST_DYN_IRQ (VIRTIO_IRQ + 1)
> +#define UM_FIRST_DYN_IRQ (RANDOM_IRQ + 1)
>   
>   #endif
>   
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

