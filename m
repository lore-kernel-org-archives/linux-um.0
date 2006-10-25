Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GckQT-00037B-Dj for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Oct 2006 08:12:17 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GckQQ-0005yA-4P
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Oct 2006 08:12:17 -0700
Date: Wed, 25 Oct 2006 11:10:24 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061025151024.GA4323@ccure.user-mode-linux.org>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
	<20061017212711.26445.79770.stgit@americanbeauty.home.lan>
	<20061018183707.GB6566@ccure.user-mode-linux.org>
	<200610210211.28502.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200610210211.28502.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 04/10] uml: make execvp safe for our usage
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
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, Oct 21, 2006 at 02:11:28AM +0200, Blaisorblade wrote:
> > This is horriby ugly.
> 
> Detail why. The code of execvp()? Passing in the buffer?
> I'm not saying it's the brightest code around here, but it's ok for me.

My initial reaction was mostly due to the look of the code, which is
fixable.  I also don't like carrying around bits of libc (although we
do have setjmp/longjmp, but that's a special case).  However, it's
unlikely that it will need much maintenance, so this is more a taste
thing as well.

> I initially thought to design a two-steps API with a "which" operation (where
> memory allocation was used) to call later execvp(); when I saw the glibc 
> implementation (it allocates one single fixed-size buffer) I saw it was 
> simpler this way.

I think I still like the two-stage thing better.  If the 'which' part
finds something that doesn't exec, then we can just spit out a nice error.

> I'd not do that at boot, but just before the fork()+execve() - it is 
> conceivable that a given user will install a support binary after booting 
> UML.

I was envisioning it being part of bootup, but doing it just before
the exec would be OK, too.

				Jeff

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
