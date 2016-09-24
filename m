Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1bnvBt-0001QJ-5I
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 22:13:01 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92]
	helo=www.kot-begemot.co.uk)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bnvBs-0005eE-0Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 22:13:01 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <16b4f979-dc91-1720-13bf-7f538ca4963d@kot-begemot.co.uk>
Date: Sat, 24 Sep 2016 22:42:14 +0100
MIME-Version: 1.0
Subject: [uml-devel] Something is rotten in the state of Denmark
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
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard.weinberger@gmail.com>

Hi Richard, hi list,

I got around to devote some time to my patchsets and while working on my
ubd block read one, I observed the following behaviour with stock 4.8.0-rc7

On a freshly booted image, stock 4.8.0-rc7, Debian jessie userspace:

root@wyvern-uml:~# while true; do dd if=/dev/ubda of=/dev/null bs=1M ; done
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB) copied, 8.14403 s, 527 MB/s
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB) copied, 9.52683 s, 451 MB/s
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB) copied, 10.1613 s, 423 MB/s
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB) copied, 10.2111 s, 421 MB/s

This gets progressively worse until it reaches about 380MB/s in 5-10
more runs. The rate at which it slows down decreases overtime.

A.


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

