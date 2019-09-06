Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i68lJ-0002hc-Aj
 for linux-um@lists.infradead.org; Fri, 06 Sep 2019 07:34:30 +0000
Message-ID: <4f28b51467db108b7eb30b65fbb4eee32ac30383.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: drivers: Add virtio vhost-user driver
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 06 Sep 2019 09:34:22 +0200
In-Reply-To: <20190904073009.9122-1-johannes@sipsolutions.net>
References: <20190904073009.9122-1-johannes@sipsolutions.net>
MIME-Version: 1.0
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
To: linux-um@lists.infradead.org
Cc: Erel Geron <erelx.geron@intel.com>

On Wed, 2019-09-04 at 09:30 +0200, Johannes Berg wrote:
> 
> +static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> +		       struct virtqueue *vqs[], vq_callback_t *callbacks[],
> +		       const char * const names[], const bool *ctx,
> +		       struct irq_affinity *desc)
> +{
> +	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
> +	int i, queue_idx, rc;

Found another bug - queue_idx needs to be initialized to 0 here, it's
only used

> +	struct virtqueue *vq;
> +
> +	rc = vhost_user_set_mem_table(vu_dev);
> +	if (rc)
> +		return rc;
> +
> +	for (i = 0; i < nvqs; ++i) {
> +		if (!names[i]) {
> +			vqs[i] = NULL;
> +			continue;
> +		}
> +
> +		vqs[i] = vu_setup_vq(vdev, queue_idx++, callbacks[i], names[i],

here

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

