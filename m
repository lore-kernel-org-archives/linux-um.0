Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtuUN-0006lt-Tx for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Jan 2005 13:14:11 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CtuUM-0000W1-Ci for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Jan 2005 13:14:11 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <41F7C963.9080704@fujitsu-siemens.com>
In-Reply-To: <41F7C963.9080704@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200501262213.32396.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: UML running on a SMP host: bug in SKAS3 patch
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
Date: Wed, 26 Jan 2005 22:13:32 +0100
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>, Gerd Knorr <kraxel@bytesex.org>

For me it's perfectly ok... I don't remember the exact traces, but some 
sporadical SKAS-related Oops were reported... in no case they were repeatable 
(since -V1 at least), so they were likely very thin races conditions.

I'm going to merge also the patches for PTRACE_SYSEMU_SINGLESTEP in SKAS, 
since I'm now at releasing SKAS updates.

I'm also going to add this patch, which fixes another potential problem:

diff -puN arch/i386/kernel/ptrace.c~skas-add-wmb-for-mm-switch 
arch/i386/kernel/ptrace.c
--- vanilla-linux-2.6.9/arch/i386/kernel/ptrace.c~skas-add-wmb-for-mm-switch    
2005-01-26 20:12:14.233441416 +0100
+++ vanilla-linux-2.6.9-paolo/arch/i386/kernel/ptrace.c 2005-01-26 
20:28:00.902525840 +0100
@@ -570,8 +570,10 @@ asmlinkage int sys_ptrace(long request,
                }

                atomic_inc(&new->mm_users);
+               task_lock(child);
                child->mm = new;
                child->active_mm = new;
+               task_unlock(child);
                mmput(old);
                ret = 0;
                break;

/*
 * Protects ->fs, ->files, ->mm, ->ptrace, ->group_info, ->comm and
 * synchronises with wait4().
 *
 * Nests both inside and outside of read_lock(&tasklist_lock).
 * It must not be nested with write_lock_irq(&tasklist_lock),
 * neither inside nor outside.
 */
static inline void task_lock(struct task_struct *p)
{
        spin_lock(&p->alloc_lock);
}

The release will wait at least a couple of days, since I'm adding all this 
stuff... especially, since there is a lock addition, I'd like at least one 
positive report from one SMP user before *officially* releasing.

I've not seen any update to them from their original version (i.e. when they 
were first discussed). Is this correct?

And my doubts about their technical merit were totally wrong. I simply was 
missing that SYSEMU stands to SYSEMU_SINGLESTEP as SYSCALL stands on 
SINGLESTEP (in correct, >=2.6.9 kernels), while I thought SYSEMU_SINGLESTEP 
was equal to the correct SINGLESTEP (I was maybe misguided by the "using it 
to check the host kernel correctness" hack we need to use).

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
