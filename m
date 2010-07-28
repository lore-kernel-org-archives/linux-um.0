Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ratheesh.ksz@gmail.com>) id 1Oe9Qx-0003Ak-UU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jul 2010 16:24:43 +0000
Received: from mail-gw0-f47.google.com ([74.125.83.47])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oe9Qx-00065P-1g for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jul 2010 16:24:43 +0000
Received: by gwb15 with SMTP id 15so1296700gwb.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 28 Jul 2010 09:24:37 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 28 Jul 2010 21:54:37 +0530
Message-ID: <AANLkTi=VnBo4uZ6UUd7WZoKYY1M2D2+YaaX9+wKmNXaK@mail.gmail.com>
From: ratheesh k <ratheesh.ksz@gmail.com>
Subject: [uml-devel] reading heap memory in kernel space .
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

I have a simple user space program .

char *ptr=(char *)malloc(100);
strcpy(ptr , "Hi Kernel  , How are you ");
.........
sendmsg(...)
........


I compiled this program  and executed on 2.6.32 user mode linux .
when i run uml under gdb , i would like to read all memory location
staring from ptr .( whole string ) from kernel .
I have set some break points on some system calls ( sys_sendmsg ). gdb
will break there and if know ptr address , should i convert to
physical address space ? How will i do that ? how will i get
uml_physmem value ?

-ratheesh

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

