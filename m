Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gcsp6-0006bq-Pm for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Oct 2006 17:10:17 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Gcsp3-0003ZP-5f
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Oct 2006 17:10:16 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 26 Oct 2006 02:10:05 +0200
References: <7b2fa1820610192302o52213a59uc220df19e6a84fbb@mail.gmail.com>
	<7b2fa1820610221904q53df7d55w522384177fe3d705@mail.gmail.com>
	<20061025152635.GC4323@ccure.user-mode-linux.org>
In-Reply-To: <20061025152635.GC4323@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610260210.05495.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.4.21 insmod problem: unresolved symbol to_virt
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Ian Jiang <ianjiang.ict@gmail.com>

On Wednesday 25 October 2006 17:26, Jeff Dike wrote:
> On Mon, Oct 23, 2006 at 10:04:00AM +0800, Ian Jiang wrote:
> > In fact, I used to export the symbol to_virt in um/kernel/physmem.c
> > where it was defined.
>
> There is no to_virt defined in physmem.c in my tree now.
>
> > But this had no effect. What is the difference
> > between the ksyms.c and physmem.c while exporting symbols? Could you
> > give an explanation?
>
> There shouldn't be any difference.  physmem.c already exports some stuff,
> so there's no reason it can export more.
On 2.4 kernels (and no Jeff, your tree is not a 2.4) EXPORT_SYMBOLS only works 
on some special files (like ksyms.c) devoted to this (they're marked in 
Makefile's); on 2.6 you can add the export everywhere and it will work.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
