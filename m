Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AeJCN-0006nG-AN for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jan 2004 11:18:35 -0800
Received: from brown.brainfood.com ([146.82.138.61]
	helo=gradall.private.brainfood.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AeJCM-0000l9-SD for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jan 2004 11:18:34 -0800
From: Adam Heath <adam@doogie.org>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip 0x400e51a4
In-Reply-To: <Pine.LNX.4.58.0401080107100.28164@boston.corp.fedex.com>
Message-ID: <Pine.LNX.4.44.0401071254540.1058-100000@gradall.private.brainfood.com>
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
Date: Wed, 7 Jan 2004 13:18:09 -0600 (CST)
To: Jeff Chua <jeff98@silk.corp.fedex.com>
Cc: stian@nixia.no, Jeff Dike <jdike@addtoit.com>, UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>, Johannes Formann <johannes@formann.de>

On Thu, 8 Jan 2004, Jeff Chua wrote:

> open("/dev/kmem", O_RDONLY)             = 3
> _llseek(0x3, 0, 0xa8965000, 0xbffff934, 0) = 0
> read(3, Kernel panic: Kernel mode fault at addr 0x48965000, ip 0x400df1a4

0xa8965000 != 0x48965000

Note how only the first octet is different.



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
