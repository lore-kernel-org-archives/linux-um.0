Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGk8n-0008AP-78
 for linux-um@lists.infradead.org; Mon, 01 Mar 2021 15:07:22 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 0/8] PCI support for UML
Date: Mon,  1 Mar 2021 16:07:00 +0100
Message-Id: <20210301150708.244970-1-johannes@sipsolutions.net>
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
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org

Hi,

Changes since v1:
 - fix a memory leak in the PCI code
 - fix race in interrupt handling
 - fix checks in interrupt handling
 - use asm-generic for fb.h and vga.h
 - rediff against v5.12-rc1
 - export signals_enabled directly


Original description:

In order to simulate some devices and write tests completely
independent of real PCI devices, we continued the development
of time-travel and related bits, and are adding PCI support
here now.

The way it works is that it communicates with the outside (of
UML) with virtio, which we previously added using vhost-user,
and then offers a PCI bus to the inside system, where normal
PCI probing etc. happens, but all config space & IO accesses
are forwarded over virtio.

To enable that, add lib/logic_iomem, similar to logic_pio but
for iomem regions, this way, ioread/iowrite can be redirected
over the virtio device.

Since currently no official virtio device ID is assigned yet
a Kconfig option for that is required to be set to the value
you want to use locally for experimentation. Once we have an
official value we can change the default (currently -1 which
makes it non-functional) or remove the option entirely.

johannes





_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

