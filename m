Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
Date: Mon, 27 Jan 2020 15:53:51 -0800
Message-Id: <20200127235356.122031-1-brendanhiggins@google.com>
Mime-Version: 1.0
Subject: [PATCH v1 0/5] uml: add more unspecified HAS_IOMEM dependencies
From: Brendan Higgins <brendanhiggins@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>, Richard Cochran <richardcochran@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Michal Simek <michal.simek@xilinx.com>, Andrew Lunn <andrew@lunn.ch>, Robert Hancock <hancock@sedsystems.ca>, Esben Haabendal <esben@geanix.com>, Thomas Gleixner <tglx@linutronix.de>, Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc: heidifahim@google.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, davidgow@google.com, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

# TL;DR

This patchset adds a missing HAS_IOMEM dependency to several drivers in
an attempt to get allyesconfig closer to working for ARCH=um. Although I
had caught all the broken ones in early 5.5[1], some new ones have
broken since then.

# What am I trying to do?

This patchset is part of my attempt to get `make ARCH=um allyesconfig`
to produce a config that will build *and* boot to init, so that I can
use it as a mechanism to run tests[2].

# Why won't allyesconfig break again after this series of fixes?

Well, in short, it will break again; however, as I mentioned above, I am
using UML for testing the kernel, and I am currently working on getting
my tests to run on KernelCI. As part of our testing procedure for
KernelCI, we are planning on building a UML kernel using allyesconfig
and running our tests on it. Thus, we will find out very quickly once
someone breaks allyesconfig again once we get this all working. So this
will keep breaking until we have a build test on KernelCI running, but
we will need to send out these fixes anyway.

Brendan Higgins (5):
  net: axienet: add unspecified HAS_IOMEM dependency
  reset: brcmstb-rescal: add unspecified HAS_IOMEM dependency
  reset: intel: add unspecified HAS_IOMEM dependency
  ptp: 1588_clock_ines: add unspecified HAS_IOMEM dependency
  power: avs: qcom-cpr: add unspecified HAS_IOMEM dependency

 drivers/net/ethernet/xilinx/Kconfig | 1 +
 drivers/power/avs/Kconfig           | 2 +-
 drivers/ptp/Kconfig                 | 1 +
 drivers/reset/Kconfig               | 3 ++-
 4 files changed, 5 insertions(+), 2 deletions(-)

[1] https://lore.kernel.org/lkml/20191211192742.95699-1-brendanhiggins@google.com/
[2] https://bugzilla.kernel.org/show_bug.cgi?id=205223

-- 
2.25.0.341.g760bfbb309-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

