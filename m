Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AduXq-0003PP-TZ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 08:59:06 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AduXq-0001yy-CT
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 08:59:06 -0800
Message-Id: <200401061718.i06HILtd002620@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip 0x400e51a4 
In-Reply-To: Your message of "Tue, 06 Jan 2004 16:57:50 +0100."
	<a06020407bc208b5b5a7a@[192.168.1.10]> 
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
	<200401060258.i062wuFI023117@ccure.user-mode-linux.org>
	<a06020407bc208b5b5a7a@[192.168.1.10]> 
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
Date: Tue, 06 Jan 2004 12:18:21 -0500
To: Johannes Formann <johannes@formann.de>
Cc: Jeff Chua <jchua@fedex.com>, UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>

johannes@formann.de said:
> a simple strace $comand_to_run_uml? 

No, gdb it, put a breakpoint on panic, get a stack trace when it hits the
breakpoint.

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
