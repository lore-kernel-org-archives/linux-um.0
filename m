Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19v605-0004qk-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 19:07:01 -0700
Received: from cislunar.terraluna.org ([64.71.149.1] helo=TerraLuna.Org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19v604-0005hr-Q6
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 19:07:00 -0700
Received: from stevegt by pathfinder with local (Exim 3.35 #1 (Debian))
	id 19v5zU-0000TQ-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 19:06:24 -0700
Message-ID: <20030905020623.GA1601@pathfinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: stevegt@TerraLuna.Org
Subject: [uml-devel] SKAS: Why pass mm vs. current?
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 4 Sep 2003 19:06:23 -0700
To: user-mode-linux-devel@lists.sourceforge.net

Hi All & Jeff,

I'm working on a modified SKAS patch to allow running SKAS mode guests
on openMosix hosts (don't get excited -- no guest process migration,
just SKAS).   I have a question about why the skas patch passes mm down
through the do_mmap* call tree.  Why not just use current->mm when
needed, the way the original kernel does?  Or, if there's a context
issue, then why not pass all of current as a task_struct pointer,
instead of just current->mm?  That would seem to be a lot more flexible.
I know I'm missing something, I'm just not sure what yet.

Here's why I ask -- the process of merging the openMosix and SKAS
patches looks relatively straightforward; these are the only overt
conflicts (openMosix is "-", SKAS is "+"):

____________________________________________________________________________
arch/i386/kernel/sys_i386.c.rej
____________________________________________________________________________
***************
*** 59,67 ****
                        goto out;
        }
  
-       down_write(&current->mm->mmap_sem);
-       error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-       up_write(&current->mm->mmap_sem);
  
        if (file)
                fput(file);
--- 59,67 ----
                        goto out;
        }
  
+       down_write(&mm->mmap_sem);
+       error = do_mmap_pgoff(mm, file, addr, len, prot, flags, pgoff);
+       up_write(&mm->mmap_sem);
  
        if (file)
                fput(file);
____________________________________________________________________________
mm/mmap.c.rej
____________________________________________________________________________
***************
*** 390,399 ****
        return 0;
  }
  
- unsigned long do_mmap_pgoff(struct file * file, unsigned long addr, unsigned long len,
-       unsigned long prot, unsigned long flags, unsigned long pgoff)
  {
-       struct mm_struct * mm = current->mm;
        struct vm_area_struct * vma, * prev;
        unsigned int vm_flags;
        int correct_wcount = 0;
--- 390,400 ----
        return 0;
  }
  
+ unsigned long do_mmap_pgoff(struct mm_struct *mm, struct file * file, 
+                           unsigned long addr, unsigned long len,
+                           unsigned long prot, unsigned long flags, 
+                           unsigned long pgoff)
  {
        struct vm_area_struct * vma, * prev;
        unsigned int vm_flags;
        int correct_wcount = 0;
____________________________________________________________________________


The less-overt conflict comes from the fact that SKAS assumes that mm is
passed down through the call tree, but openMosix assumes that current is
still correct down deeper, in do_mmap_pgoff and do_mmap_pgoff_down, and
it uses it.  Neither the original kernel nor SKAS use current that deep,
so the SKAS patch doesn't need it or pass it.  

In other words, SKAS only passes mm, but openMosix needs all of current.

The simple thing for me to do might be to pass current down through the
do_mmap* call tree, rather than mm, and get mm from that when needed.  I
just don't know whether that's necessary, or whether it might introduce
other problems, since I don't see why mm was passed in the first place.
Can anyone tell me what I'm missing?

Steve
-- 
Stephen G. Traugott  (KG6HDQ)
UNIX/Linux Infrastructure Architect, TerraLuna Aerospace LLC
stevegt@TerraLuna.Org 
http://www.stevegt.com -- http://Infrastructures.Org 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
