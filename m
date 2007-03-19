Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HTLvV-0006UU-FS for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Mar 2007 10:45:45 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HTLvU-0002NQ-KE
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Mar 2007 10:45:45 -0700
Date: Mon, 19 Mar 2007 13:43:47 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070319174347.GC11790@c2.user-mode-linux.org>
References: <0A01463223B8164194908CAC85B66A1201AD3E5C@ZMY16EXM67.ds.mot.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0A01463223B8164194908CAC85B66A1201AD3E5C@ZMY16EXM67.ds.mot.com>
Subject: Re: [uml-devel] Regarding Virtual Memory Emulation in UML.
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
To: Krishnappa Abhijith-A21204 <abhijith@motorola.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 19, 2007 at 11:13:11AM +0800, Krishnappa Abhijith-A21204 wrote:
>         Regarding Virtual Memory Emulation in UML (TT mode).
> UML will create a file of Physical mem size and it allocates memory to
> UML process by mmap() ing it.
>  
> Also in Jeff's article I read that Kernel's text and Data are located in
> the process address space....

In tt mode, yes.

> Why the kernels text and data will be in UML Process address space ?

Because there is (or at the time, seemed to be) no other way to change
address space mappings (mmap, munmap, mprotect) or to get page fault
information except to have the UML kernel in the same address space as
the process.

> Normaly kernel is a seprate entity right ?

Sure, but this is the same situation as on i386.  The host kernel
occupies the upper 1G of the process address space.

> So basically process and kernel address space co-exist.. May I know
why?

Because it works, but skas0 shows another way to make this work.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
