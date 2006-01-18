Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzCir-0008Gf-0X for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 04:47:33 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EzCiq-0006sg-HU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 04:47:33 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20060118002225.003080b1.akpm@osdl.org>
	<200601181217.31461.blaisorblade@yahoo.it>
	<20060118033122.40e5d8b3.akpm@osdl.org>
In-Reply-To: <20060118033122.40e5d8b3.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601181347.27276.blaisorblade@yahoo.it>
Subject: [uml-devel] Using compiler.h from uml userspace code (was: Re: uml
	build error)
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 18 Jan 2006 13:47:26 +0100
To: sam@ravnborg.org, user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, jdike@addtoit.com

On Wednesday 18 January 2006 12:31, Andrew Morton wrote:
> Blaisorblade <blaisorblade@yahoo.it> wrote:
> > On Wednesday 18 January 2006 09:22, Andrew Morton wrote:
> > > arch/um/os-Linux/umid.c:319: warning: `__uml_help_set_uml_dir' defined
> > > but not used arch/um/os-Linux/umid.c:319: warning:
> > > `__uml_setup_set_uml_dir' defined but not used
> > > arch/um/os-Linux/umid.c:335: warning:
> > > `__uml_exitcall_remove_umid_dir' defined but not used
> >
> > I never see those things (gcc 3.4), there should be a attribute((used))
> > for them, however it's replicated from compiler.h, as it can't be
> > included.

> gcc-3.2.1

Yep, it wants attribute((unused)) instead of all other ones. Damn right.

Possible solutions below - akpm doesn't need to read this. Sam, instead, 
please do read and give an opinion.

Found it: we're using __attribute_used__ from /usr/include/sys/cdefs.h rather 
than from compiler.h, because we can't include that... and <sys/cdefs.h> is 
buggy for this (see below).

But I've found a way to reuse compiler.h! Sam, could this go in?

Index: linux-2.6.git/include/linux/compiler.h
===================================================================
--- linux-2.6.git.orig/include/linux/compiler.h
+++ linux-2.6.git/include/linux/compiler.h
@@ -39,9 +39,9 @@ extern void __chk_io_ptr(void __iomem *)
 #if __GNUC__ > 4
 #error no compiler-gcc.h file for this gcc version
 #elif __GNUC__ == 4
-# include <linux/compiler-gcc4.h>
+# include "compiler-gcc4.h"
 #elif __GNUC__ == 3
-# include <linux/compiler-gcc3.h>
+# include "compiler-gcc3.h"
 #else
 # error Sorry, your compiler is too old/not recognized.
 #endif
@@ -50,7 +50,7 @@ extern void __chk_io_ptr(void __iomem *)
  * coming from above header files here
  */
 #ifdef __INTEL_COMPILER
-# include <linux/compiler-intel.h>
+# include "compiler-intel.h"
 #endif

 /*


With that in, just symlinking include/linux/compiler-*.h into arch/um/include 
would work well!

We prefer to avoid them included as <linux/compiler-*.h> because it could 
conflict with host headers, unless it's possible to have our headers searched 
before host ones.

==== <sys/cdefs.h>
I discovered that /usr/include/sys/cdefs.h has this define (which is likely 
the used definition!):

/* At some point during the gcc 3.1 development the `used' attribute
   for functions was introduced.  We don't want to use it unconditionally
   (although this would be possible) since it generates warnings.  */
#if __GNUC_PREREQ (3,1)
# define __attribute_used__ __attribute__ ((__used__))
# define __attribute_noinline__ __attribute__ ((__noinline__))
#else
# define __attribute_used__ __attribute__ ((__unused__))
# define __attribute_noinline__ /* Ignore */
#endif

while include/linux/compiler-gcc3.h tests for different minor (it requires 
>=3.3).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
