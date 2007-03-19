Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HTLxR-0006iH-3t for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Mar 2007 10:47:45 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HTLxN-0001Wb-VO
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Mar 2007 10:47:42 -0700
Date: Mon, 19 Mar 2007 13:45:37 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070319174537.GD11790@c2.user-mode-linux.org>
References: <0A01463223B8164194908CAC85B66A1201AD3E65@ZMY16EXM67.ds.mot.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0A01463223B8164194908CAC85B66A1201AD3E65@ZMY16EXM67.ds.mot.com>
Subject: Re: [uml-devel] Regarding Kernel mode in UML process.
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

On Mon, Mar 19, 2007 at 11:16:38AM +0800, Krishnappa Abhijith-A21204 wrote:
>         Regarding Kernel mode in UML process. This question is on UML TT
> mode
> A UML process wil be in Kernel mode only for executing the getpid(), and
> also some signals is a UML specified stack.

And whenever the UML kernel executes a system call, of which there are
many.

> Also when UML process enters the KERNEL by the means described above the
> tracing is turned off, this is done for performance issues only
> right ?

No, it's done for security.  A UML process must not be allowed to
execute system calls on the host.  Only the UML kernel may do that.

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
