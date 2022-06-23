Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from madras.collabora.co.uk ([46.235.227.172])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4Igb-00EDke-Pb
	for linux-um@lists.infradead.org; Thu, 23 Jun 2022 08:59:39 +0000
From: Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH] um: random: Don't initialise hwrng struct with zero
Date: Thu, 23 Jun 2022 09:58:42 +0100
Message-Id: <20220623085842.238829-1-chris.obbard@collabora.com>
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
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>, kernel test robot <lkp@intel.com>

Initialising the hwrng struct with zeros causes a
compile-time sparse warning:

 $ ARCH=um make -j10 W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
 ...
 CHECK   arch/um/drivers/random.c
 arch/um/drivers/random.c:31:31: sparse: warning: Using plain integer as NULL pointer

Fix the warning by not initialising the hwrng struct
with zeros as it is initialised anyway during module
init.

Fixes: 72d3e093afae ("um: random: Register random as hwrng-core device")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---
 arch/um/drivers/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/random.c b/arch/um/drivers/random.c
index 433a3f8f2ef3..32b3341fe970 100644
--- a/arch/um/drivers/random.c
+++ b/arch/um/drivers/random.c
@@ -28,7 +28,7 @@
  * protects against a module being loaded twice at the same time.
  */
 static int random_fd = -1;
-static struct hwrng hwrng = { 0, };
+static struct hwrng hwrng;
 static DECLARE_COMPLETION(have_data);
 
 static int rng_dev_read(struct hwrng *rng, void *buf, size_t max, bool block)
-- 
2.36.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

