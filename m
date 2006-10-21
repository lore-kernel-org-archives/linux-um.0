Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gb5Tk-0002cV-Bm for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 18:16:48 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Gb5Ti-0008Jd-PG
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 18:16:48 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 21 Oct 2006 03:16:38 +0200
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
	<20061017212711.26445.79770.stgit@americanbeauty.home.lan>
	<20061018183707.GB6566@ccure.user-mode-linux.org>
In-Reply-To: <20061018183707.GB6566@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610210316.38732.blaisorblade@yahoo.it>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Wednesday 18 October 2006 20:37, Jeff Dike wrote:
> On Tue, Oct 17, 2006 at 11:27:11PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > Reimplement execvp for our purposes - after we call fork() it is
> > fundamentally unsafe to use the kernel allocator - current is not valid
> > there.
>
> This is horriby ugly.  Can we instead do something different like
> check out the paths of helpers at early boot, before the kernel is
> running, save them, and simply execve them later?
>
> At that point, something like running "which foo" would be fine by me.

I'd add that this can IMHO cause hard-to-diagnose crashes (I've seen strange 
behaviours in debug mode, and even schedule-while-atomic warnings, maybe 
because the creator thread had gone in atomic mode), and since this is a 
working fix, either this or a replacement should go in.
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
