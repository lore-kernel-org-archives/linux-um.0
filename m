Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J0Sd3-0003C5-Se for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2007 18:07:49 -0800
Received: from ktel.gcfn.net ([69.1.206.130])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J0Sd2-00043o-7i
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2007 18:07:49 -0800
Received: from wdyllc.com (localhost [127.0.0.1])
	by ktel.gcfn.net (8.14.0/8.13.7) with ESMTP id lB727aTF004452
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 6 Dec 2007 21:07:36 -0500
Message-ID: <60483.75.187.56.77.1196993256.squirrel@wdyllc.com>
Date: Thu, 6 Dec 2007 21:07:36 -0500 (EST)
From: "Bill Schwanitz" <bilsch@bilsch.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20071206210736_33642"
Subject: [uml-devel] PATCH - .spec file repair
Reply-To: bilsch@bilsch.org
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

------=_20071206210736_33642
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hello,

I wanted to install the uml tools as an rpm on my cent5 box and the .spec
file was not quite functional.

Attached is a diff against the 20070815 release.

Also, There may be other package dependencies which I did not include. I
have some of the packages already installed on my box, I don't know if
there were other deps which may have already been there.

I have also attached a build log. This is just the output from rpmbuild -bb.

Enjoy,


-- 
Bill Schwanitz

--

"Mindlessness and moral idiocy are not characteristically human
attributes; they
 are symptoms of herd-poisoning."
  -- Aldous Huxley, Brave New World Revisited ( pg. 44 )


------=_20071206210736_33642
Content-Type: text/x-patch; name="uml_util.spec.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="uml_util.spec.diff"

--- tools-20070815/uml_util.spec	2007-08-15 11:12:27.000000000 -0400
+++ ../uml_util.spec	2007-12-06 20:59:26.000000000 -0500
@@ -7,11 +7,12 @@
 Name:      uml_utilities
 Version:   %{ver}
 Release:   %{rel}
-Copyright: GPL
+License: GPL
 Packager:  Someone
 URL:       http://user-mode-linux.sourceforge.net/index.html
 Source:    http://prdownloads.sourceforge.net/user-mode-linux/uml_utilities_%{ver}.tar.bz2
 BuildRoot: %{_tmppath}/%{name}-%{ver}-root
+BuildRequires: fuse-devel
 Group:     System
 Summary: Utilities for user-mode linux kernel
 
@@ -21,10 +22,10 @@
 
 
 %prep
-%setup -n tools
+%setup -n tools-%{ver}
 
 %build
-make CFLAGS="-g -Wall -O2" DESTDIR=$RPM_BUILD_ROOT
+make CFLAGS="-g -Wall -O2 -D_FILE_OFFSET_BITS=64" DESTDIR=$RPM_BUILD_ROOT
 
 %install
 make install DESTDIR=$RPM_BUILD_ROOT
@@ -33,12 +34,15 @@
 %attr(755,root,root)			%{_bindir}/jailtest
 #%attr(755,root,root)			%{_bindir}/mkrootfs
 %attr(755,root,root)			%{_bindir}/tunctl
+%attr(755,root,root)			%{_bindir}/humfsify
 %attr(755,root,root)			%{_bindir}/uml_mconsole
 %attr(755,root,root)			%{_bindir}/uml_moo
+%attr(755,root,root)			%{_bindir}/uml_mount
 %attr(4755,root,root)			%{_bindir}/uml_net
 %attr(755,root,root)			%{_bindir}/uml_switch
 %attr(755,root,root)		%dir	%{_libdir}/uml
 %attr(755,root,root)			%{_bindir}/uml_mkcow
+%attr(755,root,root)			%{_sbindir}/jail_uml
 %attr(755,root,root)			%{_bindir}/uml_watchdog
 #%attr(755,root,root)			%{_libdir}/uml/functions
 %attr(755,root,root)			%{_libdir}/uml/port-helper
