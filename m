Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ayi9H-0005SM-Nq for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Mar 2004 17:59:43 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Ayhw3-0007Ol-66
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Mar 2004 17:46:03 -0800
Message-Id: <200403040216.i242G1Wo009026@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip 0x400e51a4 
In-Reply-To: Your message of "Tue, 30 Dec 2003 00:32:34 +0800."
	<Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com> 
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 03 Mar 2004 21:16:01 -0500
To: Jeff Chua <jchua@fedex.com>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>

jchua@fedex.com said:
> uml-patch-2.4.22-5 works fine, but newer patches fail during boot
> Starting daemons: syslogd klogd inetd namedKernel panic: Kernel mode
> fault at addr 0x48965000, ip 0x400e51a4 

Can you check if this still happens with the next patch?  I fixed a crash
caused by klogd, and the klogd in the last line there makes me suspicious
that this is the same thing.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
