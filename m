Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPNrt-0001yc-Ef for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 08:20:17 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CPNrs-0006f6-LT for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 08:20:17 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
References: <200410221929.07592.blaisorblade_spam@yahoo.it>
	<6343.1099436425@marajade.sandelman.ottawa.on.ca>
In-Reply-To: <6343.1099436425@marajade.sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uTQiBVeM8p4Iz5k"
Message-Id: <200411031718.54774.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] mm->dumpable issue (was: Re: /proc/mm patches)
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
Date: Wed, 3 Nov 2004 17:18:54 +0100
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_uTQiBVeM8p4Iz5k
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 03 November 2004 00:00, Michael Richardson wrote:
> Is there a final patch that you think might work, and deal with the
> mm->dumpable flag issue?

> I was all set to test the previous patch, but then you said not to...
On top of -V7 you can apply the attached patch. I'm almost sure it works. The 
problem is that I have not the certainty that it is not exploitable, i.e. it 
can be used to gain access to root privileges. I am almost sure it is not... 
but please *avoid* using a setuid UML binary with this patch (it is not a 
good idea, anyway, but it is even worse with this patch. I believe that to 
exploit it, if at all possible, having a setuid binary which is coded to use 
SKAS (either UML or a malicious program).

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_uTQiBVeM8p4Iz5k
Content-Type: text/x-diff; charset="iso-8859-1";
	name="fix-dumpable-handling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix-dumpable-handling.patch"


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>, Henrik Nordstrom <uml@hno.marasystems.com>, Michael Richardson <mcr@sandelman.ottawa.on.ca>

When a child mm is created by opening /proc/mm, without this patch its
mm->dumpable flag is left set to 0, even when there is no reason to do so.

This way, for instance, if <pid> is the pid of a userspace thread,
/proc/<pid> is only readable by root (which was the original reason letting
this be diagnosed by Michael Richardson).

Paolo and Henrik discussed about this in detail, finally Paolo wrote the patch
and sent it for comment.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/i386/kernel/ptrace.c |    8 ++++++++
 vanilla-linux-2.6.9-paolo/mm/proc_mm.c              |    2 ++
 2 files changed, 10 insertions(+)

diff -puN mm/proc_mm.c~fix-dumpable-handling mm/proc_mm.c
--- vanilla-linux-2.6.9/mm/proc_mm.c~fix-dumpable-handling	2004-10-26 00:54:35.478864480 +0200
+++ vanilla-linux-2.6.9-paolo/mm/proc_mm.c	2004-10-26 00:54:35.482863872 +0200
@@ -126,6 +126,8 @@ static int open_proc_mm(struct inode *in
 
 	init_new_empty_context(mm);
 	arch_pick_mmap_layout(mm);
+	mm->dumpable = current->mm->dumpable;
+	wmb();
 
 	spin_lock(&mmlist_lock);
 	list_add(&mm->mmlist, &current->mm->mmlist);
diff -puN arch/i386/kernel/ptrace.c~fix-dumpable-handling arch/i386/kernel/ptrace.c
--- vanilla-linux-2.6.9/arch/i386/kernel/ptrace.c~fix-dumpable-handling	2004-10-26 00:54:35.480864176 +0200
+++ vanilla-linux-2.6.9-paolo/arch/i386/kernel/ptrace.c	2004-10-26 00:54:35.483863720 +0200
@@ -568,6 +568,14 @@ asmlinkage int sys_ptrace(long request, 
 			break;
 		}
 
+		/* Let's be safe. If we are ptraced from a non-dumpable process,
+		 * let's not be dumpable. Don't try to be smart and turn
+		 * current->dumpable to 1: it may be unsafe.*/
+		if (!current->dumpable) {
+			new->dumpable = 0;
+			wmb();
+		}
+
 		atomic_inc(&new->mm_users);
 		child->mm = new;
 		child->active_mm = new;
_

--Boundary-00=_uTQiBVeM8p4Iz5k--



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
