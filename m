Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1XFQHn-0003Gu-3Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Aug 2014 16:11:27 +0000
Received: from mout.gmx.net ([212.227.15.18])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XFQHl-0002x8-Io
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Aug 2014 16:11:26 +0000
Received: from [192.168.178.21] ([85.177.116.5]) by mail.gmx.com (mrgmx003)
	with ESMTPSA (Nemesis) id 0MKHtm-1XFyFN0axi-001f19 for
	<user-mode-linux-devel@lists.sourceforge.net>; Thu, 07 Aug 2014 18:11:19
	+0200
Message-ID: <53E3A525.4000704@gmx.de>
Date: Thu, 07 Aug 2014 18:11:17 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
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
Subject: [uml-devel] why is the stderr of a command delayed after the stdout
 of the previously ran command ?
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Well, probably not UML related, but I experiences this the very first time:
The following output happened in my console (hostname is n22, kernel is at 3.16) when I run a command via ssh at the 32 bit UML guest (hostname is trinity, kernel version is 3.16):


tfoerste@n22 ~ $ ssh tfoerste@trinity "ls ~/t3/core*; ps fx -eo pid,start_time,command | grep -e trinity -e sleep | grep -v grep"
 1283 17:46  |       \_ bash -c logger "1#-1, M="; cd ~; sudo su -c 'if [[ -d ./t3 ]]; then sudo chmod -R a+rwx ./t3; sudo rm -rf ./t3; fi'; mkdir ./t3; cd ./t3; MALLOC_CHECK_=2  trinity -C 4 -N 100000 -x mremap -q
 1290 17:46  |           \_ trinity -C 4 -N 100000 -x mremap -q
 1291 17:46  |               \_ trinity -C 4 -N 100000 -x mremap -q
 1292 17:46  |               \_ trinity -C 4 -N 100000 -x mremap -q
 1293 17:46  |                   \_ trinity -C 4 -N 100000 -x mremap -q
 1294 17:46  |                   \_ trinity -C 4 -N 100000 -x mremap -q
 1323 17:46  |                   \_ trinity -C 4 -N 100000 -x mremap -q
 1324 17:46  |                   \_ trinity -C 4 -N 100000 -x mremap -q
ls: cannot access /home/tfoerste/t3/core*: No such file or directory


I would expect, that the error message from ls comes before the ps output, or ?


-- 
Toralf


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

