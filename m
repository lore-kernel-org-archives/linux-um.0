Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4dev-000zEV-UV
	for linux-um@lists.infradead.org; Fri, 24 Jun 2022 07:23:20 +0000
Message-ID: <1656055326.9754634-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v10 25/41] virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
Date: Fri, 24 Jun 2022 15:22:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
 <20220624025621.128843-26-xuanzhuo@linux.alibaba.com>
 <20220624025817-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220624025817-mutt-send-email-mst@kernel.org>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, kangjie.xu@linux.alibaba.com

On Fri, 24 Jun 2022 02:59:39 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Jun 24, 2022 at 10:56:05AM +0800, Xuan Zhuo wrote:
> > Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> > here https://github.com/oasis-tcs/virtio-spec/issues/89
> >
> > For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.
>
> What exactly is meant by not breaking uABI?
> Users are supposed to be prepared for struct size to change ... no?

This was a previous discussion with Jason Wang, who was concerned about
affecting some existing programs.

https://lore.kernel.org/all/CACGkMEshTp8vSP9=pKj82y8+DDQFu9tFAk1EGhMZLvXUE-OSEA@mail.gmail.com/

Thanks.

>
>
> > Since I want to add queue_reset after queue_notify_data, I submitted
> > this patch first.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  include/uapi/linux/virtio_pci.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> > index 3a86f36d7e3d..22bec9bd0dfc 100644
> > --- a/include/uapi/linux/virtio_pci.h
> > +++ b/include/uapi/linux/virtio_pci.h
> > @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
> >  	__le32 queue_used_hi;		/* read-write */
> >  };
> >
> > +struct virtio_pci_common_cfg_notify {
> > +	struct virtio_pci_common_cfg cfg;
> > +
> > +	__le16 queue_notify_data;	/* read-write */
> > +	__le16 padding;
> > +};
> > +
> >  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> >  struct virtio_pci_cfg_cap {
> >  	struct virtio_pci_cap cap;
> > --
> > 2.31.0
>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

