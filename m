Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AM7i6-0007uK-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 18 Nov 2003 07:24:10 -0800
Received: from mail.clemson.edu ([130.127.28.87] helo=CLEMSON.EDU)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AM7i5-0003GW-Q7
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 18 Nov 2003 07:24:09 -0800
Received: from LAB2500.clemson.edu (csdhcp37.cs.clemson.edu [130.127.49.181])
	(authenticated bits=0)
	by CLEMSON.EDU (8.12.8p1-20030924/8.12.8) with ESMTP id hAIFNg42011727
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 18 Nov 2003 10:23:43 -0500 (EST)
Message-Id: <5.2.1.1.2.20031118100745.00a77cb8@mail.clemson.edu>
From: Vinod K Rajasekaran <vrajase@CLEMSON.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: [uml-devel] Need help
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
Date: Tue, 18 Nov 2003 10:23:40 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I am a absolute rank UML beginner.... I got UML installed on my Redhat 9.0 
box using the  "user_mode_linux-2.4.19.5um-0.i386.rpm"

I then tried to install a file system from the binaries. But it gave a 
kernel panic! Then I tried installing Redhat 8.0 using the UMLbuilder... 
but wasn't successful again... I get the same kernel panic... I get the 
following message..


Successful
Calculating packages, dependencies and install order
========================================|100% Done.
Successful
Working in /home/vinod/UML/vm1
Making directories
Making files
Setting up swapspace version 1, size = 134213 kB
Populating install filesystem
========================================|100% Done.
Successful
Running install process
tracing thread pid = 27133
Linux version 2.4.19-5um (jdike@uml.karaya.com) (gcc version 2.96 20000731 
(Red
Hat Linux 7.1 2.96-81)) #2 Mon Sep 16 15:41:15 EDT 2002
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: rw umid=vm1 ubd0=rootfs root=/dev/ubd0 mem=64m 
ubd7=install
fs eth0=tuntap,,,10.0.0.4 root=/dev/ubd7 init=/uml_stage2install.py 
con0=pts,fd:
1
Calibrating delay loop... 3196.70 BogoMIPS
Memory: 62616k available
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Kernel panic: outer trampoline didn't exit with SIGKILL

Install failed
result of system is 256
Installation failed.


Is this a known issue....Can someone help me with this....

Thanks,
  -Vinod.



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
