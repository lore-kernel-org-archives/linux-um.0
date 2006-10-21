Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gb5t9-0004qz-Ee for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 18:43:03 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Gb5t6-00019t-Mp
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 18:43:03 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 21 Oct 2006 03:42:47 +0200
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
	<20061017212709.26445.54420.stgit@americanbeauty.home.lan>
	<20061018183222.GA6566@ccure.user-mode-linux.org>
In-Reply-To: <20061018183222.GA6566@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610210342.48107.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 03/10] uml: fix prototypes
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

On Wednesday 18 October 2006 20:32, Jeff Dike wrote:
> On Tue, Oct 17, 2006 at 11:27:09PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > Fix prototypes in user.h - was needed when including user.h in
> > kernelspace, as we did in previous patch.
>
> user.h shouldn't be included in kernelspace - its purpose is to
> provide kernel prototypes to userspace code.
Actually I now think (and just verified) I do not even include it any more in 
kernelspace - that comment is outdated. Having a more correct prototype is 
anyway nicer, so that patch can go in with a rewritten changelog (but that's 
a taste matter). I'm rewriting it anyway.
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
