Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DNyx2-0004eJ-4g for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Apr 2005 13:04:04 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DNywx-0003dU-Aq for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Apr 2005 13:04:04 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <200503112013.20206.blaisorblade@yahoo.it>
	<200504142311.43374.blaisorblade@yahoo.it>
	<1113928612.5221.10.camel@powerful.admindu.de>
In-Reply-To: <1113928612.5221.10.camel@powerful.admindu.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gWrZCC4ewsFBduk"
Message-Id: <200504202203.44733.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [uml-user] Loadav always >1.0 (2.6.X)
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
Date: Wed, 20 Apr 2005 22:03:43 +0200
To: Daniel Tombeil <dt@admindu.de>, user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_gWrZCC4ewsFBduk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 19 April 2005 18:36, Daniel Tombeil wrote:
> Hi Blaisorblade,
>
> On Thu, 2005-04-14 at 23:11 +0200, Blaisorblade wrote:
> > On Thursday 14 April 2005 20:36, Daniel Tombeil wrote:
> > > Hello,
>
> [...]
>
> > discussed patch which fixed it. I'd like to know any info on this road
> > (it's possible that these two bugs are just similar, but entirely
> > different, but I'd like some reports).
> >
> > Also I'm currently in short of time, so I cannot investigate this well...
>
> sorry, I don't seem to unterstand. I searched the devel list archive
> (I'm not subscribed to devel) and found the thread on the change
> from /proc/stat. I can confirm that my problem seems to be related. But
> I wasn't able to extract the info which patch should solve the problem.

The patch I suggested to Chris was named, in the patch, 
"update-process-times", however the name in my tree was uml-timer-context. 
I've attached it.

Chris Aker reported that in 2.6.10 it fixed the problem, but I didn't verify 
(even because I simply knew that patch *had* to be applied to fix some 
problems, so I just asked it to check that it fixed also that problem). Also, 
this patch *has* been applied in 2.6.11; however, I'd still like a 
confirmation that it fixed the problem in 2.6.10.

That said, I'm currently running and verifying this on 2.6.11 and what I see 
with top is that

a) ksoftirqd is always runnable, but
b) it always gets 0% cpu usage
which is *very* strange.

While on 2.6.9 it works perfectly ok.
> I tried all of your -bb and -bs from 2.6.10 to 2.6.11.7 with the same
> result on load 1.0. Beside of that the kernels seem to be very stable.
> I'm running 5 Guest UMLs with Mailserver (exim,spamassasin,clamav deb-
> sarge), WWW (lamp, deb-sarge), Aptcache (squid, deb-sarge), 2 UMLs for
> friends (LAMP, Mail, deb-sarge) on an 2.6.8skas-v6 Host (deb-sarge). I
> now went back to a 2.4.27-bs1 which seems to be rock-solid because some
> of the friends didn't like the 1.0 load in their stats or something :)
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_gWrZCC4ewsFBduk
Content-Type: text/x-diff; charset="iso-8859-1"; name="uml-timer-context.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-timer-context.patch"


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

In call to update_process_times() set parameter user
correctly. (was from for SKAS).

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/time_kern.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/time_kern.c~uml-timer-context arch/um/kernel/time_kern.c
--- vanilla-linux-2.6.9/arch/um/kernel/time_kern.c~uml-timer-context	2004-12-01 18:04:36.967383992 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/time_kern.c	2004-12-01 18:04:36.971383384 +0100
@@ -171,7 +171,7 @@ void timer_handler(int sig, union uml_pt
 {
 #ifdef CONFIG_SMP
 	local_irq_disable();
-	update_process_times(user_context(UPT_SP(regs)));
+	update_process_times(CHOOSE_MODE(user_context(UPT_SP(regs)), (regs)->skas.is_user));
 	local_irq_enable();
 #endif
 	if(current_thread->cpu == 0)
_

--Boundary-00=_gWrZCC4ewsFBduk--




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
