Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o64O1-004ZsC-66
	for linux-um@lists.infradead.org; Tue, 28 Jun 2022 06:07:50 +0000
Received: by mail-lf1-f69.google.com with SMTP id bp15-20020a056512158f00b0047f603e5f92so5762588lfb.20
        for <linux-um@lists.infradead.org>; Mon, 27 Jun 2022 23:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
 <20220624025621.128843-26-xuanzhuo@linux.alibaba.com> <20220624025817-mutt-send-email-mst@kernel.org>
 <CACGkMEseptD=45j3kQr0yciRxR679Jcig=292H07-RYC2vXmFQ@mail.gmail.com>
 <20220627023841-mutt-send-email-mst@kernel.org> <CACGkMEvy8xF2T_vubKeUEPC2aroO_fbB0Xe8nnxK4OBUgAS+Gw@mail.gmail.com>
 <20220627034733-mutt-send-email-mst@kernel.org> <CACGkMEtpjUBaUML=fEs5hR66rzNTBhBXOmfpzyXV1F-6BqvsGg@mail.gmail.com>
 <20220627074723-mutt-send-email-mst@kernel.org> <CACGkMEv0zdgG6SAaxRwkpObEFX_KRB1ovezNiHX+QXsYhE=qaQ@mail.gmail.com>
 <20220628014309-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220628014309-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Jun 2022 14:07:28 +0800
Message-ID: <CACGkMEuzrmVsM5Xa3N_9n0-XOqyMAz65AON8oxkgmjnXb_bAFg@mail.gmail.com>
Subject: Re: [PATCH v10 25/41] virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization <virtualization@lists.linux-foundation.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev <netdev@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>, "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>, kangjie.xu@linux.alibaba.com

On Tue, Jun 28, 2022 at 1:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jun 28, 2022 at 11:50:37AM +0800, Jason Wang wrote:
> > On Mon, Jun 27, 2022 at 7:53 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Jun 27, 2022 at 04:14:20PM +0800, Jason Wang wrote:
> > > > On Mon, Jun 27, 2022 at 3:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Mon, Jun 27, 2022 at 03:45:30PM +0800, Jason Wang wrote:
> > > > > > On Mon, Jun 27, 2022 at 2:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 27, 2022 at 10:30:42AM +0800, Jason Wang wrote:
> > > > > > > > On Fri, Jun 24, 2022 at 2:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Jun 24, 2022 at 10:56:05AM +0800, Xuan Zhuo wrote:
> > > > > > > > > > Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> > > > > > > > > > here https://github.com/oasis-tcs/virtio-spec/issues/89
> > > > > > > > > >
> > > > > > > > > > For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.
> > > > > > > > >
> > > > > > > > > What exactly is meant by not breaking uABI?
> > > > > > > > > Users are supposed to be prepared for struct size to change ... no?
> > > > > > > >
> > > > > > > > Not sure, any doc for this?
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > >
> > > > > > > Well we have this:
> > > > > > >
> > > > > > >         The drivers SHOULD only map part of configuration structure
> > > > > > >         large enough for device operation.  The drivers MUST handle
> > > > > > >         an unexpectedly large \field{length}, but MAY check that \field{length}
> > > > > > >         is large enough for device operation.
> > > > > >
> > > > > > Yes, but that's the device/driver interface. What's done here is the
> > > > > > userspace/kernel.
> > > > > >
> > > > > > Userspace may break if it uses e.g sizeof(struct virtio_pci_common_cfg)?
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > Hmm I guess there's risk... but then how are we going to maintain this
> > > > > going forward?  Add a new struct on any change?
> > > >
> > > > This is the way we have used it for the past 5 or more years. I don't
> > > > see why this must be handled in the vq reset feature.
> > > >
> > > > >Can we at least
> > > > > prevent this going forward somehow?
> > > >
> > > > Like have some padding?
> > > >
> > > > Thanks
> > >
> > > Maybe - this is what QEMU does ...
> >
> > Do you want this to be addressed in this series (it's already very huge anyhow)?
> >
> > Thanks
>
> Let's come up with a solution at least. QEMU does not seem to need the struct.

If we want to implement it in Qemu we need that:

https://github.com/fengidri/qemu/commit/39b79335cb55144d11a3b01f93d46cc73342c6bb

> Let's just put
> it in virtio_pci_modern.h for now then?

Does this mean userspace needs to define the struct by their own
instead of depending on the uapi in the future?

Thanks

>
> > >
> > > > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > Since I want to add queue_reset after queue_notify_data, I submitted
> > > > > > > > > > this patch first.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > ---
> > > > > > > > > >  include/uapi/linux/virtio_pci.h | 7 +++++++
> > > > > > > > > >  1 file changed, 7 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> > > > > > > > > > index 3a86f36d7e3d..22bec9bd0dfc 100644
> > > > > > > > > > --- a/include/uapi/linux/virtio_pci.h
> > > > > > > > > > +++ b/include/uapi/linux/virtio_pci.h
> > > > > > > > > > @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
> > > > > > > > > >       __le32 queue_used_hi;           /* read-write */
> > > > > > > > > >  };
> > > > > > > > > >
> > > > > > > > > > +struct virtio_pci_common_cfg_notify {
> > > > > > > > > > +     struct virtio_pci_common_cfg cfg;
> > > > > > > > > > +
> > > > > > > > > > +     __le16 queue_notify_data;       /* read-write */
> > > > > > > > > > +     __le16 padding;
> > > > > > > > > > +};
> > > > > > > > > > +
> > > > > > > > > >  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> > > > > > > > > >  struct virtio_pci_cfg_cap {
> > > > > > > > > >       struct virtio_pci_cap cap;
> > > > > > > > > > --
> > > > > > > > > > 2.31.0
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

