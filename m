Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J7gpg-00033N-A9 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Dec 2007 16:42:44 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J7gpf-0002cY-NY
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Dec 2007 16:42:44 -0800
Date: Wed, 26 Dec 2007 19:42:39 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071227004239.GB8218@c2.user-mode-linux.org>
References: <4772D501.6050306@gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4772D501.6050306@gmail.com>
Subject: Re: [uml-devel] __attribute_used__ error on 2.6.23.9
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Quantum Skyline <quantum.skyline@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Dec 26, 2007 at 02:26:09PM -0800, Quantum Skyline wrote:
> Hi,
> 
> I've been trying to modify the UML makefiles in the 2.6.23.9 kernel to 
> compile against a different C library, but I'm running into trouble 
> getting parts of UML to compile with GCC 4.2.1.  In particular, files in 
> os-Linux that use functions like __uml_setup are causing GCC to throw 
> errors.
> 
> For example, when I try to compile arch/um/os-Linux/aio.c in my 
> environment, I get the following:
> 
> gcc-4.2.1-rev -Wp,-MD,arch/um/os-Linux/.aio.o.d  -Wall -Wundef 
> -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common 
> -Werror-implicit-function-declaration -Os -D__arch_um__ 
> -DSUBARCH=\"i386\" -Dvmap=kernel_vmap 
> -Din6addr_loopback=kernel_in6addr_loopback 
> -Din6addr_any=kernel_in6addr_any -march=i686 
> I know that __uml_setup and friends are defined in 
> arch/um/include/init.h and it is being included, but it seems like GCC 
> is not using it.  If I comment out __uml_setup, other files which have 
> functions starting with two underscores like __uml_initcall also cause 
> compilation to fail.
> 
> Can anyone give some hints to solve this problem?

Probably you need the patch below.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

From: Jeff Dike <jdike@addtoit.com>

init.h started breaking now for some reason.  It turns out that there wasn't a
definition of __used.  Fixed this by copying the relevant stuff from
compiler.h in the userspace case, and including compiler.h in the kernel case.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/um/include/init.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff -puN arch/um/include/init.h~uml-arch-um-include-inith-needs-a-definition-of-__used arch/um/include/init.h
--- a/arch/um/include/init.h~uml-arch-um-include-inith-needs-a-definition-of-__used
+++ a/arch/um/include/init.h
@@ -40,6 +40,15 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
+#ifndef __KERNEL__
+#if __GNUC_MINOR__ >= 3
+# define __used			__attribute__((__used__))
+#else
+# define __used			__attribute__((__unused__))
+#endif
+#else
+#include <linux/compiler.h>
+#endif
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
 #define __init		__attribute__ ((__section__ (".init.text")))
_

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
