Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdwAw-0000fa-AA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 10:43:34 -0800
Received: from mx15.sac.fedex.com ([199.81.197.54])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AdwAv-0006n5-Qz
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 10:43:33 -0800
Received: from inet03.prod.fedex.com (inet03.prod.fedex.com [199.81.10.43])
	by mx15.sac.fedex.com (8.12.6p2/8.12.3) with ESMTP id i06IhLdO029050
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 6 Jan 2004 12:43:22 -0600 (CST)
	(envelope-from jeff98@silk.corp.fedex.com)
From: Jeff Chua <jeff98@silk.corp.fedex.com>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip 0x400e51a4
	(fwd)
Message-ID: <Pine.LNX.4.58.0401070219030.1840@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 7 Jan 2004 02:23:12 +0800 (SGT)
To: Jeff Dike <jdike@addtoit.com>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>, Johannes Formann <johannes@formann.de>


running with "strace -f klogd" ...

munmap(0x4013b000, 4096)                = 0
get_kernel_syms(0)                      = 956
brk(0x80a9000)                          = 0x80a9000
get_kernel_syms(0x8092118)              = 956
open("/dev/kmem", O_RDONLY)             = 3
_llseek(0x3, 0, 0xa8965000, 0xbffff934, 0) = 0
read(3, Kernel panic: Kernel mode fault at addr 0x48965000, ip 0x400df1a4


It seems to break while reading /dev/kmem

Thanks,
Jeff.


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
