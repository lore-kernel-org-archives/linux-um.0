Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gb4Sl-0005J6-SJ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 17:11:43 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Gb4Sh-0004FE-SP
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 17:11:43 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 21 Oct 2006 02:11:28 +0200
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
	<20061017212711.26445.79770.stgit@americanbeauty.home.lan>
	<20061018183707.GB6566@ccure.user-mode-linux.org>
In-Reply-To: <20061018183707.GB6566@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610210211.28502.blaisorblade@yahoo.it>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wednesday 18 October 2006 20:37, Jeff Dike wrote:
> On Tue, Oct 17, 2006 at 11:27:11PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > Reimplement execvp for our purposes - after we call fork() it is
> > fundamentally unsafe to use the kernel allocator - current is not valid
> > there.
>
> This is horriby ugly.

Detail why. The code of execvp()? Passing in the buffer?
I'm not saying it's the brightest code around here, but it's ok for me.

> Can we instead do something different like 
> check out the paths of helpers at early boot, before the kernel is
> running, save them, and simply execve them later?
I initially thought to design a two-steps API with a "which" operation (where 
memory allocation was used) to call later execvp(); when I saw the glibc 
implementation (it allocates one single fixed-size buffer) I saw it was 
simpler this way.

Additionally, error handling cannot be done properly without trying an exec - 
I think it is also ok to drop this execvp semantic, so that if the first 
binary found in path is marked executable but has the wrong binary format the 
whole thing just does not start.

The current implementation already diverges from glibc - it never calls 
directly the shell passing a script, because IMHO execve() will care for that 
(and testing confirmed this IIRC).

I'd not do that at boot, but just before the fork()+execve() - it is 
conceivable that a given user will install a support binary after booting 
UML.

I must say that I've seen files without the shebang working ok (if having the 
executable bit set) when executed from the shell, and I've had the doubt 
execvp() would handle that.

> At that point, something like running "which foo" would be fine by me.

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
