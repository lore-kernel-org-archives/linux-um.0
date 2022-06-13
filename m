Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp2.axis.com ([195.60.68.18])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0dts-001jpK-Oq
	for linux-um@lists.infradead.org; Mon, 13 Jun 2022 06:50:14 +0000
Date: Mon, 13 Jun 2022 08:50:05 +0200
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH] um: virt-pci: set device ready in probe()
Message-ID: <20220613065004.GA21804@axis.com>
References: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
 <20220610203029-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220610203029-mutt-send-email-mst@kernel.org>
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
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, kernel <kernel@axis.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Jun 11, 2022 at 02:34:04AM +0200, Michael S. Tsirkin wrote:
> BTW Johannes I think you need to spec this device and get
> an ID - what's the plan for that? Current hack of punting
> this to userspace isn't really any good long term.

There is work ongoing in QEMU to add a new vfio-user protocol to support
out-of-process PCI device emulation.  Perhaps an option would be to use
that protocol instead in UML too in the future?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

