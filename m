Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Tue, 5 Feb 2008 11:46:27 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080205164627.GA7805@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 4/11] SKAS4 - Work around compat
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
To: uml-user <user-mode-linux-user@lists.sourceforge.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

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
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
