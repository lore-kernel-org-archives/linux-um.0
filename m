Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GcyQA-00060C-2a for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Oct 2006 23:08:54 -0700
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GcyQ6-00051e-7E
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Oct 2006 23:08:53 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 26 Oct 2006 08:08:26 +0200
References: <20061009163208.GA4931@ccure.user-mode-linux.org>
	<20061011110828.43576.qmail@web25221.mail.ukl.yahoo.com>
	<20061013201010.GC5517@ccure.user-mode-linux.org>
In-Reply-To: <20061013201010.GC5517@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610260808.27508.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 01/14] uml: fix compilation options for
	USER_OBJS
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
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Friday 13 October 2006 22:10, Jeff Dike wrote:
> On Wed, Oct 11, 2006 at 01:08:27PM +0200, Paolo Giarrusso wrote:
> > Ok, at a first glance this alternative solution is ok. Make sure (run
> > gdb on an userspace object file and saying list <function>) that it
> > works and we'll be ok.
>
> After discovering that the original patch broke UML/i386 and broke the
> UML/x86_64 build, I now have the patch below.
Where is it? It should go in 2.6.19. I'm going to test it locally and merge 
it.
> Listing userspace functions is fine.
Good...
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
