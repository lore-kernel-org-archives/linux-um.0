Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFfAA-0001fK-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 31 Oct 2003 11:42:26 -0800
Received: from mpls-qmqp-01.inet.qwest.net ([63.231.195.112])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AFfAA-00027F-2y
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 31 Oct 2003 11:42:26 -0800
Message-ID: <3FA2BB1D.7060402@deming-os.org>
From: "Russ Lewis" <spamhole-gnu@deming-os.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Possible to run RH Install?
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
Date: Fri, 31 Oct 2003 12:42:21 -0700
To: user-mode-linux-devel@lists.sourceforge.net

Summary:
I played around with trying to run RedHat's net install process under
uml.  I get a little way into the initial download and then it fails,
but I can't figure out why.  I'm looking to see if anybody else has done
this and might know what I'm up against.

Machine:
Uml: 2.4.19-5um
Host: RedHat 8.0, kernel 2.4.18-14
Install attempt: RedHat 9 FTP install

What I did:
* Downloaded bootdisk.img
* mount -o loop -o ro bootdisk.img bootdisk/
* Created rh_install backing file, 1GB (sparse file)
* I set up masquerading rules for the UML device's IP address (192.168.0.1)
* linux con=xterm eth0=tuntap,,,192.168.0.254 initrd=bootdisk/initrd.img 
ubd0=rh_install

I get all the way through the part where you specify the FTP site to
download from.  It downloads RedHat/base/updates.img; this appears to be
successful and only take a few seconds.  Then it tries to download
RedHat/base/netstg2.img, works for a few minutes (ifconfig shows that I
have network traffic on the interface, and my DSL modem shows steady
activity), and then finally fails with the message:
	Unable to retrieve the install image.

I have done some tests, and it appears that when there is some sort of 
FTP failure, it gives a different error message.  So I believe that the 
FTP transfer is completing successfully, but something immediately after 
that is breaking.

Question:
Has anybody ever attempted this with any success?  Is there something 
fundamentally broken about what I'm attempting, or how I am attempting it?

I also tried this with the 8.0 FTP install process, with the same results.

Russ Lewis
Tucson, Arizona



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
