Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gx5wI-00047U-CQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Dec 2006 10:13:14 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gx5wH-00084w-Rc
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Dec 2006 10:13:14 -0800
Date: Wed, 20 Dec 2006 13:08:30 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061220180830.GE5488@ccure.user-mode-linux.org>
References: <458142B3.7050807@freemail.gr>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <458142B3.7050807@freemail.gr>
Subject: Re: [uml-devel] porting uml to Hurd
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Constantine Kousoulos <wuwei@freemail.gr>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Dec 14, 2006 at 02:25:23PM +0200, Constantine Kousoulos wrote:
> Can you supply me with more info (docs, urls, directions to source 
> code, etc) on what needs to be done in order to accomplish the 
> port? Technical details would really help me discover if uml can 
> actually be ported to the Hurd.

There's no documentation to speak of wrt to an OS port.  There is some
outdated architecture porting information at
http://user-mode-linux.sourceforge.net/arch-port.html, some of which
is relevant.

Here's a little list off the top of my head, for a skas-like mode  -
	interception and nullification of another process system calls
	ability to change memory mappings of another process
	interception and nullification of signals received by another
process

If you can handle those, you are probably in good shape.

If you can't do the second two, then a tt-like mode might be possible,
where you map the UML kernel into every UML process address space.
Then those become trivial since "the other process" is a UML process.
However, in this case, there are other nasty tricks needed, like
making sure that the host processes have different address spaces, but
the UML portions are shared.  The kernel data obviously needs to be
shared across all processes.

Look at the interface declared in arch/um/include/os.h and defined in
arch/um/os-Linux/.  It's probably unnecessarily wide at this point,
and contains Linux-isms which shouldn't be there, but that's my
current stab at an OS abstraction interface.

				Jeff
-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
