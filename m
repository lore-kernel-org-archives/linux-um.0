Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtkCm-0000QW-9Y for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 May 2008 07:01:12 -0700
Received: from smtp-1.orange.nl ([193.252.22.241])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JtkCZ-00019p-Sl
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 May 2008 07:01:01 -0700
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6007.orange.nl (SMTP Server) with ESMTP id 1F11C700009A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed,  7 May 2008 16:00:43 +0200 (CEST)
Received: from [127.0.0.1] (c529de59c.cable.wanadoo.nl [82.157.229.156])
	by mwinf6007.orange.nl (SMTP Server) with ESMTP id 04D0E7000081
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed,  7 May 2008 16:00:42 +0200 (CEST)
Message-ID: <4821B5FC.40307@vulnscan.org>
Date: Wed, 07 May 2008 16:00:28 +0200
From: "Bram Matthys (Syzop)" <syzop@vulnscan.org>
MIME-Version: 1.0
Subject: [uml-devel] umls unresponsive & consuming 100% cpu time
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I'm experiencing the following problem:
I upgraded from 2.6.20.1 to 2.6.25 on both the host and the uml's.
Now, after some time (unsure how soon), the uml's appear to hang.
It seems though, that they are not completely freezed, but just very very
very slow (or rather.. 99% unresponsive).

top:
~  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
~ 5434 virt      20   0  128m  89m  89m R   99  4.5 269:40.81 linux
..so consuming nearly 100% cpu.

When typing a letter at the console (I run the umls in a screen), it goes
slow, sometimes it takes up to a minute or so... so I can hardly login
(actually it does process/buffer my line, but by the time the username is
entered and it prompts for the password the login time of 60s is exceeded).
Also, there are no errors (like kernel warnings) displayed on the console.

When pinging I get:
PING slave (192.168.22.11) 56(84) bytes of data.
~From slave (192.168.22.1) icmp_seq=2 Destination Host Unreachable
~From slave (192.168.22.1) icmp_seq=3 Destination Host Unreachable
- -more more-
64 bytes from slave (192.168.22.11): icmp_seq=26 ttl=64 time=111 ms
- -yes, just one.. then delay... and then..-
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
- -more-

When doing a version request using uml_mconsole I get a respond after delay
of like 25 seconds, then quick subsequent requests work too, then they no
longer do for like 34 seconds, then a reply, etc etc etc.

I'm not sure if this is actually correct (I know the 'linux' image
corresponds to the running slave kernel but I'm unsure about the backtrace
it shows), but here's some gdb stuff:
- -gdb-
srv1:/home/virt# gdb linux 5434
GNU gdb 6.4.90-debian
Copyright (C) 2006 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i486-linux-gnu"...Using host libthread_db
library "/lib/tls/i686/cmov/libthread_db.so.1".

Attaching to program: /home/virt/linux, process 5434
0x0809647a in update_xtime_cache ()
(gdb) bt
#0  0x0809647a in update_xtime_cache ()
(gdb) c
Continuing.
^C
Program received signal SIGINT, Interrupt.
0x08096477 in update_xtime_cache ()
(gdb) bt
#0  0x08096477 in update_xtime_cache ()
(gdb) c
Continuing.
^C
Program received signal SIGINT, Interrupt.
0x0809645a in update_xtime_cache ()
(gdb) bt
#0  0x0809645a in update_xtime_cache ()
(gdb) c
Continuing.
^C
Program received signal SIGINT, Interrupt.
0x0809645d in update_xtime_cache ()
(gdb) bt
#0  0x0809645d in update_xtime_cache ()
(gdb)
..so each time I ctrl+c after a few secs to see where it's at, it's in there..

Any ideas what this could be?

Or any help on how to get additional / useful info?

TIA,

	Bram.

- --
Bram Matthys
Software developer/IT consultant        syzop@vulnscan.org
PGP key:                       www.vulnscan.org/pubkey.asc
PGP fp: 8DD4 437E 9BA8 09AA 0A8D  1811 E1C3 D65F E6ED 2AA2
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)

iD8DBQFIIbX846ioc5305a8RAtiMAJ9/MJaGN/6k+711lFVxoX9sUgt5vACgxXgr
qyheRL6nPMJmat49fDS828k=
=0Ra0
-----END PGP SIGNATURE-----


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
