Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FO0dE-0004nj-AD for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Mar 2006 14:56:16 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FO0dB-0001rj-V4
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Mar 2006 14:56:16 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Fwd: Re: Why
	uml-add-tls-support-debug-check-never-works is needed
References: <200603262003.58195.blaisorblade@yahoo.it>
	<20060326204026.GB4549@ccure.user-mode-linux.org>
In-Reply-To: <20060326204026.GB4549@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_J2GKEjLaPKMMNrk"
Message-Id: <200603280056.09452.blaisorblade@yahoo.it>
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
Date: Tue, 28 Mar 2006 00:56:07 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_J2GKEjLaPKMMNrk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 26 March 2006 22:40, Jeff Dike wrote:	
> And, BTW, you should probably send the TLS stuff in this week if you
> want it to go into 2.6.17 easily.

Ok, I've just finished everything (including proper detection of ) and feel 
satisfied of the code. However, look at the attached patch - it's a cosmetic 
bug which I found while testing TLS, and I'd like you to review it.

Meanwhile, I'm releasing 2.6.16-bb1 with the TLS stuff and this patch 
included, plus various other little stuff.

I hope this week I can send TLS in mainline, however we should be able to get 
it even if it's a few days past the deadline.

My current problem is that out of a whole week, I can only hack on Wednesday 
afternoon, or on the weekend (read sunday afternoon) if I can do that, or 
after dinner. I'd have a lot of time on early morning, but you can understand 
it goes easily wasted because I must sleep.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_J2GKEjLaPKMMNrk
Content-Type: text/x-diff; charset="iso-8859-1";
	name="uml-fix-mm-usage-in-cpu_idle"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-fix-mm-usage-in-cpu_idle"

uml idle thread needn't take access to init_mm

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Comparing this code which is the actual body of the arch-independent cpu_idle(),
it is clear that it's unnecessary to set ->mm and ->active_mm; beyond that, a
kernel thread is not supposed to have ->mm != NULL, only active_mm.

This showed up because I used the assumption (which is IMHO valid) that kernel
thread have their ->mm == NULL, and it failed for this thread.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.16/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/process_kern.c
+++ linux-2.6.16/arch/um/kernel/process_kern.c
@@ -201,10 +201,6 @@ void default_idle(void)
 {
 	CHOOSE_MODE(uml_idle_timer(), (void) 0);
 
-	atomic_inc(&init_mm.mm_count);
-	current->mm = &init_mm;
-	current->active_mm = &init_mm;
-
 	while(1){
 		/* endless idle loop with no priority at all */
 

--Boundary-00=_J2GKEjLaPKMMNrk--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
