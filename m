Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6853-0006Lf-4U for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 06:38:17 -0700
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C6851-0007Mv-My for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 06:38:17 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1C684z-000277-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 11 Sep 2004 15:38:13 +0200
Received: from p508a5f9c.dip.t-dialin.net ([80.138.95.156])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 11 Sep 2004 15:38:13 +0200
Received: from skoehler by p508a5f9c.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 11 Sep 2004 15:38:13 +0200
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <4142FEC3.1040904@upb.de>
References: <20040826020626.GA28471@malice.crymeariver.org>
	<200409102352.i8ANql0O004842@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <200409102352.i8ANql0O004842@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: [PATCH] nptl/sys_clone fix for i386/ppc
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
Date: Sat, 11 Sep 2004 15:33:55 +0200
To: user-mode-linux-devel@lists.sourceforge.net

>>The problem is caused by the incorrect implementation of sys_clone().
>> sys_clone() is an ugly beast that has different arguements depending
>>on  the architecture.  For i386 and ppc, the child tid is passed as
>>the  5th arguement instead of as the 4th arguement as as some other
>>architectures (like x86-64) do.  The 4th arguement on i386 and ppc
>>doesn't look to be used by the kernel. 
> 
> This is fixed in my tree.  It was a lot simpler than your patch, or what I
> led you to believe.  I just moved sys_clone from syscall_kern.c to
> arch/um/sys-i386/syscalls.c and fixed the interface.

Sorry, i guess my question is stupid, but does UML now run an a 
host-system that is NPTL enabled? I didn't try that for a few months 
now, and LD_ASSUME_KERNEL=2.4.1 won't work with my host-system (gentoo) 
since it doesn't come with a 2nd glibc-versions.




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
