Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GHyvp-00073L-HA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Aug 2006 01:26:49 -0700
Received: from web25222.mail.ukl.yahoo.com ([217.146.176.208])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GHyvn-00078Z-UF
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Aug 2006 01:26:49 -0700
Message-ID: <20060829082641.48020.qmail@web25222.mail.ukl.yahoo.com>
Date: Tue, 29 Aug 2006 10:26:41 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
In-Reply-To: <20060828203514.GC6728@ccure.user-mode-linux.org>
MIME-Version: 1.0
Subject: Re: [uml-devel] arch/um/sys-i386/setjmp.S: useless #ifdef _REGPARM's?
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
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>

Jeff Dike <jdike@addtoit.com> ha scritto: 

> On Sat, Aug 26, 2006 at 12:56:36PM +0200, Blaisorblade wrote:
> > Can anybody explain me how can we use REGPARM if we have to link
> with host 
> > glibc?

> Umm, yeah, good point.  This regparam behavior is different from
> the old
> behavior, where regparam functions had to be declared as such.

And which can still be enabled - I think fastcall is for this, and it
is still useful.

However more useful is to move many wrappers where this is possible
to headers (for instance the ones calling just
CHOOSE_MODE($me_tt,$me_skas) - moving them to headers is always
possible and saves a call).

> However, this is a potential problem with all regparam users, who
> all
> presumably use libc, so I'd imagine it works somehow.

For my knowledge, the only user is the non-UML Linux kernel, which
doesn't use libc :-).

And if you want to mix regparm and not regparm calls, you end up
marking it at a prototype level (i.e. with the old approach); GCC
could be smarter and allow specifying it at a per-header or per
header-folder level, but I do not think it does.

> > If we are going to use klibc instead of glibc that's ok (and this
> is not the 
> > case I'm talking about), but I do not know that plan (and nobody
> discussed 
> > the implications).

> I've been idly considering that, but it's no more than idle
> consideration
> right now.

Fine... it is actually a good idea for some points (we currently
refrain from using certain things, such as futexes, because our
tricks could conflict with glibc tricks which we don't know - with
klibc it would be different).
We'll see.

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
