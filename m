Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKy9Y-00DFO1-G9
 for linux-um@lists.infradead.org; Fri, 18 Feb 2022 07:58:10 +0000
Received: by mail-pf1-x449.google.com with SMTP id
 d16-20020a056a0010d000b004e0204c9753so1287189pfu.7
 for <linux-um@lists.infradead.org>; Thu, 17 Feb 2022 23:58:07 -0800 (PST)
Date: Fri, 18 Feb 2022 15:57:26 +0800
In-Reply-To: <20220218075727.2737623-1-davidgow@google.com>
Message-Id: <20220218075727.2737623-4-davidgow@google.com>
Mime-Version: 1.0
References: <20220218075727.2737623-1-davidgow@google.com>
Subject: [PATCH 3/4] IB/qib: Compile under User-Mode Linux
From: David Gow <davidgow@google.com>
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: David Gow <davidgow@google.com>, linux-um@lists.infradead.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org, felix.kuehling@amd.com, linux-kernel@vger.kernel.org

The User-Mode-Linux architecture (with the x86_64 subarch) defines
CONFIG_X86_64, but doesn't expose the cpuinfo_x86 struct (instead
there's a cpuinfo_um struct).

In order to allow UML to build with allyesconfig, only check cpuinfo_x86
on non-UML architectures.

Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/infiniband/hw/qib/qib_wc_x86_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/qib/qib_wc_x86_64.c b/drivers/infiniband/hw/qib/qib_wc_x86_64.c
index edd0ddbd4481..76fef1321c26 100644
--- a/drivers/infiniband/hw/qib/qib_wc_x86_64.c
+++ b/drivers/infiniband/hw/qib/qib_wc_x86_64.c
@@ -146,5 +146,9 @@ void qib_disable_wc(struct qib_devdata *dd)
  */
 int qib_unordered_wc(void)
 {
+#ifndef CONFIG_UML
 	return boot_cpu_data.x86_vendor != X86_VENDOR_AMD;
+#else
+	return 0;
+#endif
 }
-- 
2.35.1.265.g69c8d7142f-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

