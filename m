Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HrVOA-0004s2-Jw for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 May 2007 01:43:10 -0700
Received: from ug-out-1314.google.com ([66.249.92.170])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HrVOA-00041S-0Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 May 2007 01:43:10 -0700
Received: by ug-out-1314.google.com with SMTP id 78so667821ugn
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 25 May 2007 01:43:08 -0700 (PDT)
Message-ID: <dec0fd580705250143v60944d53vd195a587ff425887@mail.gmail.com>
Date: Fri, 25 May 2007 04:43:08 -0400
From: "battipatisainagendra Bhavaniprasad" <sainagendrabhavaniprasad@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] help needed regarding UML installation
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1091771629=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

--===============1091771629==
Content-Type: multipart/alternative; 
	boundary="----=_Part_55296_11461847.1180082588686"

------=_Part_55296_11461847.1180082588686
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,
           This is Prasad,I am trying to install UML on SuSE linux 10.I have
down loaded " user_mode_linux-2.4.19.5um-0.i386.rpm" and "Debian-3.0r0.ext2
".

After installing rpm package, I got "linux" in /usr/bin and i have copied
"linux" in to /home/user1 and gave following command....
linux ubd0=Debian-3.0r0.ext2 but i have got the following error.


linux-3fuv:/home/sai # linux ubd0=Debian-3.0r0.ext2
tracing thread pid = 5489
Linux version 2.4.19-5um ( jdike@uml.karaya.com) (gcc version 2.96 20000731
(Red Hat Linux 7.1 2.96-81)) #2 Mon Sep 16 15:41:15 EDT 2002
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ubd0= Debian-3.0r0.ext2 root=/dev/ubd0
Calibrating delay loop... 1005.93 BogoMIPS
Memory: 30192k available
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
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
linux-3fuv:/home/sai #

Can any one please help me in this regarding....

please mail me ASAP.

rgds,
Prasad.

------=_Part_55296_11461847.1180082588686
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This is Prasad,I am trying to install UML on SuSE
linux 10.I have down loaded &quot; user_mode_linux-2.4.19.5um-0.i386.rpm&quot;
and &quot;Debian-3.0r0.ext2&quot;.<br><br>After installing rpm package, I got
&quot;linux&quot; in /usr/bin and i have copied &quot;linux&quot; in to /home/user1 and
gave following command....
<br>linux ubd0=Debian-3.0r0.ext2 but i have got the following error.<br><br><br>linux-3fuv:/home/sai # linux ubd0=Debian-3.0r0.ext2<br>tracing thread pid = 5489<br>Linux version 2.4.19-5um (<a href="mailto:jdike@uml.karaya.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

jdike@uml.karaya.com</a>) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)) #2 Mon Sep 16 15:41:15 EDT 2002<br>On node 0 totalpages: 8192<br>zone(0): 8192 pages.<br>zone(1): 0 pages.<br>zone(2): 0 pages.<br>Kernel command line: ubd0=
Debian-3.0r0.ext2 root=/dev/ubd0<br>Calibrating delay loop... 1005.93 BogoMIPS<br>Memory: 30192k available<br>Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)<br>Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
<br>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)<br>Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)<br>Page-cache hash table entries: 8192 (order: 3, 32768 bytes)<br>Checking for host processor cmov support...Yes
<br>Checking for host processor xmm support...No<br>Checking that ptrace can change system call numbers...OK<br>Checking that host ptys support output SIGIO...Yes<br>Checking that host ptys support SIGIO on close...No, enabling workaround
<br>POSIX conformance testing by UNIFIX<br>Linux NET4.0 for Linux 2.4<br>Based upon Swansea University Computer Society NET3.039<br>Initializing RT netlink socket<br>Kernel panic: outer trampoline didn&#39;t exit with SIGKILL
<br>linux-3fuv:/home/sai #<br><br>Can any one please help me in this regarding....<br><br>please mail me ASAP.<br><br>rgds,<br>Prasad.<br><br>

------=_Part_55296_11461847.1180082588686--


--===============1091771629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1091771629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1091771629==--

