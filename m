Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDKU7-0004ot-Vm for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Mar 2005 02:50:11 -0800
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DDKU6-0007EG-7E for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Mar 2005 02:50:11 -0800
From: Anton Altaparmakov <aia21@cam.ac.uk>
In-Reply-To: <200503201242.23591.blaisorblade@yahoo.it>
References: <200503201242.23591.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1111402190.24494.12.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Testing GCOV handling in -bk
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
Date: Mon, 21 Mar 2005 10:49:49 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, 2005-03-20 at 12:42 +0100, Blaisorblade wrote:
> Anton, would you test the current -bk tree for the CONFIG_GCOV problem and the 
> patch I and Jeff put together?
> 
> http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.11-bk8/patches/weak_gcov_init
> 
> The above should fix the situation for you... for real 3.4 Gcc, however, the 
> problems are bigger because it also requires to change link flags (and this 
> interferes with some executables we build). I also get a link failure on 
> __bb_fork_<something>..., which I haven't been able to solve until now.

I would test it but UML in current -BK doesn't build at all.  It stops
with:

  CC      kernel/signal.o
kernel/signal.c: In function `get_signal_to_deliver':
kernel/signal.c:1849: error: structure has no member named `eflags'
kernel/signal.c:1849: error: `TF_MASK' undeclared (first use in this
function)
kernel/signal.c:1849: error: (Each undeclared identifier is reported
only once
kernel/signal.c:1849: error: for each function it appears in.)
make[1]: *** [kernel/signal.o] Error 1
make: *** [kernel] Error 2

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
