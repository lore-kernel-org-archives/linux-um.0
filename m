Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AeHVf-0008Kx-W9 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jan 2004 09:30:23 -0800
Received: from mx11.sac.fedex.com ([199.81.193.118])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AeHVf-0006E8-IR
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jan 2004 09:30:23 -0800
Received: from inet04.prod.fedex.com (inet04.prod.fedex.com [199.81.10.44])
	by mx11.sac.fedex.com (8.12.6p2/8.12.3) with ESMTP id i07HUHiE064609
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 7 Jan 2004 11:30:17 -0600 (CST)
	(envelope-from jeff98@silk.corp.fedex.com)
From: Jeff Chua <jeff98@silk.corp.fedex.com>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip 0x400e51a4
In-Reply-To: <33237.193.212.97.12.1073405740.squirrel@pluto.nixia.no>
Message-ID: <Pine.LNX.4.58.0401080107100.28164@boston.corp.fedex.com>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com><200401060258.i
	062wuFI023117@ccure.user-mode-linux.org><a06020407bc208b5b5a7a@[192.16
	8.1.10]> <Pine.LNX.4.58.0401070150290.1840@boston.corp.fedex.com>
	<33237.193.212.97.12.1073405740.squirrel@pluto.nixia.no>
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
Date: Thu, 8 Jan 2004 01:08:11 +0800 (SGT)
To: stian@nixia.no
Cc: Jeff Dike <jdike@addtoit.com>, UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>, Johannes Formann <johannes@formann.de>



On Tue, 6 Jan 2004 stian@nixia.no wrote:

> strace -f klogd
>
> so we can see what happens in the child after the fork could be usefull,
> since the parent after the fork just exists.


I posted this earlier ...

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
Jeff



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
