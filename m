Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DrCez-0007Ay-8a	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Jul 2005 03:34:13 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.44)
	id 1DrCex-0004Sl-Ou	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Jul 2005 03:34:13 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: SKAS0 test tree against 2.6.12
References: <20050707182817.9601389260@sc8-sf-spam1.sourceforge.net>
	<1120818569.2940.6.camel@172.16.1.47>
In-Reply-To: <1120818569.2940.6.camel@172.16.1.47>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_um6zCfCx7RiWWsP"
Message-Id: <200507091240.46934.blaisorblade@yahoo.it>
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
Date: Sat, 9 Jul 2005 12:40:46 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: antoine <antoine@nagafix.co.uk>

--Boundary-00=_um6zCfCx7RiWWsP
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 08 July 2005 12:29, antoine wrote:
> > Ok, it's there. I've simply adapted the two SKAS0 patches for 2.6.12
> > (backporting a cleanup and fixing some trivial rejects). More info at t=
he
> > web page.
> >
> > Testing is welcome. In particular, any regression in SKAS3 mode should =
be
> > prompty reported to me and Jeff, because they are not expected at all.
> >
> > I'll add a simplified "proc_mm=3D0" switch (it's not the Bodo's patch
> > because that is more intrusive and splits that further into proc_mm and
> > faultinfo switches).

> Don't know if you're interested in this report but it does not build for
> x86_64:
>   SYMLINK arch/um/sys-x86_64/semaphore.c
>   CC      arch/um/sys-x86_64/semaphore.o
>   CC      arch/um/sys-x86_64/sigcontext.o
>   CC      arch/um/sys-x86_64/signal.o
> arch/um/sys-x86_64/signal.c: In function =A1setup_signal_stack_si=A2:
> arch/um/sys-x86_64/signal.c:171: error: invalid lvalue in assignment
> make[1]: *** [arch/um/sys-x86_64/signal.o] Error 1
> make: *** [arch/um/sys-x86_64] Error 2
I remember this report, only I just suggested the fix and didn't post it (w=
as=20
busy at that time). It's SKAS0 - unrelated I think (I may be wrong, but the=
=20
whole patchset does not include it) but triggered by GCC4.

> Could you include the pcap patch in bb?
Yes, I'll do.
> Thanks
> Antoine

=2D-=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_um6zCfCx7RiWWsP
Content-Type: text/x-diff;
  charset="iso-8859-7";
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
--- vanilla-linux-2.6.12/arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue	2005-07-09 12:02:27.000000000 +0200
+++ vanilla-linux-2.6.12-paolo/arch/um/sys-x86_64/signal.c	2005-07-09 12:02:51.000000000 +0200
@@ -168,7 +168,7 @@ int setup_signal_stack_si(unsigned long 
 
 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
-	((unsigned char *) frame) -= 128;
+	frame -= 128 / sizeof(frame);
 
 	if (!access_ok(VERIFY_WRITE, fp, sizeof(struct _fpstate)))
 		goto out;
_

--Boundary-00=_um6zCfCx7RiWWsP--

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
