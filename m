Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A05dB-0001dX-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Sep 2003 13:44:01 -0700
Received: from hongkong.cs.nmsu.edu ([128.123.64.160] ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A05cL-0002fI-NH
	for User-mode-linux-devel@lists.sourceforge.net; Thu, 18 Sep 2003 13:43:09 -0700
From: Ross Combs <rocombs@cs.nmsu.edu>
Message-Id: <200309182043.h8IKh3l8028931@hongkong.cs.nmsu.edu>
Subject: [uml-devel] Re: redefinition of `struct ptrace_faultinfo' with uml-2.4.22-4 + skas3
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
Date: Thu, 18 Sep 2003 14:43:03 -0600
To: User-mode-linux-devel@lists.sourceforge.net

Nix <nix@es...> wrote:

> [...]
> 
>  io_thread - read failed, err = 9
>  Kernel panic: Kernel mode signal 8
>   
>  <6>Initializing stdio console driver
>  Netdevice 0 : TUN/TAP backend - 
>  NET4: Linux TCP/IP 1.0 for NET4.0
>  IP Protocols: ICMP, UDP, TCP, IGMP
>  IP: routing cache hash table of 512 buckets, 4Kbytes
>  TCP: Hash tables configured (established 2048 bind 2048)
>  ip_conntrack version 2.1 (235 buckets, 1880 max) - 288 bytes per conntrack
>  ip_tables: (C) 2000-2002 Netfilter core team
>  ipt_recent v0.3.1: Stephen Frost <sfrost@sn...>.  http://snowman.net/projects/ipt_recent/
>  NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>  NET4: Ethernet Bridge 008 for NET4.0
>  [freeze]

I'm not sure it's TUN/TAP.  The io_thread error above looks like
the problem I was having which was also sporadic.  Try Steve's patch
or the merged patch I posted and see if it fixes that part.

-Ross


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
