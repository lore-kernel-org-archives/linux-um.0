Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adh82-0007gU-SQ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 18:39:34 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Adh82-00012Q-3I
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 18:39:34 -0800
Message-Id: <200401060258.i062wuFI023117@ccure.user-mode-linux.org>
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
Date: Mon, 05 Jan 2004 21:58:56 -0500
To: Jeff Chua <jchua@fedex.com>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>

jchua@fedex.com said:
> Starting daemons: syslogd klogd inetd namedKernel panic: Kernel mode
> fault at addr 0x48965000, ip 0x400e51a4 

Can you get a stack trace from the panic?

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
