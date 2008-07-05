Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KFCmP-0003SH-W7 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Jul 2008 11:46:42 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1KFCmO-0007pv-E8
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Jul 2008 11:46:41 -0700
Message-ID: <486FC187.6010802@gmx.de>
Date: Sat, 05 Jul 2008 20:46:31 +0200
From: Ingo van Lil <inguin@gmx.de>
MIME-Version: 1.0
Subject: [uml-devel] hostfs oddities
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

Hi there,

I noticed two little misfeatures in the hostfs file system. The first 
one is most certainly a bug, the second one might be functioning as 
intended.

1. If a file is held read-only by one process it cannot by creat()'ed by 
another one:

   [root@localhost ~]# mount -t hostfs none /mnt
   [root@localhost ~]# cd /mnt/tmp
   [root@localhost tmp]# touch foo
   [root@localhost tmp]# tail -f foo &
   [1] 895
   [root@localhost tmp]# > foo
   -bash: foo: Invalid argument
   [root@localhost tmp]# kill 895
   [1]+  Terminated              tail -f foo
   [root@localhost tmp]# > foo

I tracked that problem down to the set_attr() function in hostfs_user.c: 
It tries to ftruncate() the read-only file descriptor. The file should 
be re-opened writable before changing its length.

2. As long as a file is held open changes made outside the UML kernel 
(i.e. on the host side) may not be visible:

   [root@localhost tmp]# tail -f foo &
   [1] 897
   # Host system: echo "Hello World" > /tmp/foo
   [root@localhost tmp]# cat foo
   [root@localhost tmp]# kill 897
   [1]+  Terminated              tail -f foo
   [root@localhost tmp]# cat foo
   Hello World

I guess this is some kind of caching effect, because strace shows that 
there is only a single read to the actual physical file. Maybe hostfs 
should check whether the outside file has changed and invalidate the 
cache if necessary.

Cheers,
Ingo

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
