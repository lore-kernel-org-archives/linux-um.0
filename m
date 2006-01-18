Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzKyP-00032v-Et for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 13:36:09 -0800
Received: from pasmtp.tele.dk ([193.162.159.95])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EzKyM-0008Nk-K4
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 13:36:09 -0800
From: Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20060118213546.GC15828@mars.ravnborg.org>
References: <20060118002225.003080b1.akpm@osdl.org>
	<200601181217.31461.blaisorblade@yahoo.it>
	<20060118033122.40e5d8b3.akpm@osdl.org>
	<200601181347.27276.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601181347.27276.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Using compiler.h from uml userspace code (was: Re:
	uml build error)
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
Date: Wed, 18 Jan 2006 22:35:46 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, jdike@addtoit.com

On Wed, Jan 18, 2006 at 01:47:26PM +0100, Blaisorblade wrote:
> Possible solutions below - akpm doesn't need to read this. Sam, instead, 
> please do read and give an opinion.
> 
> Found it: we're using __attribute_used__ from /usr/include/sys/cdefs.h rather 
> than from compiler.h, because we can't include that... and <sys/cdefs.h> is 
> buggy for this (see below).
> 
> But I've found a way to reuse compiler.h! Sam, could this go in?
> 
> Index: linux-2.6.git/include/linux/compiler.h
> ===================================================================
> --- linux-2.6.git.orig/include/linux/compiler.h
> +++ linux-2.6.git/include/linux/compiler.h
> @@ -39,9 +39,9 @@ extern void __chk_io_ptr(void __iomem *)
>  #if __GNUC__ > 4
>  #error no compiler-gcc.h file for this gcc version
>  #elif __GNUC__ == 4
> -# include <linux/compiler-gcc4.h>
> +# include "compiler-gcc4.h"
>  #elif __GNUC__ == 3
> -# include <linux/compiler-gcc3.h>
> +# include "compiler-gcc3.h"
>  #else
>  # error Sorry, your compiler is too old/not recognized.
>  #endif
> @@ -50,7 +50,7 @@ extern void __chk_io_ptr(void __iomem *)
>   * coming from above header files here
>   */
>  #ifdef __INTEL_COMPILER
> -# include <linux/compiler-intel.h>
> +# include "compiler-intel.h"
>  #endif
> 
>  /*
First off. When I see #include 2foo.h" then this tell me that foo is
found in the same dir as the .c file we are compiling.
gcc though has a much more weak interpretation of the differences
between include <foo.h> and #include "foo.h".

The -I- flag to correct this stupidity is scheduled for removal and when
I asked on the gcc list no-one bothered to answer so I assume this is
all done now in 4.x.
-I- had to purposes, but I cannot recall the other one right now.

From a technical viewpoint nothing is wrong - the only thing being that
human mortals may be confused when suddenly file are included using a
different style than usual.

> With that in, just symlinking include/linux/compiler-*.h into arch/um/include 
> would work well!
> 
> We prefer to avoid them included as <linux/compiler-*.h> because it could 
> conflict with host headers, unless it's possible to have our headers searched 
> before host ones.
Thats perfectly doable if we talk kbuild.
You can just assing to NOSTDINC_FLAGS the directories to search first.

In general I wish all symlinks in the build to hell.
In many cases they are just repairing a badly thought directory
structure include/asm being the worst evil of all.
klibc does the same with no symlinks.

They are indeed needed sometimes - Al Viro poitned out a few cases for
UML where they were the best solution, but do not let it be the hammer
to repair everything.

	Sam


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
