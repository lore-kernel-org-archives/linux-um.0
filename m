Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BWPbF-0007rC-PP for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Jun 2004 18:03:53 -0700
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BWPbC-0000XB-L7 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Jun 2004 18:03:50 -0700
Message-ID: <07e501c44a99$fc7bccc0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <BAY18-F18AMdGwGMFdX000701d9@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [uml-user] skas not found
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
Date: Sat, 5 Jun 2004 03:11:09 +0200
To: xpto adslkfjd <xpto404@hotmail.com>, user-mode-linux-user@lists.sourceforge.net
Cc: user-mode-linux-devel@lists.sourceforge.net

hi !
you probably forgot to enable support for /proc/mm (=skas) in your kernel configuration?

btw: couldn't the patch do that for us ?

regards
roland


----- Original Message ----- 
From: "xpto adslkfjd" <xpto404@hotmail.com>
To: <user-mode-linux-user@lists.sourceforge.net>
Sent: Saturday, June 05, 2004 2:23 AM
Subject: [uml-user] skas not found


> Hi,
> I applied the patch host-skas3-2.6.3-v1.patch to my host kernel
> but I am still getting messages that the skas3 patch and  /proc/mm
> are not found (see below).
> Do I have to do anything else to enable these features?
> Thank you very much,
> Paulo
> 
> [su@deathstar vlinux]$ ./linux-2.4.26
> Checking for the skas3 patch in the host...not found
> Checking for /proc/mm...not found
> Adding 4595712 bytes to physical memory to account for exec-shield gap
> tracing thread pid = 2986
> Checking for /dev/anon on the host...Not available (open failed with errno 
> 2)
> Checking for /dev/anon on the host...Not available (open failed with errno 
> 2)
> Checking for /dev/anon on the host...Not available (open failed with errno 
> 2)
> Checking for /dev/anon on the host...Not available (open failed with errno 
> 2)
> Linux version 2.4.26-1um (su@deathstar) (gcc version 3.3.3 20040412 (Red Hat 
> Linux 3.3.3-7)) #2 Sun May 23 18:38:27 CDT 2004
> On node 0 totalpages: 9314
> zone(0): 9314 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/ubd0
> Calibrating delay loop... 1959.52 BogoMIPS
> Memory: 28952k available
> Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
> Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Checking for host processor cmov support...Yes
> Checking for host processor xmm support...No
> Checking that ptrace can change system call numbers...OK
> Checking that host ptys support output SIGIO...Yes
> Checking that host ptys support SIGIO on close...No, enabling workaround
> POSIX conformance testing by UNIFIX
> Linux NET4.0 for Linux 2.4
> 
> _________________________________________________________________
> Looking to buy a house? Get informed with the Home Buying Guide from MSN 
> House & Home. http://coldwellbanker.msn.com/
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the new InstallShield X.
> From Windows to Linux, servers to mobile, InstallShield X is the one
> installation-authoring solution that does it all. Learn more and
> evaluate today! http://www.installshield.com/Dev2Dev/0504
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
> 


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
