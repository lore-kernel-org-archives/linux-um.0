Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzJbw-0000j0-Sj for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 11:04:20 -0800
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252] ident=93)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CzJbw-00066i-DV
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 11:04:20 -0800
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Message-ID: <20050210190412.GC8859@parcelfarce.linux.theplanet.co.uk>
References: <200502101939.23300.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502101939.23300.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: uml kbuild cleanup (cross-build) - some fixes and
	comments
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
Date: Thu, 10 Feb 2005 19:04:12 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Thu, Feb 10, 2005 at 07:39:23PM +0100, Blaisorblade wrote:
> 3) I don't understand how vmlinux.lds.S is created... it's a symlink, but it's 
> created nowhere after the patch - maybe I overlook something, maybe you 
> didn't do "make clean" and retest.

Not a symlink anymore.  It's right there in the patch -

+#include <linux/config.h>
+#ifdef CONFIG_LD_SCRIPT_STATIC
+#include "uml.lds.S"
+#else
+#include "dyn.lds.S"
+#endif

and it gives you want you want without any symlinks.  And it will get a
dependency (see .vmlinux.lds.cmd after build) on the right things:

deps_arch/um/kernel/vmlinux.lds := \
  /home/users/al/kernel/RC11-rc3-bk6-current/arch/um/kernel/vmlinux.lds.S \
    $(wildcard include/config/ld/script/static.h) \
  /home/users/al/kernel/RC11-rc3-bk6-current/include/linux/config.h \
    $(wildcard include/config/h.h) \
  /home/users/al/kernel/RC11-rc3-bk6-current/arch/um/kernel/uml.lds.S \
  /home/users/al/kernel/RC11-rc3-bk6-current/include/asm-generic/vmlinux.lds.h \
  include2/asm/common.lds.S \

It gets rebuilt if vmlinux.lds.S changes or uml.lds.S changes or
CONFIG_LD_SCRIPT_STATIC gets changed.

That was from build with LD_SCRIPT_STATIC; turn it off and that will
	a) trigger rebuild of vmlinux.lds (include/config/ld/script/static.h
dependency will take care of that)
	b) replace dependency on uml.lds.S with that on dyn.lds.S.

No need to mess with symlinks, these files are going through preprocessor
anyway, so we have #ifdef and #include...


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
