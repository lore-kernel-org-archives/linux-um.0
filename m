Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWz5s-0006GZ-5f
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 06:25:36 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AWz5r-0001wc-Ci
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 06:25:35 -0800
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.58.0312181253460.2378@earth>
Message-ID: <Pine.LNX.4.58.0312181514140.7622@earth>
References: <Pine.LNX.4.58.0312171735540.8123@earth>
 <20031217174901.GA6709@ccure.user-mode-linux.org> <Pine.LNX.4.58.0312171924290.12482@earth>
  <Pine.LNX.4.58.0312172249020.19508@earth>  <200312180146.hBI1k1kS008213@ccure.user-mode-linux.org>
 <Pine.LNX.4.58.0312181036220.31295@earth> <Pine.LNX.4.58.0312181122070.32554@earth>
 <Pine.LNX.4.58.0312181209230.1327@earth> <Pine.LNX.4.58.0312181253460.2378@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] [UML patch] fixes for !CONFIG_PROC_MM, 2.6.0
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 18 Dec 2003 15:24:52 +0100 (CET)
To: UML devel list <user-mode-linux-devel@lists.sourceforge.net>
Cc: Jeff Dike <jdike@addtoit.com>


the attached patch makes the combo 2.6.0 patch compile for the
!CONFIG_PROC_MM case. (necessary if forcing TT mode by disabling skas.)

This is also a small cleanup as it moves the architecture-independent
ptrace functions into the generic kernel/ptrace.c file.

i've also uploaded a new combo patch with the alignment fix plus these
changes included:

    redhat.com/~mingo/UML-patches/uml-combo-2.6.0-A2

	Ingo

--- linux/arch/i386/kernel/ptrace.c.orig	
+++ linux/arch/i386/kernel/ptrace.c	
@@ -521,12 +521,6 @@ asmlinkage int sys_ptrace(long request, 
 		break;
 	}
 
-	case PTRACE_SIGPENDING:
-		ret = copy_to_user((unsigned long *) data, 
-				   &child->pending.signal,
-				   sizeof(child->pending.signal));
-		break;
-
 	case PTRACE_LDT: {
 		struct ptrace_ldt ldt;
 
@@ -539,23 +533,6 @@ asmlinkage int sys_ptrace(long request, 
 		break;
 	}
 
-	case PTRACE_SWITCH_MM: {
-		struct mm_struct *old = child->mm;
-		struct mm_struct *new = proc_mm_get_mm(data);
-
-		if(IS_ERR(new)){
-			ret = PTR_ERR(new);
-			break;
-		}
-
-		atomic_inc(&new->mm_users);
-		child->mm = new;
-		child->active_mm = new;
-		mmput(old);
-		ret = 0;
-		break;
-	}
-
 	default:
 		ret = ptrace_request(child, request, addr, data);
 		break;
--- linux/kernel/ptrace.c.orig	
+++ linux/kernel/ptrace.c	
@@ -316,6 +316,32 @@ int ptrace_request(struct task_struct *c
 	case PTRACE_SETSIGINFO:
 		ret = ptrace_setsiginfo(child, (siginfo_t __user *) data);
 		break;
+	case PTRACE_SIGPENDING:
+		ret = copy_to_user((unsigned long *) data, 
+				   &child->pending.signal,
+				   sizeof(child->pending.signal));
+		break;
+
+#ifdef CONFIG_PROC_MM
+	case PTRACE_SWITCH_MM:
+	{
+		struct mm_struct *old = child->mm;
+		struct mm_struct *new = proc_mm_get_mm(data);
+
+		if (IS_ERR(new)) {
+			ret = PTR_ERR(new);
+			break;
+		}
+
+		atomic_inc(&new->mm_users);
+		child->mm = new;
+		child->active_mm = new;
+		mmput(old);
+		ret = 0;
+		break;
+	}
+#endif
+
 	default:
 		break;
 	}


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
