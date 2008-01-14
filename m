Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JEWz1-0000eZ-72 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jan 2008 13:36:39 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JEWyw-00086W-IW
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jan 2008 13:36:36 -0800
Received: from c2.user-mode-linux.org (littleton.addtoit.com [198.99.130.129])
	by saraswathi.solana.com (8.13.1/8.13.1) with ESMTP id m0ELaVRL021919
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 14 Jan 2008 16:36:31 -0500
Received: from c2.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by c2.user-mode-linux.org (8.14.1/8.13.8) with ESMTP id m0ELaUqj002603
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 14 Jan 2008 16:36:30 -0500
Date: Mon, 14 Jan 2008 16:36:30 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080114213630.GA2469@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 4/10] SKAS4 - Workaround compat
	PTRACE_GETSIGINFO bug
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: UML-user <user-mode-linux-devel@lists.sourceforge.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

    copy_siginfo_to_user correctly strips off the high bits of si->si_code
    before copying it to userspace.
    
    Unfortunately, ptrace32_siginfo calls copy_siginfo_to_user to put the
    siginfo into a temporary userspace buffer and counts on the high bits
    still being present so that it may initialize the union in the final
    32-bit siginfo.
    
    This patch works around this problem by having copy_siginfo_to_user
    copy si->si_code intact to userspace.  This introduces a bug in native
    64-bit PTRACE_GETSIGINFO, but I haven't noticed anything being
    bothered by it.

diff --git a/kernel/signal.c b/kernel/signal.c
index 1e067a1..28813b1 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2088,7 +2088,7 @@ int copy_siginfo_to_user(siginfo_t __user *to, siginfo_t *from)
 	 */
 	err = __put_user(from->si_signo, &to->si_signo);
 	err |= __put_user(from->si_errno, &to->si_errno);
-	err |= __put_user((short)from->si_code, &to->si_code);
+	err |= __put_user(from->si_code, &to->si_code);
 	switch (from->si_code & __SI_MASK) {
 	case __SI_KILL:
 		err |= __put_user(from->si_pid, &to->si_pid);

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
