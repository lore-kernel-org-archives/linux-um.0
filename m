Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ASPjs-0000ev-Rm
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Dec 2003 15:52:00 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ASPjr-0007Wh-GK
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Dec 2003 15:51:59 -0800
Message-Id: <200312060004.hB604ZAv008193@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Problem with 2.4.22-uml6 & skas... 
In-Reply-To: Your message of "Mon, 24 Nov 2003 04:02:14 +0100."
             <3FC174B6.4030908@darkman.de> 
References: <3FC174B6.4030908@darkman.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 05 Dec 2003 19:04:35 -0500
To: Sven 'Darkman' Michels <sven@darkman.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

sven@darkman.de said:
> The host: Running vanilla 2.4.22 with host-skas3.patch (applied
> without any error), PROC_MM enabled. 

>  Problem: i start the uml with: linux-2.4.22 ubd0=/home/uml1/uml/10/
> root_fs  ubd1=/home/uml1/uml/10/swap.disk mem=64M con1=pts umid=uml10
> eth0=tuntap,uml10-eth0 devfs=mount and it stops here: VFS: Mounted
> root (ext2 filesystem) readonly. Mounted devfs on /dev 

Every case of this I've seen has been caused by David's 2.4.21 (or so) skas
patch being applied to 2.4.22.  Applying my 2.4.19 skas patch has fixed
the problem.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
