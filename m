Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A4426-0002cj-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Mon, 29 Sep 2003 12:50:10 -0700
Received: from mout0.freenet.de ([194.97.50.131])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A4424-0002uu-QC
	for User-mode-linux-devel@lists.sourceforge.net; Mon, 29 Sep 2003 12:50:09 -0700
Received: from [194.97.50.135] (helo=mx2.freenet.de)
	by mout0.freenet.de with asmtp (Exim 4.24)
	id 1A441y-0002p3-7e
	for User-mode-linux-devel@lists.sourceforge.net; Mon, 29 Sep 2003 21:50:02 +0200
Received: from b29e9.pppool.de ([213.7.41.233] helo=home.petschge.de)
	by mx2.freenet.de with esmtp (Exim 4.24 #1)
	id 1A441v-0002sM-O0
	for User-mode-linux-devel@lists.sourceforge.net; Mon, 29 Sep 2003 21:50:00 +0200
Received: from localhost (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id 62C7B3BCE5
	for <User-mode-linux-devel@lists.sourceforge.net>; Mon, 29 Sep 2003 21:08:05 +0200 (CEST)
Received: from mars (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id 2C6043BCE4
	for <User-mode-linux-devel@lists.sourceforge.net>; Mon, 29 Sep 2003 21:08:04 +0200 (CEST)
Content-Type: text/plain; charset="iso-8859-15"
From: Patrick Kilian <petschge@gmx.de>
Reply-To: petschge@web.de
MIME-Version: 1.0
Message-Id: <200309292108.03752.petschge@gmx.de>
Subject: [uml-devel] compile help texts for 2.4.*
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 29 Sep 2003 21:08:03 +0200
Content-Transfer-Encoding: quoted-printable
To: User-mode-linux-devel@lists.sourceforge.net

Hi Jeff,

this should be the final version of the patch that adds the help texts from
2.6.0-test5 to the 2.4.* kernel branch. Please include this patch in the ne=
xt
um patches if nobody objects.

This patch is again 2.4.22 but should work with any 2.4.* kernel.

-----

--- linux-2.4.22-uml/Documentation/Configure.help       Wed Sep 17 12:03:54=
 2003
+++ linux-2.4.22-uml2/Documentation/Configure.help      Mon Sep 29 21:00:38=
 2003
@@ -27646,6 +27646,98 @@
 CONFIG_CRYPTO_TEST
   Quick & dirty crypto test module.

+Separate Kernel Address Space support
+CONFIG_MODE_SKAS
+  This option controls whether skas (separate kernel address space)
+  support is compiled in.  If you have applied the skas patch to the
+  host and enabled support for /proc/mm in the host kernel, then you
+  certainly want to say Y here (and consider saying N to
+  CONFIG_MODE_TT).  Otherwise, it is safe to say Y.  Disabling this
+  option will shrink the UML binary slightly.
+
+Tracing thread support
+CONFIG_MODE_TT
+  This option controls whether tracing thread support is compiled
+  into UML.  Normally, this should be set to Y.  If you intend to
+  use only skas mode (and the host has the skas patch applied to it),
+  then it is OK to say N here.
+
+Force a static link
+CONFIG_STATIC_LINK
+  If CONFIG_MODE_TT is disabled, then this option gives you the ability
+  to force a static link of UML.  Normally, if only skas mode is built
+  in to UML, it will be linked as a shared binary.  This is inconvenient
+  for use in a chroot jail.  So, if you intend to run UML inside a
+  chroot, and you disable CONFIG_MODE_TT, you probably want to say Y
+  here.
+
+HoneyPot ProcFS
+CONFIG_HPPFS
+  hppfs (HoneyPot ProcFS) is a filesystem which allows UML /proc
+  entries to be overridden, removed, or fabricated from the host.
+  Its purpose is to allow a UML to appear to be a physical machine
+  by removing or changing anything in /proc which gives away the
+  identity of a UML.
+
+  See <http://user-mode-linux.sf.net/hppfs.html> for more information.
+
+  You only need this if you are setting up a UML honeypot.  Otherwise,
+  it is safe to say 'N' here.
+
+2G/2G host address space split
+CONFIG_HOST_2G_2G
+  Most Linux machines are configured so that the kernel occupies the
+  upper 1G of the 4G address space and processes use the lower 3G.
+  However, some machine are configured with a 2G/2G split, with the
+  kernel occupying the upper 2G and processes using the lower 2G.
+
+  To allow UML to run on a such host you have to say Y here. N should be
+  a safe choice most of the time.
+
+Support for /proc/mm
+CONFIG_PROC_MM
+  Enables support for address space separation through /proc/mm.
+  A host kernel needs to have this enabled in order for UML to
+  run in skas mode.  UML kernels do not need to have this option
+  unless they will host sub-UMLs.
+
+  If you don't know what this does just say Y.
+
+Kernel stack size order
+CONFIG_KERNEL_STACK_ORDER
+  This option determines the size of UML kernel stacks.  They will
+  be 1 << order pages.  The default is OK unless you're running Valgrind
+  on UML, in which case, set this to 3.
+
+Anonymous Memory support
+CONFIG_DEV_ANON
+  Don't ask. Just say Y.
+
+Support for software watchdog inside UML
+CONFIG_UML_WATCHDOG
+  Support for a virtual hardware watchdog. It's safe to say N here.
+
+COW block device
+CONFIG_COW
+  This is a layered driver which sits above two other block devices.
+  One is read-only, and the other is a read-write layer which stores
+  all changes.  This provides the illusion that the read-only layer
+  can be mounted read-write and changed.
+
+pcap transport
+CONFIG_UML_NET_PCAP
+ The pcap transport makes a pcap packet stream on the host look
+  like an ethernet device inside UML.  This is useful for making
+  UML act as a network monitor for the host.  You must have libcap
+  installed in order to build the pcap transport into UML.
+
+  For more information, see
+  <http://user-mode-linux.sourceforge.net/networking.html>  That site
+  has examples of the UML command line to use to enable this option.
+
+  If you intend to use UML as a network monitor for the host, say
+  Y here.  Otherwise, say N.
+
 #
 # A couple of things I keep forgetting:
 #   capitalize: AppleTalk, Ethernet, DOS, DMA, FAT, FTP, Internet,

-----

mfg,
Patrick "Petschge" Kilian

--=20
Ein Passender Vergleich wuerde einen Braunkohletagebaufoerderbagger
mit einbeziehen. Dieser ist zu Strassen so kompatibel wie Notes zu
SMTP.		-- J=FCrgen P. Meier in d.a.s.r



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
