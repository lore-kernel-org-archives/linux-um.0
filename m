Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zZwM-0006mG-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 03:53:42 -0700
Received: from mout0.freenet.de ([194.97.50.131])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zZwL-0006FM-Un
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 03:53:42 -0700
Received: from [194.97.50.138] (helo=mx0.freenet.de)
	by mout0.freenet.de with asmtp (Exim 4.22)
	id 19zZwK-0007Et-2X
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 12:53:40 +0200
Received: from b970e.pppool.de ([213.7.151.14] helo=home.petschge.de)
	by mx0.freenet.de with esmtp (Exim 4.23 #2)
	id 19zZwI-00008n-AT
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 12:53:39 +0200
Received: from localhost (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id D07253BCE5
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 12:52:10 +0200 (CEST)
Received: from mars (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id ADBB63BCE4
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 12:52:07 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Patrick Kilian <petschge@gmx.de>
Reply-To: petschge@web.de
MIME-Version: 1.0
Message-Id: <200309171252.06937.petschge@gmx.de>
Subject: [uml-devel] Problem with 2.4.22-um4
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
Date: Wed, 17 Sep 2003 12:52:06 +0200
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I got a problem with 2.4.22-um4 that I can't track down. I'm using a 
clean 2.4.22 kernel from kernel.org patched with the um4 patch from 
user-mode-linux.sourceforge.net. I ran make xconfig ARCH=um and enabled 
support for "Anonymous memory device". Than I ran make linux ARCH=um 
but when I start the binary I get:

host$ ./linux-2.4.22  ubd0=cow_3,./root_fs/own2 
eth0=tuntap,,,192.168.0.100 root=/dev/ubd0
Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid = 12078
Linux version 2.4.22-4um (root@mars) (gcc version 2.95.3 20010315 
(SuSE)) #2 Mit Sep 17 12:41:29 CEST 2003
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ubd0=cow_3,./root_fs/own2 
eth0=tuntap,,,192.168.0.100 root=/dev/ubd0
Calibrating delay loop... 756.76 BogoMIPS
Memory: 28728k available
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...<0>Kernel panic: 
check_sigio : read failed, err = -1

In idle task - not syncing

The host kernel is a 2.4.18 kernel patched by SuSE _without_ skas 
support. gcc version is 2.95.3.

Is this a know bug? Is 2.4.22-um4 unusable without skas? Is this related 
to the patch in arch/um/drivers/ubd_user.c? (Neither the patch from 
Ross Combs nor the patch named ubd_start_io_thread.diff from Steve 
Schmidtke fix this error)

mfg,
Patrick "Petschge" Kilian

-- 
cat /dev/audio > install.rpm and whistle in the micro.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
