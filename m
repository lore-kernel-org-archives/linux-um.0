Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHofh-00035K-LC	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Sep 2005 13:24:57 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EHoff-0007kY-QH
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Sep 2005 13:24:57 -0700
Received: from localhost.localdomain (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j8KLrlYt007964
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 20 Sep 2005 17:53:47 -0400
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509201524.41199.rob@landley.net>
Subject: [uml-devel] Help?  (Filesystem race condition in 2.6.13.2 in -skas0
	and -tt mode.)
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
Date: Tue, 20 Sep 2005 15:24:40 -0500
To: user-mode-linux-devel@lists.sourceforge.net

I have a system build that happens under UML.  The build is a series of bash 
scripts that compile and run a heavily modified Linux From Scratch system.  
The previous version was working fine under 2.6.11 UML in -tt mode (with one 
patch applied, the one to fix the permissions on block devices in hostfs).

I just upgraded the build to use the 2.6.13.2, and now I'm getting the build 
breaking with random file not found errors.  I've tried both -tt mode and 
-skas0 mode, and it doesn't like either one.

It seems to be a filesystem problem.  The filesystem it's using is an ext2 
partition that lives on a loopback mounted file living in hostfs.  Somewhere 
along the way, random "file not found" errors are sneaking in, on files the 
build created seconds earlier.

Here's the end of the last three build attempts.  This is from re-running the 
build with no changes, it dies in different places, but with the same _kind_ 
of error each time.  The build process re-creates the loopback partition from 
scratch each time (deletes the working directory with all the tempfiles in 
it, then dd if=/dev/zero followed by mke2fs.  This is hostfs mounted and then 
loopback mounted.)

What info do you need to be able to reproduce this problem?  (I'll happily 
send you a tarball of my whole build, but it's 100 megs.  The vast majority 
of that being the source tarballs for linux tarball, gcc, and binutils....)

---------------------------------------

make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/tools/sources/diffutils-2.8.1/ms'
make[1]: Leaving directory `/tools/sources/diffutils-2.8.1/ms'
Making install in src
make[1]: Entering directory `/tools/sources/diffutils-2.8.1/src'
make[2]: Entering directory `/tools/sources/diffutils-2.8.1/src'
/bin/sh ../config/mkinstalldirs /tools/bin
  /tools/bin/install -c cmp /tools/bin/cmp
  /tools/bin/install -c diff /tools/bin/diff
  /tools/bin/install -c diff3 /tools/bin/diff3
  /tools/bin/install -c sdiff /tools/bin/sdiff
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/tools/sources/diffutils-2.8.1/src'
make[1]: Leaving directory `/tools/sources/diffutils-2.8.1/src'
Making install in man
make[1]: Entering directory `/tools/sources/diffutils-2.8.1/man'
make[2]: Entering directory `/tools/sources/diffutils-2.8.1/man'
make[2]: Nothing to be done for `install-exec-am'.
/bin/sh ../config/mkinstalldirs /tools/man/man1
 /tools/bin/install -c -m 644 ./cmp.1 /tools/man/man1/cmp.1
 /tools/bin/install -c -m 644 ./diff.1 /tools/man/man1/diff.1
 /tools/bin/install -c -m 644 ./diff3.1 /tools/man/man1/diff3.1
 /tools/bin/install -c -m 644 ./sdiff.1 /tools/man/man1/sdiff.1
install: unable to open `/tools/man/man1/sdiff.1/sdiff.1': No such file or 
directory
install: cannot change permissions of /tools/man/man1/sdiff.1/sdiff.1: No such 
file or directory
install: cannot change ownership of /tools/man/man1/sdiff.1/sdiff.1: No such 
file or directory
make[2]: *** [install-man1] Error 1
make[2]: Leaving directory `/tools/sources/diffutils-2.8.1/man'
make[1]: *** [install-am] Error 2
make[1]: Leaving directory `/tools/sources/diffutils-2.8.1/man'
make: *** [install-recursive] Error 1
System halted.

=== Toolchain build script exiting.

bin/ln -f /usr/man/man3/uuid_generate.3 /usr/man/man3/uuid_generate_random.3
/bin/ln -f /usr/man/man3/uuid_generate.3 /usr/man/man3/uuid_generate_time.3
make[1]: Leaving directory `/var/tmp/e2fsprogs-build/lib/uuid'
making install in lib/blkid
make[1]: Entering directory `/var/tmp/e2fsprogs-build/lib/blkid'
../../../e2fsprogs-1.34/mkinstalldirs /lib \
        /usr/lib
/bin/install -c libblkid.so.1.0 /lib/libblkid.so.1.0
strip --strip-debug \
        /lib/libblkid.so.1.0
ln -s -f libblkid.so.1.0 /lib/libblkid.so.1
ln -s -f /lib/libblkid.so.1 \
        /usr/lib/libblkid.so
/sbin/ldconfig
../../../e2fsprogs-1.34/mkinstalldirs /usr/lib \
        /usr/include/blkid
mkdir /usr/include/blkid
/bin/install -c -m 644 libblkid.a /usr/lib/libblkid.a
/bin/chmod 644 /usr/lib/libblkid.a
ranlib /usr/lib/libblkid.a
/bin/chmod 444 /usr/lib/libblkid.a
set -e; for i in blkid.h; do \
  /bin/install -c -m 
644 ../../../e2fsprogs-1.34/lib/blkid/$i /usr/include/blkid/$i; \
done
install: unable to open `/usr/include/blkid/blkid.h/blkid.h': No such file or 
directory
install: cannot change permissions of /usr/include/blkid/blkid.h/blkid.h: No 
such file or directory
install: cannot change ownership of /usr/include/blkid/blkid.h/blkid.h: No 
such file or directory
make[1]: *** [install] Error 1
make[1]: Leaving directory `/var/tmp/e2fsprogs-build/lib/blkid'
make: *** [install-libs-recursive] Error 1
Kernel panic - not syncing: Attempted to kill init!

=== Toolchain build script exiting.

make[2]: Leaving directory `/tools/sources/diffutils-2.8.1/lib'
make[1]: Leaving directory `/tools/sources/diffutils-2.8.1/lib'
Making install in m4
make[1]: Entering directory `/tools/sources/diffutils-2.8.1/m4'
make[2]: Entering directory `/tools/sources/diffutils-2.8.1/m4'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/tools/sources/diffutils-2.8.1/m4'
make[1]: Leaving directory `/tools/sources/diffutils-2.8.1/m4'
Making install in ms
make[1]: Entering directory `/tools/sources/diffutils-2.8.1/ms'
make[2]: Entering directory `/tools/sources/diffutils-2.8.1/ms'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/tools/sources/diffutils-2.8.1/ms'
make[1]: Leaving directory `/tools/sources/diffutils-2.8.1/ms'
Making install in src
make[1]: Entering directory `/tools/sources/diffutils-2.8.1/src'
make[2]: Entering directory `/tools/sources/diffutils-2.8.1/src'
/bin/sh ../config/mkinstalldirs /tools/bin
  /tools/bin/install -c cmp /tools/bin/cmp
  /tools/bin/install -c diff /tools/bin/diff
  /tools/bin/install -c diff3 /tools/bin/diff3
  /tools/bin/install -c sdiff /tools/bin/sdiff
install: unable to open `/tools/bin/sdiff/sdiff': No such file or directory
install: cannot change permissions of /tools/bin/sdiff/sdiff: No such file or 
directory
install: cannot change ownership of /tools/bin/sdiff/sdiff: No such file or 
directory
make[2]: *** [install-binPROGRAMS] Error 1
make[2]: Leaving directory `/tools/sources/diffutils-2.8.1/src'
make[1]: *** [install-am] Error 2
make[1]: Leaving directory `/tools/sources/diffutils-2.8.1/src'
make: *** [install-recursive] Error 1
System halted.

=== Toolchain build script exiting.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
