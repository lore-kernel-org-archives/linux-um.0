Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DGhxN-0008RN-Lf for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 10:30:21 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DGhx2-0006ok-PM for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 10:30:21 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Message-Id: <200503292021.19564.blaisorblade@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fyZSC+DDrpOZZ3i"
Subject: [uml-devel] Critical instability in 2.4.27-1um
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
Date: Tue, 29 Mar 2005 20:21:19 +0200
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

--Boundary-00=_fyZSC+DDrpOZZ3i
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

While testing the 2.4.27-bs2 prerelease, I discovered that when I run, at a=
=20
login shell, this amazingly difficult stress-test:

while /bin/true; do /bin/true; done

makes the login shell exit back to the login prompt, after some time (so it=
's=20
a race condition).

I've analyzed this and discovered that it's caused by the 2.4.27-1um securi=
ty=20
fixes, which I incorporated in that tree.

I think that Jeff and Bodo has an idea about this, because in a chat betwee=
n=20
me, him and Bodo, he said that in 2.6, with this stripped-down set of=20
security fixes, he was seeing problems (maybe wrong return values) with=20
fork()/vfork(). (Nobody mentioned this test case however).

I didn't understand fully the problems at that time, however.

I've verified this with a 2.4.27-1um vanilla tree, too.

=46rom looking at the code, it's probably related to syscall-security-6 (II=
RC it=20
was somehow related to handle_signal). And in fact, I can fix this by remov=
ing=20
the two attached patches.

This was subsequently fixed by merging all the rest of the work, since Bodo=
=20
noted that the full patchset didn't have the mentioned problem (and in a=20
improved form, since the 2.6.10 is more stable than 2.6.9-bs7 for some user=
s,=20
notably Rob Landley who is using TT mode).

So I guess this should be fixed by backporting all that stuff to 2.4.

=46or now, I can't, so I'm going to release 2.4.27-2um excluding the attach=
ed=20
problematic patches. syscall-security-7 stems from syscall-security-6, whil=
e=20
syscall-security-7-fix is a couple of fixes extracted from the released=20
2.4.27-1um patch which are missing in the official splitout.
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_fyZSC+DDrpOZZ3i
Content-Type: text/x-diff; charset="us-ascii";
	name="syscall-security-7-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syscall-security-7-fix.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 um-linux-2.4.27-paolo/arch/um/kernel/signal_kern.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/um/kernel/signal_kern.c~syscall-security-6-fix arch/um/kernel/signal_kern.c
--- um-linux-2.4.27/arch/um/kernel/signal_kern.c~syscall-security-6-fix	2005-03-29 19:41:21.000000000 +0200
+++ um-linux-2.4.27-paolo/arch/um/kernel/signal_kern.c	2005-03-29 19:41:21.000000000 +0200
@@ -47,14 +47,15 @@ static void force_segv(int sig)
  */
 static int handle_signal(struct pt_regs *regs, unsigned long signr,
 			 struct k_sigaction *ka, siginfo_t *info,
-			 sigset_t *oldset, int error)
+			 sigset_t *oldset)
 {
         __sighandler_t handler;
 	void (*restorer)(void);
 	unsigned long sp;
 	sigset_t save;
-	int err, ret;
+	int error, err, ret;
 
+	error = PT_REGS_SYSCALL_RET(&current->thread.regs);
 	ret = 0;
 	switch(error){
 	case -ERESTARTNOHAND:
@@ -131,7 +132,6 @@ static int kern_do_signal(struct pt_regs
 {
 	siginfo_t info;
 	struct k_sigaction *ka;
-	int err;
 
 	if (!oldset)
 		oldset = &current->blocked;
_

--Boundary-00=_fyZSC+DDrpOZZ3i
Content-Type: text/x-diff; charset="us-ascii"; name="syscall-security-7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syscall-security-7.patch"


Fails when running "while /bin/true; do /bin/true; done".

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 um-linux-2.4.27-paolo/arch/um/kernel/signal_kern.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff -puN arch/um/kernel/signal_kern.c~syscall-security-7 arch/um/kernel/signal_kern.c
--- um-linux-2.4.27/arch/um/kernel/signal_kern.c~syscall-security-7	2005-03-29 19:41:25.000000000 +0200
+++ um-linux-2.4.27-paolo/arch/um/kernel/signal_kern.c	2005-03-29 19:41:25.000000000 +0200
@@ -114,12 +114,8 @@ static int handle_signal(struct pt_regs 
 	else
 		err = setup_signal_stack_sc(sp, signr, (unsigned long) handler,
 					    restorer, regs, &save);
-	if(err) goto segv;
-
-	return(0);
- segv:
-	force_segv(signr);
-	return(1);
+	if(err)
+		force_segv(signr);
 }
 
 /*
@@ -229,8 +225,8 @@ static int kern_do_signal(struct pt_regs
 		}
 
 		/* Whee!  Actually deliver the signal.  */
-		err = handle_signal(regs, signr, ka, &info, oldset, error);
-		if(!err) return(1);
+		handle_signal(regs, signr, ka, &info, oldset);
+		return(1);
 	}
 
 	/* Did we come from a system call? */
_

--Boundary-00=_fyZSC+DDrpOZZ3i--




-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
