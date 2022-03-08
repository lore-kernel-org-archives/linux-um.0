Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRZ3m-004N4C-K0
 for linux-um@lists.infradead.org; Tue, 08 Mar 2022 12:35:29 +0000
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v7 00/26] virtio pci support VIRTIO_F_RING_RESET
Date: Tue,  8 Mar 2022 20:34:52 +0800
Message-Id: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
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
To: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Johannes Berg <johannes.berg@intel.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org

The virtio spec already supports the virtio queue reset function. This patch set
is to add this function to the kernel. The relevant virtio spec information is
here:

    https://github.com/oasis-tcs/virtio-spec/issues/124

Also regarding MMIO support for queue reset, I plan to support it after this
patch is passed.

Performing reset on a queue is divided into four steps:
     1. virtio_reset_vq()              - notify the device to reset the queue
     2. virtqueue_detach_unused_buf()  - recycle the buffer submitted
     3. virtqueue_reset_vring()        - reset the vring (may re-alloc)
     4. virtio_enable_resetq()         - mmap vring to device, and enable the queue

The first part 1-17 of this patch set implements virtio pci's support and API
for queue reset. The latter part is to make virtio-net support set_ringparam. Do
these things for this feature:

      1. virtio-net support rx,tx reset
      2. find_vqs() support to special the max size of each vq
      3. virtio-net support set_ringparam

#1 -#3 :       prepare
#4 -#12:       virtio ring support reset vring of the vq
#13-#14:       add helper
#15-#17:       virtio pci support reset queue and re-enable
#18-#21:       find_vqs() support sizes to special the max size of each vq
#23-#24:       virtio-net support rx, tx reset
#22, #25, #26: virtio-net support set ringparam

Test environment:
    Host: 4.19.91
    Qemu: QEMU emulator version 6.2.50 (with vq reset support)
    Test Cmd:  ethtool -G eth1 rx $1 tx $2; ethtool -g eth1

    The default is split mode, modify Qemu virtio-net to add PACKED feature to test
    packed mode.


Please review. Thanks.

v7:
  1. fix #6 subject typo
  2. fix #6 ring_size_in_bytes is uninitialized
  3. check by: make W=12

v6:
  1. virtio_pci: use synchronize_irq(irq) to sync the irq callbacks
  2. Introduce virtqueue_reset_vring() to implement the reset of vring during
     the reset process. May use the old vring if num of the vq not change.
  3. find_vqs() support sizes to special the max size of each vq

v5:
  1. add virtio-net support set_ringparam

v4:
  1. just the code of virtio, without virtio-net
  2. Performing reset on a queue is divided into these steps:
    1. reset_vq: reset one vq
    2. recycle the buffer from vq by virtqueue_detach_unused_buf()
    3. release the ring of the vq by vring_release_virtqueue()
    4. enable_reset_vq: re-enable the reset queue
  3. Simplify the parameters of enable_reset_vq()
  4. add container structures for virtio_pci_common_cfg

v3:
  1. keep vq, irq unreleased

*** BLURB HERE ***

Xuan Zhuo (26):
  virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
  virtio: queue_reset: add VIRTIO_F_RING_RESET
  virtio: add helper virtqueue_get_vring_max_size()
  virtio_ring: split: extract the logic of creating vring
  virtio_ring: split: extract the logic of init vq and attach vring
  virtio_ring: packed: extract the logic of creating vring
  virtio_ring: packed: extract the logic of init vq and attach vring
  virtio_ring: extract the logic of freeing vring
  virtio_ring: split: implement virtqueue_reset_vring_split()
  virtio_ring: packed: implement virtqueue_reset_vring_packed()
  virtio_ring: introduce virtqueue_reset_vring()
  virtio_ring: update the document of the virtqueue_detach_unused_buf
    for queue reset
  virtio: queue_reset: struct virtio_config_ops add callbacks for
    queue_reset
  virtio: add helper for queue reset
  virtio_pci: queue_reset: update struct virtio_pci_common_cfg and
    option functions
  virtio_pci: queue_reset: extract the logic of active vq for modern pci
  virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
  virtio: find_vqs() add arg sizes
  virtio_pci: support the arg sizes of find_vqs()
  virtio_mmio: support the arg sizes of find_vqs()
  virtio: add helper virtio_find_vqs_ctx_size()
  virtio_net: get ringparam by virtqueue_get_vring_max_size()
  virtio_net: split free_unused_bufs()
  virtio_net: support rx/tx queue reset
  virtio_net: set the default max ring size by find_vqs()
  virtio_net: support set_ringparam

 arch/um/drivers/virtio_uml.c             |   2 +-
 drivers/net/virtio_net.c                 | 257 ++++++++--
 drivers/platform/mellanox/mlxbf-tmfifo.c |   3 +-
 drivers/remoteproc/remoteproc_virtio.c   |   2 +-
 drivers/s390/virtio/virtio_ccw.c         |   2 +-
 drivers/virtio/virtio_mmio.c             |  12 +-
 drivers/virtio/virtio_pci_common.c       |  28 +-
 drivers/virtio/virtio_pci_common.h       |   3 +-
 drivers/virtio/virtio_pci_legacy.c       |   8 +-
 drivers/virtio/virtio_pci_modern.c       | 146 +++++-
 drivers/virtio/virtio_pci_modern_dev.c   |  36 ++
 drivers/virtio/virtio_ring.c             | 584 +++++++++++++++++------
 drivers/virtio/virtio_vdpa.c             |   2 +-
 include/linux/virtio.h                   |  12 +
 include/linux/virtio_config.h            |  74 ++-
 include/linux/virtio_pci_modern.h        |   2 +
 include/uapi/linux/virtio_config.h       |   7 +-
 include/uapi/linux/virtio_pci.h          |  14 +
 18 files changed, 979 insertions(+), 215 deletions(-)

--
2.31.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

