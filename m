Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVAaR-0003dY-FR for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 12:40:19 -0700
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVAaO-00074n-W1
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 12:40:17 -0700
Date: Mon, 18 Aug 2008 12:20:38 -0700
From: Greg KH <gregkh@suse.de>
Message-ID: <20080818192038.GL10350@suse.de>
References: <20080818191012.663450219@mini.kroah.org>
MIME-Version: 1.0
Content-Disposition: inline;
	filename="uml-work-around-broken-host-ptrace_sysemu.patch"
In-Reply-To: <20080818191834.GA10350@suse.de>
Subject: [uml-devel] [patch 37/49] uml: work around broken host PTRACE_SYSEMU
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
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Eugene Teo <eteo@redhat.com>, Justin Forbes <jmforbes@linuxtx.org>, Domenico Andreoli <cavokz@gmail.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Jake Edge <jake@lwn.net>, Randy Dunlap <rdunlap@xenotime.net>, Michael Krufky <mkrufky@linuxtv.org>, alan@lxorguk.ukuu.org.uk, Chuck Ebbert <cebbert@redhat.com>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, akpm@linux-foundation.org, Jeff Dike <jdike@linux.intel.com>, torvalds@linux-foundation.org, Willy Tarreau <w@1wt.eu>, Rodrigo Rubira Branco <rbranco@la.checkpoint.com>

2.6.25-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Jeff Dike <jdike@addtoit.com>

commit f1ef9167ca4494a8c6d71d0031c73e9c8841eadd upstream

Fedora broke PTRACE_SYSEMU again, and UML crashes as a result when it
doesn't need to.  This patch makes the PTRACE_SYSEMU check fail gracefully
and makes UML fall back to PTRACE_SYSCALL.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/os-Linux/start_up.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -122,8 +122,10 @@ static int stop_ptraced_child(int pid, i
 {
 	int status, n, ret = 0;
 
-	if (ptrace(PTRACE_CONT, pid, 0, 0) < 0)
-		fatal_perror("stop_ptraced_child : ptrace failed");
+	if (ptrace(PTRACE_CONT, pid, 0, 0) < 0) {
+		perror("stop_ptraced_child : ptrace failed");
+		return -1;
+	}
 	CATCH_EINTR(n = waitpid(pid, &status, 0));
 	if (!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode)) {
 		int exit_with = WEXITSTATUS(status);
@@ -203,7 +205,7 @@ static void __init check_sysemu(void)
 	if (n < 0)
 		fatal_perror("check_sysemu : wait failed");
 	if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
-		fatal("check_sysemu : expected SIGTRAP, got status = %d",
+		fatal("check_sysemu : expected SIGTRAP, got status = %d\n",
 		      status);
 
 	if (ptrace(PTRACE_GETREGS, pid, 0, regs) < 0)
@@ -245,9 +247,11 @@ static void __init check_sysemu(void)
 
 		if (WIFSTOPPED(status) &&
 		    (WSTOPSIG(status) == (SIGTRAP|0x80))) {
-			if (!count)
-				fatal("check_ptrace : SYSEMU_SINGLESTEP "
-				      "doesn't singlestep");
+			if (!count) {
+				non_fatal("check_ptrace : SYSEMU_SINGLESTEP "
+					  "doesn't singlestep");
+				goto fail;
+			}
 			n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET,
 				   os_getpid());
 			if (n < 0)
@@ -257,9 +261,12 @@ static void __init check_sysemu(void)
 		}
 		else if (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGTRAP))
 			count++;
-		else
-			fatal("check_ptrace : expected SIGTRAP or "
-			      "(SIGTRAP | 0x80), got status = %d", status);
+		else {
+			non_fatal("check_ptrace : expected SIGTRAP or "
+				  "(SIGTRAP | 0x80), got status = %d\n",
+				  status);
+			goto fail;
+		}
 	}
 	if (stop_ptraced_child(pid, 0, 0) < 0)
 		goto fail_stopped;

-- 

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
