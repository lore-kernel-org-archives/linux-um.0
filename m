Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EQkN3-00076V-Rq	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Oct 2005 04:38:37 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EQkN1-0001yL-Cu
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Oct 2005 04:38:37 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.14-rc4;
	panic: do_syscall_stub : failed to wait for SIGUSR1/SIGTRAP
References: <Pine.LNX.4.64.0510122241080.6495@sparrow>
In-Reply-To: <Pine.LNX.4.64.0510122241080.6495@sparrow>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510151337.44854.blaisorblade@yahoo.it>
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
Date: Sat, 15 Oct 2005 13:37:44 +0200
To: user-mode-linux-devel@lists.sourceforge.net, William Stearns <wstearns@pobox.com>

On Thursday 13 October 2005 05:39, William Stearns wrote:
> Good evening, all,
>  	This is from 2.6.14-rc4 + Jeff's 2 patches:
> [PATCH 1/2] UML - Fix Al's build tidying

>  	(was there ever a 2/2?  I didn't see one in the list)
Yes, there was, but was about sysrq-t (and had as title only "[PATCH 2/2] 
UML).

> UML - Resend - Revert use of host AIO

>  	i386 FC3 host has no skas patch, so skas0 is in effect.

> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> VFS: Mounted root (ext2 filesystem) readonly.
> Kernel panic - not syncing: do_syscall_stub : failed to wait for
> SIGUSR1/SIGTRAP, pid = 3357, n = 3357, errno = 0, status = 0xb7f
With which compilers? It has been reported that SKAS0 is (rightfully) 
miscompiled by some GCC, and I have some fixes. I'm porting them to 2.6.14 
too.

Btw, the thing should be the same as 2.6.13; 2.6.13-bs4 has the fixes for this 
instead - but read the NEWS page on my site for a note about COW files 
compatibility.


>  	This first kernel didn't have tt support built in, so I recompiled
> with tt support as well and ran it with a mode=tt and it got further:

> Enabling local filesystem quotas:  [  OK  ]
> swapon: /dev/ubd/1: No such device or address
This is some kind of setup error - which was your previous kernel? 2.6.13 
onwards have no DevFS.
>                                               Enabling swap space:  [  OK
> ]
> Kernel panic - not syncing: Kernel mode fault at addr 0x66ab, ip
> 0xa002f711
This is really strange...
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
