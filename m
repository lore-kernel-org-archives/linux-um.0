Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNSsV-0005cR-IZ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Oct 2004 02:16:59 -0700
Received: from web26109.mail.ukl.yahoo.com ([217.12.10.233])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CNSsU-0007K1-HW for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Oct 2004 02:16:59 -0700
Message-ID: <20041029091648.11274.qmail@web26109.mail.ukl.yahoo.com>
From: Roland Kaeser <roli8200@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] Starting UML Kernel -- nothing happens
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
Date: Fri, 29 Oct 2004 11:16:48 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net

Hallo

I'm a newby to UML. I wan't run several jailed server instances on the same physical
machine. I'm using the Host Kernel 2.6.7 with the SKS patch, and also a 2.6.7 UML
Kernel. When i try to start the uml kernel the following happens (nothing):

[root@xxx]# install/uml/kernel/linux initrd=/install/uml/files/initrd.img  lang=
devfs=nomount ramdisk_size=10240 mem=128M eth0=tuntap,,,195.49.21.28
ubd0=/install/uml/instances/fc2install fakehd con=xterm ubd=0
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found

[1]+  Stopped                 /install/uml/kernel/linux
initrd=/install/uml/files/initrd.img lang= devfs=nomount ramdisk_size=10240 mem=128M
eth0=tuntap,,,195.49.21.28 ubd0=/install/uml/instances/fc2install fakehd con=xterm
ubd=0

And nothing more happens. No Xterm, no error message at all. Please help

Roland Kaeser
Systems Administrator




	

	
		
___________________________________________________________
Gesendet von Yahoo! Mail - Jetzt mit 100MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
