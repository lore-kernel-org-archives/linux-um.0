Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I782n-00043i-L0 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Jul 2007 04:01:41 -0700
Received: from ug-out-1314.google.com ([66.249.92.173])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I782l-0000pi-6c
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Jul 2007 04:01:41 -0700
Received: by ug-out-1314.google.com with SMTP id m2so962090uge
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 07 Jul 2007 04:01:38 -0700 (PDT)
Message-ID: <3d0408630707070401i336cc879k8055d5858c97054a@mail.gmail.com>
Date: Sat, 7 Jul 2007 19:01:36 +0800
From: "Yan Zheng" <yanzheng@21cn.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] UML Build error when hostFS support is included.
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

Hi all.

I get fellow error message, when build UML with default config (make
defconfig) except hostFS support is included.  the kernel is 2.6.22-rc7.

-------------------------

WARNING: kernel/built-in.o(.text+0x141b0): Section mismatch:
reference to .init.text: (between 'kthreadd' and 'init_waitqueue_head')
  LINK linux
  Building modules, stage 2.
  MODPOST 16 modules
ERROR: "ftruncate64" [fs/hostfs/hostfs.ko] undefined!
ERROR: "__fxstat64" [fs/hostfs/hostfs.ko] undefined!
ERROR: "futimes" [fs/hostfs/hostfs.ko] undefined!
ERROR: "fchown" [fs/hostfs/hostfs.ko] undefined!
ERROR: "fchmod" [fs/hostfs/hostfs.ko] undefined!
ERROR: "utimes" [fs/hostfs/hostfs.ko] undefined!
make[2]: *** [__modpost] Error 1
make[1]: *** [modules] Error 2
make: *** [_all] Error 2

--------------------------
Regards
YZ

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
