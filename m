Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1YVLKC-0001cp-Eu
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 14:40:00 +0000
Received: from mout.gmx.net ([212.227.17.22])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YVLK6-0000aC-Sf
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 14:40:00 +0000
Received: from [192.168.178.24] ([78.54.148.148]) by mail.gmx.com (mrgmx103)
	with ESMTPSA (Nemesis) id 0Lg1QN-1Xg7O32Hxz-00paMC for
	<user-mode-linux-devel@lists.sourceforge.net>; Tue, 10 Mar 2015 15:39:48
	+0100
Message-ID: <54FF0233.602@gmx.de>
Date: Tue, 10 Mar 2015 15:39:47 +0100
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
Subject: [uml-devel] compile error after : make ARCH=um allmodconfig && make
	ARCH=um linux
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Hi,

is this already known ? :

  CC      arch/um/drivers/vde_kern.o
  CC      arch/um/drivers/vde_user.o
arch/um/drivers/vde_user.c:8:24: fatal error: libvdeplug.h: No such file or directory
 #include <libvdeplug.h>
                        ^
compilation terminated.
scripts/Makefile.build:258: recipe for target 'arch/um/drivers/vde_user.o' failed
make[1]: *** [arch/um/drivers/vde_user.o] Error 1
Makefile:947: recipe for target 'arch/um/drivers' failed
make: *** [arch/um/drivers] Error 2


-- 
Toralf
pgp key: 7B1A 07F4 EC82 0F90 D4C2  8936 872A E508 0076 E94E


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

