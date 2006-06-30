Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fw6tR-0004nh-Kq for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 17:29:57 -0700
Received: from web25212.mail.ukl.yahoo.com ([217.12.10.72])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Fw6tO-0006PD-RZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 17:29:57 -0700
Message-ID: <20060630002948.76478.qmail@web25212.mail.ukl.yahoo.com>
Date: Fri, 30 Jun 2006 02:29:48 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
In-Reply-To: <20060629205626.GH4488@us.ibm.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] Fix UML build on i386 Ubuntu Dapper
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
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

Nishanth Aravamudan <nacc@us.ibm.com> ha scritto: 

> On 28.06.2006 [12:13:21 +0200], Blaisorblade wrote:

> Just for clarity's sake, the reason the #undef is there, as far as
> I can
> tell, is otherwise the preprocessor (I'm assuming) goes and makes
> the
> output specification as 1:x86_64 instead of i386:x86_64.

I can confirm this is also what I understood.

> I removed the #undef i386 from vmlinux.ld.S and added a
> 
> CPPFLAGS += -m64
> 
> to arch/um/Makefile-x86_64

> The build completed fine here.
Yep, that's ok too (and shouldn't hurt for the rest - we'll get -m64
twice for .c files but it shouldn't be a problem; I thought to make
it specific it only for vmlinux.lds.S to avoid the duplication).

> I wonder if a patch against x86_64 to remove the #undef there
> should
> also be applied? I'll take a look.

Probably it can, and IMHO it's cleaner. For me the patch is now
perfect; Jeff please update the one in -mm.

> Thanks,
> Nish


Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
