Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dUKTi-0007T5-1F
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jul 2017 22:14:58 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dUKTg-0006LI-2C
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jul 2017 22:14:58 +0000
From: Thomas Meyer <thomas@m3y3r.de>
Date: Mon, 10 Jul 2017 00:14:35 +0200
Message-Id: <20170709221435.12260-1-thomas@m3y3r.de>
In-Reply-To: <195e897b-34db-f29f-fdff-f2c86ce86193@nod.at>
References: <195e897b-34db-f29f-fdff-f2c86ce86193@nod.at>
Subject: [uml-devel] [PATCH] um: v2: Fix gcc-plugins dependency
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: richard@nod.at, user-mode-linux-devel@lists.sourceforge.net

Ensure to build the gcc-plugins for user-offsets.s

The target arch/x86/um/user-offsets.s is build with normal CC flags, i.e with
gcc plugins, e.g. -fplugin=./scripts/gcc-plugins/latent_entropy_plugin.so

Ensure to build all gcc-plugins before trying to build this target; else an error
message is thrown:

cc1: error: cannot load plugin ./scripts/gcc-plugins/structleak_plugin.so
   ./scripts/gcc-plugins/structleak_plugin.so: cannot open shared object file: No such file or directory
cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy_plugin.so
   ./scripts/gcc-plugins/latent_entropy_plugin.so: cannot open shared object file: No such file or directory
cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so
   ./scripts/gcc-plugins/randomize_layout_plugin.so: cannot open shared object file: No such file or directory
make[1]: *** [scripts/Makefile.build:154: arch/x86/um/user-offsets.s] Error 1
make: *** [arch/um/Makefile:150: arch/x86/um/user-offsets.s] Error 2

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 0ca46ededfc7..7cb04d9da544 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -146,7 +146,7 @@ archclean:
 
 # Generated files
 
-$(HOST_DIR)/um/user-offsets.s: __headers FORCE
+$(HOST_DIR)/um/user-offsets.s: gcc-plugins __headers FORCE
 	$(Q)$(MAKE) $(build)=$(HOST_DIR)/um $@
 
 define filechk_gen-asm-offsets
-- 
2.13.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

