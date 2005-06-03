Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DeKIo-0000cn-5q	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Jun 2005 15:06:06 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DeKIj-00005l-W4	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Jun 2005 15:06:06 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Problems applying patches to 2.6.12-rc5-mm1
References: <CBELIFGMBIEPIEOFCJFAEEHBCAAA.Anthony.Brock@oregonstate.edu>
In-Reply-To: <CBELIFGMBIEPIEOFCJFAEEHBCAAA.Anthony.Brock@oregonstate.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506040008.42890.blaisorblade@yahoo.it>
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
Date: Sat, 4 Jun 2005 00:08:42 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anthony Brock <Anthony.Brock@oregonstate.edu>, jdike@addtoit.com, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Friday 03 June 2005 04:52, Anthony Brock wrote:
> I shutdown the process and, just to confirm, restarted it. I received the
> following on the console:
>
>
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...check_sysemu :
> expected SIGTRAP or (SIGTRAP|0x80), got status = 7295

WSTOPSIG(status) is 28
The signal is: Window changed

Jeff, what has happened with the SIGWINCH problems? Also I remember a patch 
from Bodo about not losting SIGWINCH (or something like that)...
> After checking the process table, I confirmed that the kernel had fully
> crashed. So I attempted to launch it again. Once more, I have extraneous
> processes in the table:


> So, I decided to down-grade to the older 2.6.11.11-bs5 kernel. This is what
> I see when trying to launch:
>

> $ TMP=/dev/shm /var/run/ramfs/linux-2.6.11.11-00-32bit-bs5 umid=bind2
> hwprobe=-sys mem=64M con=pts con0=fd:0,fd:1
> ubd0s=/opt/images/instances/bindsec_root.img
> ubd1s=/opt/images/instances/bindsec_swap.img
> eth0=tuntap,bind2-0,fe:fd:aa:aa:aa:3d root=98:0
> Checking for /proc/mm...not found
> Support for TT mode is disabled, and no SKAS support is present on the
> host. $

> I am now truly baffled. I'm assuming that this means I have problems on the
> host. How do I generate information that will help with trouble-shooting?
> Thanks!

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
