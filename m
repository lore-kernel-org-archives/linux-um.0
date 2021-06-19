Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-m121144.qiye.163.com ([115.236.121.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luQKI-00G18M-GB
 for linux-um@lists.infradead.org; Sat, 19 Jun 2021 02:03:16 +0000
From: Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] um: remove unneeded semicolon in um_arch.c
Date: Sat, 19 Jun 2021 10:02:59 +0800
Message-Id: <20210619020301.77672-1-wanjiabing@vivo.com>
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes.berg@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Desaulniers <ndesaulniers@gooogle.com>, Corey Minyard <cminyard@mvista.com>, Thomas Meyer <thomas@m3y3r.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Joe Perches <joe@perches.com>, Wan Jiabing <wanjiabing@vivo.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./arch/um/kernel/um_arch.c:284:34-35: Unneeded semicolon

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/um/kernel/um_arch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index f9f1463f0521..a149a5e9a16a 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -281,7 +281,7 @@ static void parse_host_cpu_flags(char *line)
 	int i;
 	for (i = 0; i < 32*NCAPINTS; i++) {
 		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]))
-			set_cpu_cap(&boot_cpu_data, i);;
+			set_cpu_cap(&boot_cpu_data, i);
 	}
 }
 static void parse_cache_line(char *line)
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

