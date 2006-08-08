Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GAP6E-0005oz-Qz for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 03:46:14 -0700
Received: from web25224.mail.ukl.yahoo.com ([217.146.176.210])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GAP6C-0000GP-8E
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 03:46:14 -0700
Message-ID: <20060808104605.6696.qmail@web25224.mail.ukl.yahoo.com>
Date: Tue, 8 Aug 2006 12:46:05 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
In-Reply-To: <20060807211850.GB5890@ccure.user-mode-linux.org>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/3] uml: use -mcmodel=kernel for x86_64
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

Jeff Dike <jdike@addtoit.com> ha scritto: 

> On Sun, Aug 06, 2006 at 05:47:00PM +0200, Paolo 'Blaisorblade'
> Giarrusso wrote:
> > +_extra_flags_ = -fno-builtin -m64 -mcmodel=kernel

> What exactly does this do
go to "man gcc" and search mcmodel for the answer to this one.
And x86_64 uses it too, so this patch should go for 2.6.18.

>, and can you remember why you think it's
> needed?

Ok, here's my answer to the original bugreport, which is a complete
explaination - sorry for not providing the link, I have very little
time for UML this summer.

http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=115125101012707&w=2

Bye

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
