Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H7KGu-0002Hz-KU for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Jan 2007 15:32:48 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H7KGu-0000Yl-5K
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Jan 2007 15:32:48 -0800
Date: Wed, 17 Jan 2007 18:26:44 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070117232644.GC15745@ccure.user-mode-linux.org>
References: <200701171715.35504.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200701171715.35504.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML/64bit is miscompiled by gcc 4.0.3 on Ubuntu
	6.06 LTS
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Jan 17, 2007 at 05:15:35PM +0100, Blaisorblade wrote:
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> 
> it hangs giving the following result at strace -p (I've printed two 
> consecutive iterations of the same messages to show that they are the same):

I'm chasing something on i386 with the same symptoms, but I think it's
a different problem.  What I'm seeing is init segfaulting on some
hosts, but not others.

Figure out what the segfault is, and where it's happening.

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
