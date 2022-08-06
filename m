Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKPqV-00H10M-5l
	for linux-um@lists.infradead.org; Sat, 06 Aug 2022 19:52:28 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a7so10291442ejp.2
        for <linux-um@lists.infradead.org>; Sat, 06 Aug 2022 12:52:25 -0700 (PDT)
From: Christian Lamparter <chunkeey@gmail.com>
Subject: [PATCH v1 2/2] um: increase default virtual physical memory to 64 MiB
Date: Sat,  6 Aug 2022 21:52:23 +0200
Message-Id: <d7936f11aded13f03871c0d6502d611d6a1e2dc5.1659815468.git.chunkeey@gmail.com>
In-Reply-To: <53b5c5f559cc95fc676cb4cc9e5a8d9f0cb8f58c.1659815468.git.chunkeey@gmail.com>
References: <53b5c5f559cc95fc676cb4cc9e5a8d9f0cb8f58c.1659815468.git.chunkeey@gmail.com>
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
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>

The current 32 MiB of RAM causes OOMs to appear shortly after
booting in a minimal OpenWrt 22.03 configuration with a
5.10.134 kernel.

Of course, passing a "mem=64M" (from the --help text) parameter
works too, but it produces the following (info) message:

| [    0.000000] Unknown kernel command line parameters "mem=64M", will be passed to user space.

That's why, I think it would be nicer, if this is working out
of the box again :).

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 arch/um/kernel/um_arch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 9c6991f42131..58aee676989c 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -131,7 +131,7 @@ static int have_root __initdata;
 static int have_console __initdata;
 
 /* Set in uml_mem_setup and modified in linux_main */
-long long physmem_size = 32 * 1024 * 1024;
+long long physmem_size = 64 * 1024 * 1024;
 EXPORT_SYMBOL(physmem_size);
 
 static const char *usage_string =
-- 
2.36.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

