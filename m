Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A05Ws-00079I-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Sep 2003 13:37:30 -0700
Received: from hongkong.cs.nmsu.edu ([128.123.64.160] ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A05Wr-0007cg-HC
	for User-mode-linux-devel@lists.sourceforge.net; Thu, 18 Sep 2003 13:37:29 -0700
From: Ross Combs <rocombs@cs.nmsu.edu>
Message-Id: <200309182037.h8IKbMEk028815@hongkong.cs.nmsu.edu>
Subject: [uml-devel] Re: Re: compile problem with uml-patch-2.4.22-4
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 18 Sep 2003 14:37:22 -0600
To: User-mode-linux-devel@lists.sourceforge.net

Patrick,

Thanks.  I really was planning on working on those this weekend.
I have made a few comments below.


> +Separate Kernel Address Space support
> +CONFIG_MODE_SKAS
> +  This option controls whether skas (separate kernel address space)
> +  support is compiled in.  If you have applied the skas patch to the
> +  host, then you certainly want to say Y here (and consider saying N
> +  to CONFIG_MODE_TT).  Otherwise, it is safe to say Y.  Disabling this
> +  option will shrink the UML binary slightly.

It might be good to mention that the host needs /proc/mm support.


> +2G/2G host address space split
> +CONFIG_HOST_2G_2G
> +  Most Linux machines are configured so that the kernel occupies the
> +  upper 1G of the 4G address space and processes use the lower 3G.
> +  However, some machine are configured with a 2G/2G split, with the
> +  kernel occupying the upper 2G and processes using the lower 2G.
> +
> +  To allow UML to run on a host you have to say Y here. N should be
> +  a save choice most of the time.

s/to run on a/to run on such a/
s/a save choice/a safe choice/


> +Support for high memory
> +CONFIG_HIGHMEM
> +  Currently broken, so N is the save answer.

s/save/safe/


> +Support for /proc/mm
> +CONFIG_PROC_MM
> +  If you don't know what this does just say Y.

How about this?:
 Enables address space separation through /proc/mm.  A host
 kernel needs to have this enabled in order for UML to run in
 skas mode.  UML kernels do not need to have this option unless
 they will host sub-UMLs.

 If you don't know what this does just say Y.


> +Support for software watchdog inside UML
> +CONFIG_UML_WATCHDOG
> +  It's save to say N here.

Could we borrow one of the descriptions from the main kernel watchdog
drivers?


-Ross


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
