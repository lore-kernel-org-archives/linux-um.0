Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A01oC-0003CS-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Sep 2003 09:39:08 -0700
Received: from mout2.freenet.de ([194.97.50.155])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A01oB-00043e-7q
	for User-mode-linux-devel@lists.sourceforge.net; Thu, 18 Sep 2003 09:39:07 -0700
Received: from [194.97.55.147] (helo=mx4.freenet.de)
	by mout2.freenet.de with asmtp (Exim 4.23)
	id 1A01oA-0000Vw-6L
	for User-mode-linux-devel@lists.sourceforge.net; Thu, 18 Sep 2003 18:39:06 +0200
Received: from b292a.pppool.de ([213.7.41.42] helo=home.petschge.de)
	by mx4.freenet.de with esmtp (Exim 4.23 #2)
	id 1A01o6-0003OO-LH
	for User-mode-linux-devel@lists.sourceforge.net; Thu, 18 Sep 2003 18:39:03 +0200
Received: from localhost (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id EBC683BCE5
	for <User-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Sep 2003 18:36:54 +0200 (CEST)
Received: from mars (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with SMTP id 7D2453BCE4
	for <User-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Sep 2003 18:36:53 +0200 (CEST)
From: "Patrick \"Petschge\" Kilian" <petschge@web.de>
Subject: Re: [uml-devel] Re: compile problem with uml-patch-2.4.22-4 
References: <200309150545.h8F5jJWw022233@hongkong.cs.nmsu.edu> <20030916212039.19A8B3BCE4@home.petschge.de> <200309180023.h8I0NGNu021764@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030918163653.7D2453BCE4@home.petschge.de>
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
Date: Thu, 18 Sep 2003 18:36:53 +0200
To: User-mode-linux-devel@lists.sourceforge.net

Hi,

>>> Yes, I am volunteering if nobody else wants to do it.
>> In this case I volunteer to do some spellchecking and proof reading ;-)
> Cool, patches like that are useful and easy to merge...

I didn't want to way for something to proof read, so I started on my own. 
Most descriptions are the same as in 2.6.0-test5. Please pay special 
attention to the follwoing help textes, as I have written them on my own.

CONFIG_HOST_2G_2G
CONFIG_HIGHMEM
CONFIG_PROC_MM
CONFIG_DEV_ANON
CONFIG_UML_WATCHDOG

Configure.help.patch:
-----


--- linux-2.4.22-uml/Documentation/Configure.help       Wed Sep 17 12:03:54 
2003
+++ linux-2.4.22-uml2/Documentation/Configure.help      Thu Sep 18 18:31:42 
2003
@@ -27646,6 +27646,96 @@
 CONFIG_CRYPTO_TEST
   Quick & dirty crypto test module.

+Separate Kernel Address Space support
+CONFIG_MODE_SKAS
+  This option controls whether skas (separate kernel address space)
+  support is compiled in.  If you have applied the skas patch to the
+  host, then you certainly want to say Y here (and consider saying N
+  to CONFIG_MODE_TT).  Otherwise, it is safe to say Y.  Disabling this
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
+  To allow UML to run on a host you have to say Y here. N should be
+  a save choice most of the time.
+
+Support for high memory
+CONFIG_HIGHMEM
+  Currently broken, so N is the save answer.
+
+Support for /proc/mm
+CONFIG_PROC_MM
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
+  It's save to say N here.
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

-- 
Erst wenn das letzte Closed-Source-System gehackt ist, werdet ihrmerken, 
dass man Sicherheit nicht durch Verschleierung oder durch
Gesetze erreicht.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
