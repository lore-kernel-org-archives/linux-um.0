Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CSJh3-00019d-8o for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Nov 2004 10:29:13 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CSJh2-0002xU-E0 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Nov 2004 10:29:13 -0800
Message-ID: <4193AF6C.1050108@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <200411102008.02212.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411102008.02212.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: 2.6.9-bb2 released.
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
Date: Thu, 11 Nov 2004 19:29:00 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Blaisorblade wrote:
> You can find all on http://www.user-mode-linux.org/~blaisorblade/.
> 
> Changes in both 2.6.9-bb2 against 2.6.9-bb1:
> - updated most bugs of -bb1 which were reported
> - fixed the Gentoo/NPTL issue, thanks to Bodo Stroesser (sorry for forgetting 
> the credit on the changelog, but I'm leaving for one day in a few minutes):
> but you must still compile Uml disabling CONFIG_MODE_TT (and obviously use the 
> SKAS patch you find on the same site).
> 
> More info on the website "Changelog" page.
> 
> Distribution (like -bb1):
> 
> * the patch are also in split-out form, both web-browsable and tarballed.
> * md5sums are available (to test with "md5sum -c *.md5").
> 
> Any testing and report is welcome.
> 
> Hope It Rocks!
Fine!

Here is a little fix, that removes doubly inserted code.

Bodo

---

--- a/arch/um/kernel/tt/trap_user.c	2004-11-11 16:54:12.370670328 +0100
+++ b/arch/um/kernel/tt/trap_user.c	2004-11-11 16:54:40.850340760 +0100
@@ -30,13 +30,6 @@ void sig_handler_common_tt(int sig, void
  	if(sig == SIGSEGV)
  		change_sig(SIGSEGV, 1);

-	/* This is done because to allow SIGSEGV to be delivered inside a SEGV
-	 * handler.  This can happen in copy_user, and if SEGV is disabled,
-	 * the process will die.
-	 */
-	if(sig == SIGSEGV)
-		change_sig(SIGSEGV, 1);
-
  	r = &TASK_REGS(get_current())->tt;
  	save_regs = *r;
  	is_user = user_context(SC_SP(sc));



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
