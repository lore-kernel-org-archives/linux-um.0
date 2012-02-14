Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
From: Venkatesh Pallipadi <venki@google.com>
Date: Tue, 14 Feb 2012 14:49:42 -0800
Message-Id: <1329259784-20592-2-git-send-email-venki@google.com>
In-Reply-To: <1329259784-20592-1-git-send-email-venki@google.com>
References: <87wr7pbwbz.fsf@rustcorp.com.au>
 <1329259784-20592-1-git-send-email-venki@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 1/3] hexagon: Avoid raw handling of cpu_possible_map
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Tony Luck <tony.luck@gmail.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, KOSAKI Motohiro <kosaki.motohiro@gmail.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Mike Travis <travis@sgi.com>, "Paul E. McKenney" <paul.mckenney@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, Venkatesh Pallipadi <venki@google.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Use set_cpu_possible instead.

Signed-off-by: Venkatesh Pallipadi <venki@google.com>
---
 arch/hexagon/kernel/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index c871a2c..8962705 100644
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -272,5 +272,5 @@ void smp_start_cpus(void)
 	int i;
 
 	for (i = 0; i < NR_CPUS; i++)
-		cpu_set(i, cpu_possible_map);
+		set_cpu_possible(i, true);
 }
-- 
1.7.7.3

