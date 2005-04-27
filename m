Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQcqe-00078t-3L for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Apr 2005 20:04:24 -0700
Received: from sccrmhc11.comcast.net ([204.127.202.55])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DQcqb-0002ND-MT for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Apr 2005 20:04:24 -0700
From: Ryan Anderson <ryan@michonline.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114570958.5983.50.camel@mythical>
Mime-Version: 1.0
Subject: [uml-devel] [UML] Compile error when building with seperate source
	and object directories
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 26 Apr 2005 23:02:38 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org

I've been seeing a build error when trying to build User Mode Linux on
an x86-32 host (Athlon, fwiw).  The kernel I'm building is a 1-day old
pull from git.  This error is not new, though.  I thought it was merely
an artifact of a patch stuck in a queue at first so I didn't mention it
right away.

ryan@mythryan2 ~/dev/linux/linux-git$ make O=/home/ryan/dev/linux/output/uml ARCH="um" -j4 CC="ccache distcc" clean
/bin/bash: line 1: cd: arch/um: No such file or directory
ryan@mythryan2 ~/dev/linux/linux-git$ make O=/home/ryan/dev/linux/output/uml ARCH="um" -j4 CC="ccache distcc" oldconfig
/bin/bash: line 1: cd: arch/um: No such file or directory
  HOSTCC  scripts/basic/fixdep
  GEN    /home/ryan/dev/linux/output/uml/Makefile
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/mconf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -o arch/um/Kconfig
arch/um/Kconfig:71: can't open file "arch/um/Kconfig_arch"
make[2]: *** [oldconfig] Error 1
make[1]: *** [oldconfig] Error 2
make: *** [oldconfig] Error 2


ryan@mythryan2 ~/dev/linux/linux-git$ ls -al /home/ryan/dev/linux/output/uml/
total 60
drwxr-xr-x  5 ryan ryan  4096 Apr 13 11:15 .
drwxr-xr-x  4 ryan ryan  4096 Apr 23 02:38 ..
-rw-r--r--  1 ryan ryan 15445 Apr 13 11:15 .config
-rw-r--r--  1 ryan ryan  1812 Apr 13 11:15 .config.cmd
-rw-r--r--  1 ryan ryan 15855 Mar 29 03:20 .config.old
-rw-r--r--  1 ryan ryan   351 Apr 26 22:56 Makefile
drwxr-xr-x  4 ryan ryan  4096 Apr 13 11:15 include
drwxr-xr-x  2 ryan ryan  4096 Apr 13 11:15 include2
drwxr-xr-x  4 ryan ryan  4096 Mar 29 03:21 scripts

I'm not quite sure what's going on here - but something seems broken.

My gut feeling is that arch/um/Kconfig_arch is supposed to be a symlink
(or something else magical) pointing at arch/um/Kconfig_i386, but this
doesn't seem to be working.

I can provide my .config if it matters - but since the above failure
happens almost instantly, I don't think it will matter much.

Thanks!

-- 
Ryan Anderson <ryan@michonline.com>


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
