Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CyZJh-0006pY-QG for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 09:38:25 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CyZJe-0004pI-S1 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 09:38:25 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
	<200502081829.j18ITAs0003968@ccure.user-mode-linux.org>
In-Reply-To: <200502081829.j18ITAs0003968@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502081837.22519.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [BUG report] UML linux-2.6 latest BK doesn't compile
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
Date: Tue, 8 Feb 2005 18:37:22 +0100
To: Anton Altaparmakov <aia21@cam.ac.uk>, Jeff Dike <jdike@addtoit.com>
Cc: lkml <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 08 February 2005 19:29, Jeff Dike wrote:
> aia21@cam.ac.uk said:
> > arch/um/kernel/exec_kern.c:59: undefined reference to `__bb_init_func'
>
> The __bb_init_func export is to allow modules to be built with a
> gcov-enabled UML.  I get a bunch of undefines in the module links when I
> get rid of it.
>
> This is probably being too intimate with libc, and yours probably doesn't
> have __bb_init_func.
>
> Try the patch below and see if it helps.  Modules won't work, but you
> should get a working UML.

Why not simply disable CONFIG_GCOV for him, in this case?

Sorry for my previous answer, I was misleaded by the error message (which 
*does not* make sense). And it's the first time anybody sees a such error 
message, in my experience, so please post more details about your glibc (and 
whether gcov is installed).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
