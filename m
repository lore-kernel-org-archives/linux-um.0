Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzkQy-009Y9u-HS
	for linux-um@lists.infradead.org; Fri, 10 Jun 2022 19:36:41 +0000
Message-ID: <3670b59063e3815f281c602d6f88dde8e9b1c50f.camel@sipsolutions.net>
Subject: Re: [PATCH] um: virt-pci: set device ready in probe()
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 10 Jun 2022 21:36:23 +0200
In-Reply-To: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
References: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
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
To: Vincent Whitchurch <vincent.whitchurch@axis.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: kernel@axis.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, 2022-06-10 at 17:12 +0200, Vincent Whitchurch wrote:
> Call virtio_device_ready() to make this driver work after commit
> b4ec69d7e09 ("virtio: harden vring IRQ"), since the driver uses the
> virtqueues in the probe function.  (The virtio core sets the device
> ready when probe returns.)
> 
> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Thank you! I had apparently run into this a few days ago, but hadn't had
a chance to debug it yet. This patch fixes my test setup on 5.19-rc1.

Tested-by: Johannes Berg <johannes@sipsolutions.net>

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

