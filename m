Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ds5za-0007ln-4o	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 14:39:10 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.44)
	id 1Ds5zW-0007io-Mn	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 14:39:10 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: SKAS0 test tree against 2.6.12
References: <20050707182817.9601389260@sc8-sf-spam1.sourceforge.net>
	<1120818569.2940.6.camel@172.16.1.47>
	<200507091240.46934.blaisorblade@yahoo.it>
In-Reply-To: <200507091240.46934.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_piu0CiI29RNNhgr"
Message-Id: <200507112346.17413.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 11 Jul 2005 23:46:17 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: antoine <antoine@nagafix.co.uk>

--Boundary-00=_piu0CiI29RNNhgr
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 09 July 2005 12:40, Blaisorblade wrote:
> On Friday 08 July 2005 12:29, antoine wrote:
> >
> > Don't know if you're interested in this report but it does not build for
> > x86_64:
> >   SYMLINK arch/um/sys-x86_64/semaphore.c
> >   CC      arch/um/sys-x86_64/semaphore.o
> >   CC      arch/um/sys-x86_64/sigcontext.o
> >   CC      arch/um/sys-x86_64/signal.o
> > arch/um/sys-x86_64/signal.c: In function =E2=80=98setup_signal_stack_si=
=E2=80=99:
> > arch/um/sys-x86_64/signal.c:171: error: invalid lvalue in assignment
> > make[1]: *** [arch/um/sys-x86_64/signal.o] Error 1
> > make: *** [arch/um/sys-x86_64] Error 2
>
> I remember this report, only I just suggested the fix and didn't post it
> (was busy at that time). It's SKAS0 - unrelated I think (I may be wrong,
> but the whole patchset does not include it) but triggered by GCC4.
Please keep remembering I *am* stupid, as just noted by Russell King (ARM=20
maintainer) :-(.

The attached patch makes more sense... however it seems that the affected c=
ode=20
is anyway buggy, so I hope Jeff will help fixing this (unless I get to=20
understand this magically).
=2D-=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_piu0CiI29RNNhgr
Content-Type: text/x-diff;
  charset="utf-8";
  name="uml-fix-for-gcc4-lvalue.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-fix-for-gcc4-lvalue.patch"


This is refused by GCC 4, so here's the fix.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 vanilla-linux-2.6.12-paolo/arch/um/sys-x86_64/signal.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue arch/um/sys-x86_64/signal.c
--- vanilla-linux-2.6.12/arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue	2005-07-11 23:23:27.000000000 +0200
+++ vanilla-linux-2.6.12-paolo/arch/um/sys-x86_64/signal.c	2005-07-11 23:23:41.000000000 +0200
@@ -168,7 +168,7 @@ int setup_signal_stack_si(unsigned long 
 
 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
-	((unsigned char *) frame) -= 128;
+	frame -= 128 / sizeof(*frame);
 
 	if (!access_ok(VERIFY_WRITE, fp, sizeof(struct _fpstate)))
 		goto out;
_

--Boundary-00=_piu0CiI29RNNhgr--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
