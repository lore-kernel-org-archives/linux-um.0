Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <1220.157.182.105.1.1096501625.squirrel@www.csee.wvu.edu>
From: <atanugul@csee.wvu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [uml-devel] building from source
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
Date: Wed, 29 Sep 2004 19:47:05 -0400 (EDT)
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

Hi!
I tried building a uml kernel from source.I have a debian 2.6.6 kernel on
my system. I downloaded a 2.4.26 kernel and a matching uml patch
(uml-patch-2.4.26-1.bz2) for it.I followed the steps specified in the
user-mode-linux. Everything went well till step 5. When I did `make linux
ARCH=um' I got the following error messages:
make -C arch/um/sys-i386/util mk_sc
make[1]: Entering directory
`/build/kernel-source-2.4.26/arch/um/sys-i386/util'gcc -c mk_sc.c
gcc -o mk_sc mk_sc.o
make[1]: Leaving directory
`/build/kernel-source-2.4.26/arch/um/sys-i386/util'make -C arch/um/kernel/skas include/skas_ptregs.h
make[1]: Entering directory `/build/kernel-source-2.4.26/arch/um/kernel/skas'
make -C util
make[2]: Entering directory
`/build/kernel-source-2.4.26/arch/um/kernel/skas/util'gcc -c mk_ptregs.c
gcc -o mk_ptregs mk_ptregs.o
make[2]: Leaving directory
`/build/kernel-source-2.4.26/arch/um/kernel/skas/util'util/mk_ptregs > include/skas_ptregs.h
make[1]: Leaving directory `/build/kernel-source-2.4.26/arch/um/kernel/skas'
arch/um/sys-i386/util/mk_sc > arch/um/include/sysdep-i386/sc.h
make -C arch/um/sys-i386/util mk_thread
make[1]: Entering directory
`/build/kernel-source-2.4.26/arch/um/sys-i386/util'gcc -c mk_thread_user.c
gcc -D__KERNEL__ -I/build/kernel-source-2.4.26/include -Wall
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2 
-U__i386__ -Ui386 -fprofile-arcs -ftest-coverage -g -D__arch_um__
-DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE
-I/build/kernel-source-2.4.26/arch/um/include -Derrno=kernel_errno
-I/build/kernel-source-2.4.26/arch/um/kernel/tt/include
-I/build/kernel-source-2.4.26/arch/um/kernel/skas/include -c
mk_thread_kern.cIn file included from mk_thread_kern.c:3:
/build/kernel-source-2.4.26/include/linux/sched.h:366: error:
`CONFIG_NR_CPUS' undeclared here (not in a function)/build/kernel-source-2.4.26/include/linux/sched.h:366: error:
`CONFIG_NR_CPUS' undeclared here (not in a function)/build/kernel-source-2.4.26/include/linux/sched.h:528: error:
`CONFIG_NR_CPUS' undeclared here (not in a function)make[1]: *** [mk_thread_kern.o] Error 1
make[1]: Leaving directory
`/build/kernel-source-2.4.26/arch/um/sys-i386/util'make: *** [arch/um/sys-i386/util/mk_thread] Error 2


Can anyone tell me what i should do?

Thanks,
Ashwin.




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
