Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adtb2-0007eD-O8 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 07:58:20 -0800
Received: from 62-241-36-148.kunde.vdserver.de ([62.241.36.148] ident=mail)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Adtb2-0004th-9w for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 07:58:20 -0800
Mime-Version: 1.0
Message-Id: <a06020407bc208b5b5a7a@[192.168.1.10]>
In-Reply-To: <200401060258.i062wuFI023117@ccure.user-mode-linux.org>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
	<200401060258.i062wuFI023117@ccure.user-mode-linux.org>
From: Johannes Formann <johannes@formann.de>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip
 0x400e51a4
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
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
Date: Tue, 6 Jan 2004 16:57:50 +0100
To: Jeff Dike <jdike@addtoit.com>, Jeff Chua <jchua@fedex.com>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>

At 21:58 Uhr -0500 05.01.2004, Jeff Dike wrote:
>jchua@fedex.com said:
>>  Starting daemons: syslogd klogd inetd namedKernel panic: Kernel mode
>>  fault at addr 0x48965000, ip 0x400e51a4
>
>Can you get a stack trace from the panic?

a simple strace $comand_to_run_uml?

Johannes


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
