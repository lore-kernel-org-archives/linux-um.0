Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIGWl-00GFpD-ML
 for linux-um@lists.infradead.org; Fri, 05 Mar 2021 19:54:28 +0000
Message-ID: <e8b84a87173e80d1e3b602f280b564b0b758c879.camel@sipsolutions.net>
Subject: Re: linux uml segfault
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 05 Mar 2021 20:54:11 +0100
In-Reply-To: <01a1b3551284a39a3c06ab2ec0222cbf6099a537.camel@sipsolutions.net>
References: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
 <6d37b5aa-36f2-1fce-b70b-8faa0ff882e0@kot-begemot.co.uk>
 <c8bb257c-1542-12f5-89f1-5c1f14b8a70a@collabora.com>
 <db40449e-6916-56bf-377c-01b042b9c890@kot-begemot.co.uk>
 <529cd4e2f39efffb18125dffab3058aeec3351ce.camel@debian.org>
 <573e256a-990b-ddf6-7965-367bb8b21229@kot-begemot.co.uk>
 <1bdedf3c60058e1ae242a2a7f16eee256b0be3e0.camel@debian.org>
 <6370b92a-84fa-aa21-4270-fcaf1bf42407@kot-begemot.co.uk>
 <02e348bbb13f0fac92f2147309fb1c006b4583b2.camel@debian.org>
 <5ee28b97-6111-e12c-d0e9-83a13f2151ce@kot-begemot.co.uk>
 <5e068447e2067fff8b21c0689f14d080b984f6e0.camel@debian.org>
 <01a1b3551284a39a3c06ab2ec0222cbf6099a537.camel@sipsolutions.net>
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
To: rrs@debian.org, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Christopher Obbard <chris.obbard@collabora.com>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Cc: 983379@bugs.debian.org

On Wed, 2021-03-03 at 23:40 +0100, Johannes Berg wrote:

> Now libcom_err.so.2 is trying to call sem_init(), and that gets ... tada
> ... Linux's sem_init() instead of libpthread's.
> 
> And then the crash.

FWIW, I can trivially reproduce this by simply force-loading
libcom_err.so:


diff --git a/arch/um/Makefile b/arch/um/Makefile
index 1cea46ff9bb7..a16b411154fb 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -134,7 +134,7 @@ LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS),-Wl,$(opt))
 
 # Used by link-vmlinux.sh which has special support for um link
-export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
+export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) -ldl
 
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index c8a42ecbd7a2..873dc4c40cb7 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -16,6 +16,7 @@
 #include <kern_util.h>
 #include <os.h>
 #include <um_malloc.h>
+#include <dlfcn.h>
 
 #define PGD_BOUND (4 * 1024 * 1024)
 #define STACKSIZE (8 * 1024 * 1024)
@@ -115,6 +116,8 @@ int __init main(int argc, char **argv, char **envp)
 
 	setsid();
 
+dlopen("/usr/lib64/libcom_err.so.2", RTLD_NOW|RTLD_GLOBAL);
+
 	new_argv = malloc((argc + 1) * sizeof(char *));
 	if (new_argv == NULL) {
 		perror("Mallocing argv");


johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

