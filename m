Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVbGU-0008GU-La for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 15:00:27 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GVbGS-0006BW-1x
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 15:00:24 -0700
Date: Thu, 5 Oct 2006 17:59:07 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061005215907.GE6790@ccure.user-mode-linux.org>
References: <20061002003054.GA9780@baroni.homelinux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20061002003054.GA9780@baroni.homelinux.org>
Subject: Re: [uml-devel] compile error: user-offsets.c
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
To: Rodrigo Baroni <baroni@ime.usp.br>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Oct 01, 2006 at 09:30:54PM -0300, Rodrigo Baroni wrote:
> arch/um/sys-i386/user-offsets.c: In function ???foo???:
> arch/um/sys-i386/user-offsets.c:18: warning: implicit declaration of function ???offsetof???

This turned out to be caused by making links from
/usr/include/{linux,asm} to a kernel tree, causing linux/stdlib.h to
not have a usable offsetof any more (it was inside #ifdef KERNEL,
which obviously isn't defined for this file).

The standard libc headers which are supposed to be there have a good
offsetof.
				Jeff


> arch/um/sys-i386/user-offsets.c:18: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:19: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:20: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:21: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:22: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:23: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:24: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:25: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:26: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:27: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:28: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:29: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:30: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:31: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:32: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:33: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:34: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:35: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:36: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:37: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:38: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:39: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:40: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:41: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:42: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:43: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:44: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:45: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:46: error: expected expression before ???struct???
> arch/um/sys-i386/user-offsets.c:47: error: expected expression before ???struct???
> make: ** [arch/um/user-offsets.s] Erro 1
> baroni@baroni:/usr/src/v2.6.16-uml$
> 
> Thanks,
> Rodrigo
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 

-- 
foo

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
