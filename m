Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdvpH-0007pv-J4 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 10:21:11 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AdvpH-0001Cx-11 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 10:21:11 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401061921.00054.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] 2.6-specific UML patches (modules, modversions,
	various other stuff)
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
Date: Tue, 6 Jan 2004 19:20:59 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi! I'm happy to hear again from you.

I don't remember if you answered when I posted this URL:
http://web.tiscali.it/no-redirect-tiscali/blaisorblade/

There you will find a number of patches for UML 2.6. Some are mine and some 
come from Ingo and M A Young; I've included everything Ingo posted minus the 
speedup - breakage for 2.4 host. That is, MM_COPY_SEGMENTS is still called by 
UML but if the host is a 2.6 that is a no-op.

Only use the v8! In the Readme there is a careful description of each patch - 
ask for more comments if you need.

They are tested enough (at least for building UML; the resulting patch should 
work even on i386, and at least it compiles). Maybe you already have in your 
tree some of the patches; they apply onto vanilla linux kernel. The -test9 
patch has been split: the change for tty_init has been removed, and the 
change to mm/memory.c has been replaced. You can find the two patches to move 
out here, as A-03* and A-04*:

http://web.tiscali.it/no-redirect-tiscali/blaisorblade/linux/archives/UML/v6/A-Orig/

The replacements are in the B directory. About the A-04 patch, and this hunk 
in particular(it goes to mm/memory.c):

@@ -700,19 +719,8 @@

                vma = find_extend_vma(mm, start);

-#ifdef FIXADDR_USER_START
-               if (!vma &&
-                   start >= FIXADDR_USER_START && start < FIXADDR_USER_END) {
-                       static struct vm_area_struct fixmap_vma = {
-                               /* Catch users - if there are any valid
-                                  ones, we can make this be "&init_mm" or
-                                  something.  */
-                               .vm_mm = NULL,
-                               .vm_start = FIXADDR_USER_START,
-                               .vm_end = FIXADDR_USER_END,
-                               .vm_page_prot = PAGE_READONLY,
-                               .vm_flags = VM_READ | VM_EXEC,
-                       };
+#ifdef FIXADDR_START
+               if (!vma && start >= FIXADDR_START && start < FIXADDR_TOP) {
                        unsigned long pg = start & PAGE_MASK;
                        pgd_t *pgd;
                        pmd_t *pmd;
Did you have any reason for replacing FIXADDR_USER_START with FIXADDR_START?
I've looked in older patches and saw that FIXADDR_USER_START didn't exist, so 
I thought that you simply didn't see the change happened in mainline; even 
because I've maybe understood what code does, and there is no need to map 
anything in a process's address space except for the VSYSCALL page. Am I 
right?

I must admit that with my replacement for that patch, I've got one 
non-repeatable segfault, in the early boot process. I've never had it any 
more, so maybe it's elsewhere.

For the makefile patches, they haven't still been accepted by Kbuild 
developers :-(. But everything is open (kbuild mail list is not that active, 
actually...)

Bye
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
