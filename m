Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fAg4n-0000rp-Kk
 for linux-um@lists.infradead.org; Mon, 23 Apr 2018 18:20:35 +0000
Received: by mail-wr0-x242.google.com with SMTP id p18-v6so24647019wrm.1
 for <linux-um@lists.infradead.org>; Mon, 23 Apr 2018 11:20:21 -0700 (PDT)
Date: Mon, 23 Apr 2018 21:20:17 +0300
From: Alexander Pateenok <pateenoc@gmail.com>
Subject: [PATCH] um: remove uml initcalls
Message-ID: <20180423182017.oxlfhnsrekk34q3b@K55DR>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

__uml_initcall() is not used and .uml.initcall.init section is empty:

$ grep -r '__uml_initcall('
arch/um/include/shared/init.h:#define __uml_initcall(fn)	\
$ readelf -s ../umobj/linux | grep __uml_initcall
 23214: 00000000603b75d8     0 NOTYPE  GLOBAL DEFAULT   32 __uml_initcall_start
 25337: 00000000603b75d8     0 NOTYPE  GLOBAL DEFAULT   32 __uml_initcall_end

So it is unnecessary.

Signed-off-by: Alexander Pateenok <pateenoc@gmail.com>
---
 arch/um/include/asm/common.lds.S |  6 ------
 arch/um/include/shared/init.h    |  5 -----
 arch/um/os-Linux/main.c          | 12 ------------
 3 files changed, 23 deletions(-)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index b30d73ca29d0..7adb4e6b658a 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -53,12 +53,6 @@
 	CON_INITCALL
   }
 
-  .uml.initcall.init : {
-	__uml_initcall_start = .;
-	*(.uml.initcall.init)
-	__uml_initcall_end = .;
-  }
-
   SECURITY_INIT
 
   .exitcall : {
diff --git a/arch/um/include/shared/init.h b/arch/um/include/shared/init.h
index b3f5865a92c9..c66de434a983 100644
--- a/arch/um/include/shared/init.h
+++ b/arch/um/include/shared/init.h
@@ -64,14 +64,10 @@ struct uml_param {
         int (*setup_func)(char *, int *);
 };
 
-extern initcall_t __uml_initcall_start, __uml_initcall_end;
 extern initcall_t __uml_postsetup_start, __uml_postsetup_end;
 extern const char *__uml_help_start, *__uml_help_end;
 #endif
 
-#define __uml_initcall(fn)					  	\
-	static initcall_t __uml_initcall_##fn __uml_init_call = fn
-
 #define __uml_exitcall(fn)						\
 	static exitcall_t __uml_exitcall_##fn __uml_exit_call = fn
 
@@ -108,7 +104,6 @@ extern struct uml_param __uml_setup_start, __uml_setup_end;
  */
 #define __uml_init_setup	__used __section(.uml.setup.init)
 #define __uml_setup_help	__used __section(.uml.help.init)
-#define __uml_init_call		__used __section(.uml.initcall.init)
 #define __uml_postsetup_call	__used __section(.uml.postsetup.init)
 #define __uml_exit_call		__used __section(.uml.exitcall.exit)
 
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 5f970ece5ac3..f1fee2b91239 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -40,17 +40,6 @@ static void set_stklim(void)
 	}
 }
 
-static __init void do_uml_initcalls(void)
-{
-	initcall_t *call;
-
-	call = &__uml_initcall_start;
-	while (call < &__uml_initcall_end) {
-		(*call)();
-		call++;
-	}
-}
-
 static void last_ditch_exit(int sig)
 {
 	uml_cleanup();
@@ -151,7 +140,6 @@ int __init main(int argc, char **argv, char **envp)
 	scan_elf_aux(envp);
 #endif
 
-	do_uml_initcalls();
 	change_sig(SIGPIPE, 0);
 	ret = linux_main(argc, argv);
 
-- 
2.16.3


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

