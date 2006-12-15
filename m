Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gv73e-0007Ox-6x for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Dec 2006 23:00:38 -0800
Received: from nf-out-0910.google.com ([64.233.182.186])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gv73d-0004AF-RU
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Dec 2006 23:00:38 -0800
Received: by nf-out-0910.google.com with SMTP id c31so1542533nfb
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 14 Dec 2006 23:00:36 -0800 (PST)
Message-ID: <e3156df0612142300if4a4d8akabae7f81d0d6695e@mail.gmail.com>
Date: Fri, 15 Dec 2006 09:00:36 +0200
From: "Ilkka Tengvall" <ilkka.tengvall@iki.fi>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] broken uml_util.spec
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Howdy,

I just dowloaded uml and gave it a shot. Seems to work nice on
2.6.19-rc6. While at it, I fixed the rpm spec file. It had old tag for
license, incorrect directory name for build and was missing jail_uml
from files list. I built it on fedora-release-6-89 .

There is also a minor bug in the skas patch, it still uses
include/config.h in some proc-mm files even config.h is removed from
19-rc6 version of kernel. Just remove those includes, and it works for
me...

I'm not a subscriber to the list.

- it

the patch:
---------------------
--- tools-20060323/uml_util.spec.broken 2006-12-15 08:14:52.000000000 +0200
+++ tools-20060323/uml_util.spec        2006-12-15 08:15:09.000000000 +0200
@@ -7,7 +7,7 @@
 Name:      uml_utilities
 Version:   %{ver}
 Release:   %{rel}
-Copyright: GPL
+License:   GPL
 Packager:  Someone
 URL:       http://user-mode-linux.sourceforge.net/index.html
 Source:    http://prdownloads.sourceforge.net/user-mode-linux/uml_utilities_%{ver}.tar.bz2
@@ -21,7 +21,8 @@ COW, etc.


 %prep
-%setup -n tools
+#%setup -n tools
+%setup -n tools-%{ver}

 %build
 make CFLAGS="-g -Wall -O2" DESTDIR=$RPM_BUILD_ROOT
@@ -31,6 +32,7 @@ make install DESTDIR=$RPM_BUILD_ROOT

 %files
 %attr(755,root,root)                   %{_bindir}/jailtest
+%attr(755,root,root)                   %{_sbindir}/jail_uml
 #%attr(755,root,root)                  %{_bindir}/mkrootfs
 %attr(755,root,root)                   %{_bindir}/tunctl
 %attr(755,root,root)                   %{_bindir}/uml_mconsole
---------------------

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
