Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJao0-0006ay-4K	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Sep 2005 11:00:52 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EJany-0004ZV-HZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Sep 2005 11:00:52 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Curiosity about nested UML invocations...
References: <200509241913.24060.rob@landley.net>
In-Reply-To: <200509241913.24060.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509251959.49639.blaisorblade@yahoo.it>
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
Date: Sun, 25 Sep 2005 19:59:48 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Sunday 25 September 2005 02:13, Rob Landley wrote:
> So what does "nesting level" actually do, anyway?
For TT mode it's needed because, in the virtual address space, host kernel 
uses 3G-4G, a normal TT mode UML uses 2.5 G - 3G *, so a nested UML must use 
2.0G-2.5G.

* Note: the load address is decided at link time, so this is used even if you 
just compile TT mode in. IOW, when you enable TT mode and you try using more 
than 512M (actually 480M for various reasons), you'd need HIGHMEM, which is 
slow. Disabling TT mode and running SKAS0 is better.
> Trying to run UML from 
> within itself (giving the outer invocation mem=128M), I get the following
> error:

> sh-3.00# ./linux rootfstype=hostfs rw init=/bin/sh LD_ASSUME_KERNEL=2.4.1
> Checking for /proc/mm...not found
> Checking for the skas3 patch in the host...found
> UML running in SKAS0 mode

> os_mode_fd: No such file or directory
Strace would be of help, possibly is looking for some file inside /proc 
(say /proc/cpuinfo, but it exists, so it must be another one).

> sh-3.00#

> Just playing around, really, but now I'm curious...

> Rob

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