------=_20071206210736_33642
Content-Type: text/x-log; name="tools-20070815.rpmbuild.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="tools-20070815.rpmbuild.log"

Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.21333
+ umask 022
+ cd /usr/src/redhat/BUILD
+ LANG=C
+ export LANG
+ unset DISPLAY
+ cd /usr/src/redhat/BUILD
+ rm -rf tools-20070815
+ /usr/bin/bzip2 -dc /usr/src/redhat/SOURCES/uml_utilities_20070815.tar.bz2
+ tar -xvvf -
drwxr-xr-x jdike/jdike       0 2007-08-15 11:12:27 tools-20070815/
drwxrw-r-- jdike/jdike       0 2007-08-15 11:12:27 tools-20070815/uml_net/
-rw-rw-r-- jdike/jdike     452 2006-02-27 15:19:52 tools-20070815/uml_net/Makefile
-rw-rw-r-- jdike/jdike     832 2001-12-09 23:36:26 tools-20070815/uml_net/host.h
-rw-rw-r-- jdike/jdike    3985 2003-11-08 08:04:58 tools-20070815/uml_net/tuntap.c
-rw-rw-r-- jdike/jdike    7008 2006-02-27 15:19:52 tools-20070815/uml_net/host.c
-rw-rw-r-- jdike/jdike    3766 2006-02-27 15:19:52 tools-20070815/uml_net/slip.c
-rw-rw-r-- jdike/jdike       9 2002-01-11 00:21:31 tools-20070815/uml_net/.cvsignore
-rw-rw-r-- jdike/jdike    3075 2003-05-26 22:52:21 tools-20070815/uml_net/uml_net.c
-rw-rw-r-- jdike/jdike    1738 2002-04-28 09:38:44 tools-20070815/uml_net/output.c
-rw-rw-r-- jdike/jdike     398 2001-11-18 03:42:02 tools-20070815/uml_net/output.h
-rw-rw-r-- jdike/jdike    7078 2003-11-08 08:15:25 tools-20070815/uml_net/ethertap.c
drwxrw-r-- jdike/jdike       0 2004-01-14 05:07:14 tools-20070815/uml_net/CVS/
-rw-rw-r-- jdike/jdike      67 2001-11-18 03:28:11 tools-20070815/uml_net/CVS/Root
-rw-rw-r-- jdike/jdike      14 2001-11-18 03:28:11 tools-20070815/uml_net/CVS/Repository
-rw-rw-r-- jdike/jdike     412 2004-01-14 05:07:14 tools-20070815/uml_net/CVS/Entries
drwxrw-r-- jdike/jdike       0 2007-08-15 11:12:27 tools-20070815/uml_switch/
-rw-rw-r-- jdike/jdike     429 2006-02-27 15:20:26 tools-20070815/uml_switch/Makefile
-rw-rw-r-- jdike/jdike   12824 2006-02-27 16:02:36 tools-20070815/uml_switch/uml_switch.c
-rw-rw-r-- jdike/jdike     856 2002-04-23 20:13:30 tools-20070815/uml_switch/tuntap.c
-rw-rw-r-- jdike/jdike      12 2002-01-11 00:21:31 tools-20070815/uml_switch/.cvsignore
-rw-rw-r-- jdike/jdike     406 2006-02-27 16:03:17 tools-20070815/uml_switch/hash.h
-rw-rw-r-- jdike/jdike     183 2002-04-10 07:21:56 tools-20070815/uml_switch/tuntap.h
-rw-rw-r-- jdike/jdike     129 2002-04-07 13:57:12 tools-20070815/uml_switch/switch.h
drwxrw-r-- jdike/jdike       0 2003-09-03 16:22:03 tools-20070815/uml_switch/CVS/
-rw-rw-r-- jdike/jdike      67 2001-11-18 03:28:19 tools-20070815/uml_switch/CVS/Root
-rw-rw-r-- jdike/jdike      17 2001-11-18 03:28:19 tools-20070815/uml_switch/CVS/Repository
-rw-rw-r-- jdike/jdike     412 2003-09-03 16:22:03 tools-20070815/uml_switch/CVS/Entries
-rw-rw-r-- jdike/jdike     519 2002-04-10 09:07:02 tools-20070815/uml_switch/port.h
-rw-rw-r-- jdike/jdike    3506 2006-02-27 16:02:45 tools-20070815/uml_switch/hash.c
-rw-rw-r-- jdike/jdike    6017 2006-02-27 16:02:45 tools-20070815/uml_switch/port.c
drwxrw-r-- jdike/jdike       0 2003-11-08 08:23:53 tools-20070815/umlgdb/
-rw-rw-r-- jdike/jdike    8165 2003-11-08 08:20:29 tools-20070815/umlgdb/umlgdb
drwxrw-r-- jdike/jdike       0 2004-01-14 05:07:29 tools-20070815/umlgdb/CVS/
-rw-rw-r-- jdike/jdike      67 2002-04-15 07:54:26 tools-20070815/umlgdb/CVS/Root
-rw-rw-r-- jdike/jdike      13 2002-04-15 07:54:26 tools-20070815/umlgdb/CVS/Repository
-rw-rw-r-- jdike/jdike      90 2004-01-14 05:07:29 tools-20070815/umlgdb/CVS/Entries
drwxrw-r-- jdike/jdike       0 2002-04-15 07:54:43 tools-20070815/umlgdb/CVS/CVS/
-rw-rw-r-- jdike/jdike      67 2002-04-15 07:54:43 tools-20070815/umlgdb/CVS/CVS/Root
-rw-rw-r-- jdike/jdike      17 2002-04-15 07:54:43 tools-20070815/umlgdb/CVS/CVS/Repository
-rw-rw-r-- jdike/jdike       2 2002-04-15 07:54:43 tools-20070815/umlgdb/CVS/CVS/Entries
-rw-rw-r-- jdike/jdike     113 2002-04-14 16:37:39 tools-20070815/umlgdb/Makefile
drwxrw-r-- jdike/jdike       0 2007-08-15 11:12:27 tools-20070815/watchdog/
-rw-rw-r-- jdike/jdike    1833 2002-06-03 22:53:57 tools-20070815/watchdog/uml_watchdog.c
-rw-rw-r-- jdike/jdike     268 2006-02-27 15:55:34 tools-20070815/watchdog/Makefile
drwxrw-r-- jdike/jdike       0 2003-02-18 19:20:05 tools-20070815/watchdog/CVS/
-rw-rw-r-- jdike/jdike      67 2002-06-04 12:36:48 tools-20070815/watchdog/CVS/Root
-rw-rw-r-- jdike/jdike      15 2002-06-04 12:36:48 tools-20070815/watchdog/CVS/Repository
-rw-rw-r-- jdike/jdike      90 2003-02-18 19:20:05 tools-20070815/watchdog/CVS/Entries
drwxrw-r-- jdike/jdike       0 2007-08-15 11:12:27 tools-20070815/moo/
-rw-rw-r-- jdike/jdike     566 2006-02-27 15:08:49 tools-20070815/moo/Makefile
-rw-rw-r-- jdike/jdike       8 2002-01-11 00:21:31 tools-20070815/moo/.cvsignore
-rw-rw-r-- jdike/jdike    1377 2006-02-27 15:16:53 tools-20070815/moo/uml_mkcow.c
-rw-rw-r-- jdike/jdike   12125 2006-06-16 11:20:37 tools-20070815/moo/cow.c
-rw-rw-r-- jdike/jdike    1566 2006-02-27 15:16:22 tools-20070815/moo/cow_sys.h
-rw-rw-r-- jdike/jdike    1253 2006-02-27 15:15:59 tools-20070815/moo/cow.h
-rw-rw-r-- jdike/jdike    6092 2006-02-27 15:17:46 tools-20070815/moo/uml_moo.c
drwxrw-r-- jdike/jdike       0 2004-01-14 05:06:53 tools-20070815/moo/CVS/
-rw-rw-r-- jdike/jdike      67 2001-11-18 03:27:32 tools-20070815/moo/CVS/Root
-rw-rw-r-- jdike/jdike      10 2001-11-18 03:27:32 tools-20070815/moo/CVS/Repository
-rw-rw-r-- jdike/jdike     291 2004-01-14 05:06:53 tools-20070815/moo/CVS/Entries
-rw-rw-r-- jdike/jdike     823 2006-02-27 14:38:55 tools-20070815/Makefile
drwxrw-r-- jdike/jdike       0 2006-02-27 15:52:46 tools-20070815/honeypot/
-rw-rw-r-- jdike/jdike    1193 2006-02-27 15:52:46 tools-20070815/honeypot/honeypot.pl
-rw-rw-r-- jdike/jdike    2608 2003-01-22 15:40:26 tools-20070815/honeypot/hppfs.pm
-rw-rw-r-- jdike/jdike    1172 2006-02-27 14:47:12 tools-20070815/honeypot/hppfslib.pm
drwxrw-r-- jdike/jdike       0 2003-09-03 16:18:09 tools-20070815/honeypot/CVS/
-rw-rw-r-- jdike/jdike      67 2002-07-29 20:32:59 tools-20070815/honeypot/CVS/Root
-rw-rw-r-- jdike/jdike      15 2002-07-29 20:32:59 tools-20070815/honeypot/CVS/Repository
-rw-rw-r-- jdike/jdike     139 2003-09-03 16:18:09 tools-20070815/honeypot/CVS/Entries
drwxrw-r-- jdike/jdike       0 2002-07-29 20:33:20 tools-20070815/honeypot/CVS/CVS/
-rw-rw-r-- jdike/jdike      67 2002-07-29 20:33:20 tools-20070815/honeypot/CVS/CVS/Root
-rw-rw-r-- jdike/jdike      19 2002-07-29 20:33:20 tools-20070815/honeypot/CVS/CVS/Repository
-rw-rw-r-- jdike/jdike       2 2002-07-29 20:33:20 tools-20070815/honeypot/CVS/CVS/Entries
drwxrw-r-- jdike/jdike       0 2007-08-15 11:12:27 tools-20070815/mconsole/
-rw-rw-r-- jdike/jdike      13 2002-01-11 00:21:31 tools-20070815/mconsole/.cvsignore
-rw-rw-r-- jdike/jdike    1219 2003-02-04 15:11:39 tools-20070815/mconsole/notify.pl
-rw-rw-r-- jdike/jdike   13004 2006-02-27 23:05:32 tools-20070815/mconsole/uml_mconsole.c
drwxrw-r-- jdike/jdike       0 2003-09-03 16:19:43 tools-20070815/mconsole/CVS/
-rw-rw-r-- jdike/jdike      67 2001-11-18 03:27:30 tools-20070815/mconsole/CVS/Root
-rw-rw-r-- jdike/jdike      15 2001-11-18 03:27:30 tools-20070815/mconsole/CVS/Repository
-rw-rw-r-- jdike/jdike     176 2003-09-03 16:19:43 tools-20070815/mconsole/CVS/Entries
-rw-rw-r-- jdike/jdike     320 2006-02-27 15:03:01 tools-20070815/mconsole/Makefile
-rw-rw-r-- jdike/jdike   18007 2001-10-08 22:22:36 tools-20070815/COPYING
drwxrw-r-- jdike/jdike       0 2006-06-22 16:45:01 tools-20070815/humfsify/
-rw-rw-r-- jdike/jdike   10000 2006-05-25 15:46:19 tools-20070815/humfsify/humfsify
-rw-rw-r-- jdike/jdike     127 2006-05-25 14:37:01 tools-20070815/humfsify/Makefile
drwxrw-r-- jdike/jdike       0 2001-11-18 03:27:30 tools-20070815/gdbbot/
-rw-rw-r-- jdike/jdike    2395 2001-07-05 15:18:58 tools-20070815/gdbbot/gdbbot.pl
drwxrw-r-- jdike/jdike       0 2001-11-18 03:27:30 tools-20070815/gdbbot/CVS/
-rw-rw-r-- jdike/jdike      67 2001-11-18 03:27:29 tools-20070815/gdbbot/CVS/Root
-rw-rw-r-- jdike/jdike      13 2001-11-18 03:27:29 tools-20070815/gdbbot/CVS/Repository
-rw-rw-r-- jdike/jdike      44 2001-11-18 03:27:30 tools-20070815/gdbbot/CVS/Entries
drwxrw-r-- jdike/jdike       0 2007-08-15 11:12:27 tools-20070815/port-helper/
-rw-rw-r-- jdike/jdike    1786 2006-02-27 16:25:42 tools-20070815/port-helper/port-helper.c
drwxrw-r-- jdike/jdike       0 2003-02-18 19:20:02 tools-20070815/port-helper/CVS/
-rw-rw-r-- jdike/jdike      67 2001-12-28 12:59:46 tools-20070815/port-helper/CVS/Root
-rw-rw-r-- jdike/jdike      18 2001-12-28 12:59:46 tools-20070815/port-helper/CVS/Repository
-rw-rw-r-- jdike/jdike      97 2003-02-18 19:20:02 tools-20070815/port-helper/CVS/Entries
drwxrw-r-- jdike/jdike       0 2001-12-28 13:00:13 tools-20070815/port-helper/CVS/CVS/
-rw-rw-r-- jdike/jdike      67 2001-12-28 13:00:13 tools-20070815/port-helper/CVS/CVS/Root
-rw-rw-r-- jdike/jdike      22 2001-12-28 13:00:13 tools-20070815/port-helper/CVS/CVS/Repository
-rw-rw-r-- jdike/jdike       2 2001-12-28 13:00:13 tools-20070815/port-helper/CVS/CVS/Entries
-rw-rw-r-- jdike/jdike     307 2006-02-27 15:18:40 tools-20070815/port-helper/Makefile
drwxrw-r-- jdike/jdike       0 2007-08-15 11:12:27 tools-20070815/jailtest/
-rw-rw-r-- jdike/jdike    1498 2002-01-25 14:59:48 tools-20070815/jailtest/jailtest.c
-rw-rw-r-- jdike/jdike     266 2006-02-27 14:52:53 tools-20070815/jailtest/Makefile
drwxrw-r-- jdike/jdike       0 2003-02-18 19:20:01 tools-20070815/jailtest/CVS/
-rw-rw-r-- jdike/jdike      67 2002-01-25 16:36:49 tools-20070815/jailtest/CVS/Root
-rw-rw-r-- jdike/jdike      15 2002-01-25 16:36:49 tools-20070815/jailtest/CVS/Repository
-rw-rw-r-- jdike/jdike      94 2003-02-18 19:20:01 tools-20070815/jailtest/CVS/Entries
drwxrw-r-- jdike/jdike       0 2002-01-25 16:37:25 tools-20070815/jailtest/CVS/CVS/
-rw-rw-r-- jdike/jdike      67 2002-01-25 16:37:25 tools-20070815/jailtest/CVS/CVS/Root
-rw-rw-r-- jdike/jdike      19 2002-01-25 16:37:25 tools-20070815/jailtest/CVS/CVS/Repository
-rw-rw-r-- jdike/jdike       2 2002-01-25 16:37:25 tools-20070815/jailtest/CVS/CVS/Entries
drwxrw-r-- jdike/jdike       0 2004-01-14 05:05:30 tools-20070815/CVS/
-rw-rw-r-- jdike/jdike      67 2001-11-18 03:27:21 tools-20070815/CVS/Root
-rw-rw-r-- jdike/jdike       6 2001-11-18 03:27:21 tools-20070815/CVS/Repository
-rw-rw-r-- jdike/jdike     373 2004-01-14 05:05:30 tools-20070815/CVS/Entries
drwxr-xr-x jdike/jdike       0 2007-08-15 11:12:27 tools-20070815/jail/
-rw-rw-r-- jdike/jdike    1465 2006-02-27 14:52:31 tools-20070815/jail/jail_uml.c
-rw-rw-r-- jdike/jdike    2654 2003-11-19 05:46:28 tools-20070815/jail/tty_out.pm
-rw-rw-r-- jdike/jdike     805 2003-01-29 13:14:40 tools-20070815/jail/tty_log.pl
-rw-rw-r-- jdike/jdike    2565 2003-06-12 13:10:50 tools-20070815/jail/tty_log.pm
-rw-r--r-- jdike/jdike   10240 2006-02-27 14:27:12 tools-20070815/jail/cell.tar
-rw-rw-r-- jdike/jdike    2556 2003-11-19 05:47:41 tools-20070815/jail/playlog.pl
-rw-rw-r-- jdike/jdike     301 2006-02-27 14:51:46 tools-20070815/jail/Makefile
drwxrw-r-- jdike/jdike       0 2004-01-14 05:06:19 tools-20070815/jail/CVS/
-rw-rw-r-- jdike/jdike      67 2002-07-18 18:47:22 tools-20070815/jail/CVS/Root
-rw-rw-r-- jdike/jdike      11 2002-07-18 18:47:22 tools-20070815/jail/CVS/Repository
-rw-rw-r-- jdike/jdike     383 2004-01-14 05:06:19 tools-20070815/jail/CVS/Entries
-rw-rw-r-- jdike/jdike    7290 2004-01-21 05:35:42 tools-20070815/jail/jailer.pl
-rw-rw-r-- jdike/jdike    4163 2003-11-19 05:46:34 tools-20070815/jail/db_out.pm
drwxrwxr-x jdike/jdike       0 2007-08-15 11:04:21 tools-20070815/patches/
-rw-rw-r-- jdike/jdike      16 2007-08-15 11:04:14 tools-20070815/patches/series
-rw-rw-r-- jdike/jdike    2720 2007-08-15 11:04:21 tools-20070815/patches/tunctl-setgroup
drwxrw-r-- jdike/jdike       0 2002-11-02 14:30:27 tools-20070815/gdb/
-rw-rw-r-- jdike/jdike    1293 2002-01-14 15:47:18 tools-20070815/gdb/gdbinit
-rw-rw-r-- jdike/jdike    1235 2006-02-27 15:35:28 tools-20070815/uml_util.spec.in
drwxrw-r-- jdike/jdike       0 2007-08-15 11:12:27 tools-20070815/tunctl/
-rw-rw-r-- jdike/jdike    3345 2007-08-15 11:10:03 tools-20070815/tunctl/tunctl.c
drwxrw-r-- jdike/jdike       0 2003-02-18 19:20:02 tools-20070815/tunctl/CVS/
-rw-rw-r-- jdike/jdike      67 2002-02-12 16:07:36 tools-20070815/tunctl/CVS/Root
-rw-rw-r-- jdike/jdike      13 2002-02-12 16:07:36 tools-20070815/tunctl/CVS/Repository
-rw-rw-r-- jdike/jdike      84 2003-02-18 19:20:02 tools-20070815/tunctl/CVS/Entries
-rw-rw-r-- jdike/jdike     262 2006-02-27 15:19:52 tools-20070815/tunctl/Makefile
drwxrwxr-x jdike/jdike       0 2007-08-15 11:12:27 tools-20070815/lib/
-rw-rw-r-- jdike/jdike    1184 2006-02-16 11:07:45 tools-20070815/lib/rights.c
-rw-rw-r-- jdike/jdike     138 2006-02-15 12:04:44 tools-20070815/lib/Makefile
drwxrwxr-x jdike/jdike       0 2007-08-15 11:12:27 tools-20070815/umlfs/
-rw-rw-r-- jdike/jdike     732 2006-02-12 11:33:30 tools-20070815/umlfs/uml_mount.c
drwxrwxr-x jdike/jdike       0 2006-05-02 22:22:55 tools-20070815/umlfs/mnt/
-rw-rw-r-- jdike/jdike     378 2006-02-27 16:11:25 tools-20070815/umlfs/Makefile
-rw-rw-r-- jdike/jdike    1233 2007-08-15 11:12:27 tools-20070815/uml_util.spec
drwxrwxr-x jdike/jdike       0 2007-08-15 11:04:14 tools-20070815/.pc/
-rw-rw-r-- jdike/jdike       2 2007-08-15 11:04:02 tools-20070815/.pc/.version
drwxrwxr-x jdike/jdike       0 2007-08-15 11:04:21 tools-20070815/.pc/tunctl-setgroup/
drwxrwxr-x jdike/jdike       0 2007-08-15 11:04:19 tools-20070815/.pc/tunctl-setgroup/tunctl/
-rw-rw-r-- jdike/jdike    2474 2002-09-10 18:18:06 tools-20070815/.pc/tunctl-setgroup/tunctl/tunctl.c
-rw-rw-r-- jdike/jdike       0 2007-08-15 11:04:21 tools-20070815/.pc/tunctl-setgroup/.timestamp
-rw-rw-r-- jdike/jdike      16 2007-08-15 11:04:14 tools-20070815/.pc/applied-patches
-rw-rw-r-- jdike/jdike     968 2006-02-27 23:06:07 tools-20070815/Changelog
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ cd tools-20070815
++ /usr/bin/id -u
+ '[' 0 = 0 ']'
+ /bin/chown -Rhf root .
++ /usr/bin/id -u
+ '[' 0 = 0 ']'
+ /bin/chgrp -Rhf root .
+ /bin/chmod -Rf a+rX,u+w,g-w,o-w .
+ exit 0
Executing(%build): /bin/sh -e /var/tmp/rpm-tmp.21333
+ umask 022
+ cd /usr/src/redhat/BUILD
+ cd tools-20070815
+ LANG=C
+ export LANG
+ unset DISPLAY
+ make 'CFLAGS=-g -Wall -O2 -D_FILE_OFFSET_BITS=64' DESTDIR=/var/tmp/uml_utilities-20070815-root
set -e ; for dir in lib jail jailtest humfsify mconsole moo port-helper tunctl uml_net uml_switch watchdog umlfs; do make -C $dir all; done
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/lib'
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64   -c -o rights.o rights.c
ar r libuml.a rights.o
ar: creating libuml.a
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/lib'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/jail'
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64   -c -o jail_uml.o jail_uml.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -o jail_uml jail_uml.o
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/jail'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/jailtest'
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64   -c -o jailtest.o jailtest.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -o jailtest jailtest.o
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/jailtest'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/humfsify'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/humfsify'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/mconsole'
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64   -c -o uml_mconsole.o uml_mconsole.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -o uml_mconsole uml_mconsole.o ../lib/libuml.a -lreadline -lncurses
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/mconsole'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/moo'
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE -D_GNU_SOURCE   -c -o uml_moo.o uml_moo.c
uml_moo.c: In function 'create_backing_file':
uml_moo.c:69: warning: pointer targets in passing argument 7 of 'read_cow_header' differ in signedness
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE -D_GNU_SOURCE   -c -o cow.o cow.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE -D_GNU_SOURCE -o uml_moo uml_moo.o cow.o
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE -D_GNU_SOURCE   -c -o uml_mkcow.o uml_mkcow.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE -D_GNU_SOURCE -o uml_mkcow uml_mkcow.o cow.o
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/moo'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/port-helper'
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64   -c -o port-helper.o port-helper.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -o port-helper port-helper.o ../lib/libuml.a
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/port-helper'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/tunctl'
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64   -c -o tunctl.o tunctl.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -o tunctl tunctl.o
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/tunctl'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/uml_net'
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -DTUNTAP   -c -o ethertap.o ethertap.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -DTUNTAP   -c -o host.o host.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -DTUNTAP   -c -o output.o output.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -DTUNTAP   -c -o slip.o slip.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -DTUNTAP   -c -o uml_net.o uml_net.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -DTUNTAP   -c -o tuntap.o tuntap.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -DTUNTAP -o uml_net ethertap.o host.o output.o slip.o uml_net.o tuntap.o
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/uml_net'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/uml_switch'
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -DTUNTAP   -c -o hash.o hash.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -DTUNTAP   -c -o port.o port.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -DTUNTAP   -c -o uml_switch.o uml_switch.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -DTUNTAP   -c -o tuntap.o tuntap.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -DTUNTAP -o uml_switch hash.o port.o uml_switch.o  tuntap.o
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/uml_switch'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/watchdog'
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64   -c -o uml_watchdog.o uml_watchdog.c
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -o uml_watchdog uml_watchdog.o
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/watchdog'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/umlfs'
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64   -c -o uml_mount.o uml_mount.c
uml_mount.c: In function 'init_fuse':
uml_mount.c:14: warning: passing argument 2 of 'fuse_mount_compat22' from incompatible pointer type
cc -g -Wall -O2 -D_FILE_OFFSET_BITS=64 -o uml_mount uml_mount.o -lfuse
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/umlfs'
+ exit 0
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.45149
+ umask 022
+ cd /usr/src/redhat/BUILD
+ cd tools-20070815
+ LANG=C
+ export LANG
+ unset DISPLAY
+ make install DESTDIR=/var/tmp/uml_utilities-20070815-root
set -e ; for dir in lib jail jailtest humfsify mconsole moo port-helper tunctl uml_net uml_switch watchdog umlfs; do make -C $dir install; done
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/lib'
make[1]: Nothing to be done for `install'.
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/lib'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/jail'
install -d /var/tmp/uml_utilities-20070815-root/usr/sbin
install -s jail_uml /var/tmp/uml_utilities-20070815-root/usr/sbin
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/jail'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/jailtest'
install -d /var/tmp/uml_utilities-20070815-root/usr/bin
install -s jailtest /var/tmp/uml_utilities-20070815-root/usr/bin
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/jailtest'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/humfsify'
install -d /var/tmp/uml_utilities-20070815-root/usr/bin
install -o 0755 humfsify /var/tmp/uml_utilities-20070815-root/usr/bin
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/humfsify'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/mconsole'
install -d /var/tmp/uml_utilities-20070815-root/usr/bin
install -s uml_mconsole /var/tmp/uml_utilities-20070815-root/usr/bin
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/mconsole'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/moo'
install -d /var/tmp/uml_utilities-20070815-root/usr/bin
install -s uml_moo uml_mkcow /var/tmp/uml_utilities-20070815-root/usr/bin
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/moo'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/port-helper'
install -d /var/tmp/uml_utilities-20070815-root/usr/lib64/uml
install -s port-helper /var/tmp/uml_utilities-20070815-root/usr/lib64/uml
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/port-helper'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/tunctl'
install -d /var/tmp/uml_utilities-20070815-root/usr/bin
install -s tunctl /var/tmp/uml_utilities-20070815-root/usr/bin
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/tunctl'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/uml_net'
install -d /var/tmp/uml_utilities-20070815-root/usr/bin
install -s -m 04755 uml_net /var/tmp/uml_utilities-20070815-root/usr/bin
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/uml_net'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/uml_switch'
install -d /var/tmp/uml_utilities-20070815-root/usr/bin
install -s uml_switch /var/tmp/uml_utilities-20070815-root/usr/bin
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/uml_switch'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/watchdog'
install -d /var/tmp/uml_utilities-20070815-root/usr/bin
install -s uml_watchdog /var/tmp/uml_utilities-20070815-root/usr/bin
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/watchdog'
make[1]: Entering directory `/usr/src/redhat/BUILD/tools-20070815/umlfs'
install -d /var/tmp/uml_utilities-20070815-root/usr/bin
install -s uml_mount /var/tmp/uml_utilities-20070815-root/usr/bin
make[1]: Leaving directory `/usr/src/redhat/BUILD/tools-20070815/umlfs'
+ /usr/lib/rpm/find-debuginfo.sh /usr/src/redhat/BUILD/tools-20070815
0 blocks
find: /var/tmp/uml_utilities-20070815-root/usr/lib: No such file or directory
+ /usr/lib/rpm/redhat/brp-compress
+ /usr/lib/rpm/redhat/brp-strip-static-archive /usr/bin/strip
+ /usr/lib/rpm/redhat/brp-strip-comment-note /usr/bin/strip /usr/bin/objdump
+ /usr/lib/rpm/brp-python-bytecompile
+ /usr/lib/rpm/redhat/brp-java-repack-jars
Processing files: uml_utilities-20070815-1
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Requires: /usr/bin/perl libc.so.6()(64bit) libc.so.6(GLIBC_2.2.5)(64bit) libc.so.6(GLIBC_2.3)(64bit) libfuse.so.2()(64bit) libfuse.so.2(FUSE_2.5)(64bit) libncurses.so.5()(64bit) libreadline.so.5()(64bit) perl(strict) rtld(GNU_HASH)
Processing files: uml_utilities-debuginfo-20070815-1
Checking for unpackaged file(s): /usr/lib/rpm/check-files /var/tmp/uml_utilities-20070815-root
warning: Could not canonicalize hostname: gir.gir.home.bilsch.org
Wrote: /usr/src/redhat/RPMS/x86_64/uml_utilities-20070815-1.x86_64.rpm
Wrote: /usr/src/redhat/RPMS/x86_64/uml_utilities-debuginfo-20070815-1.x86_64.rpm
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.37022
+ umask 022
+ cd /usr/src/redhat/BUILD
+ cd tools-20070815
+ exit 0
------=_20071206210736_33642
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
------=_20071206210736_33642
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

------=_20071206210736_33642--



