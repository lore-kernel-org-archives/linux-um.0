Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AOr1f-0005m6-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Tue, 25 Nov 2003 20:11:39 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AOr1e-0000Gr-Cu
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 25 Nov 2003 20:11:38 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] iptables-restore randomly crashes under UML
In-Reply-To: <Pine.LNX.4.44.0311260212420.1800-100000@filer.marasystems.com>
Message-ID: <Pine.LNX.4.44.0311260427150.6942-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 26 Nov 2003 05:11:31 +0100 (CET)
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Wed, 26 Nov 2003, Henrik Nordstrom wrote:

> What I suspect is that the kernel virtual memory area gets remapped
> somehow causing it to suddenly point to another "physical" memory area,
> and due to the repetive nature of my tests the contents of this other
> memory usually looks similar but not identical to the correct data.

Have been digging a little and indeed the problem is in this area.

The corruption always occurs when the memset of the next vmalloc() area
executes, triggering a 
segv()->...->flush_tlb_kernel_vm_tt()->flush_kernel_vm_range() call
sequence to set up the VM map of that other area..

Below can be seen a trace of what happens in flush_tlb_kernel_vm_range()  
when the relevant address is reached and gets corrupted. $addr is a
pointer to the memory area that gets corrupted:

97              for(addr = start; addr < end;){
1: $addr = 0xa2811040 ""
(gdb) p/x addr
$7 = 0xa2811000
(gdb) n
98                      pgd = pgd_offset(mm, addr);
1: $addr = 0xa2811040 ""
(gdb) 
100                     if(pmd_present(*pmd)){
1: $addr = 0xa2811040 ""
(gdb) 
101                             pte = pte_offset(pmd, addr);
1: $addr = 0xa2811040 ""
(gdb) 
102                             if(!pte_present(*pte) || 
pte_newpage(*pte)){
1: $addr = 0xa2811040 ""
(gdb) 
104                                     err = os_unmap_memory((void *) 
addr, 
1: $addr = 0xa2811040 ""
(gdb) 
106                                     if(err < 0)
1: $addr = 0xa2811040 <Address 0xa2811040 out of bounds>
(gdb) 
103                                     updated = 1;
1: $addr = 0xa2811040 <Address 0xa2811040 out of bounds>
(gdb) 
106                                     if(err < 0)
1: $addr = 0xa2811040 <Address 0xa2811040 out of bounds>
(gdb) 
109                                     if(pte_present(*pte))
1: $addr = 0xa2811040 <Address 0xa2811040 out of bounds>
(gdb) 
110                                             map_memory(addr, 
1: $addr = 0xa2811040 <Address 0xa2811040 out of bounds>
(gdb) 
113                             }
1: $addr = 0xa2811040 "p"
(gdb) 
117                             }
1: $addr = 0xa2811040 "p"
(gdb) 
118                             addr += PAGE_SIZE;


Here it can be clearly seen that the page for some reason gets remapped.

Note that the corrupted area was allocated earlier using vmalloc() and has 
already been mapped and filled with content by copy_from_user(). The call 
to flush_tlb_kernel_vm_tt() is due to a write to another vmalloc() 
allocated area allocated just after the corrupted area.

So a number of questions arises here

a) Why the heck does it unmap the already mapped and used pages? This page
was mapped earlier on write fault by copy_from_user() and has not been
freed yet.

b) What is the content it gets mapped to?

c) Why does it only fail some times and not always.. I guess it often 
just happens to remap the page to the same backing location.


Full code listing of the failing section of flush_tlb_kernel_vm_range():

98                      pgd = pgd_offset(mm, addr);
99                      pmd = pmd_offset(pgd, addr);
100                     if(pmd_present(*pmd)){
101                             pte = pte_offset(pmd, addr);
102                             if(!pte_present(*pte) || pte_newpage(*pte)){
103                                     updated = 1;
104                                     err = os_unmap_memory((void *) addr, 
105                                                           PAGE_SIZE);
106                                     if(err < 0)
107                                             panic("munmap failed, errno = %d\n",
108                                                   -err);
109                                     if(pte_present(*pte))
110                                             map_memory(addr, 
111                                                        pte_val(*pte) & PAGE_MASK,
112                                                        PAGE_SIZE, 1, 1, 1);
113                             }
114                             else if(pte_newprot(*pte)){
115                                     updated = 1;
116                                     protect_memory(addr, PAGE_SIZE, 1, 1, 1, 1);
117                             }
118                             addr += PAGE_SIZE;
119                     }
120                     else {
121                             if(pmd_newpage(*pmd)){
122                                     updated = 1;
123                                     err = os_unmap_memory((void *) addr, PMD_SIZE);
124                                     if(err < 0)
125                                             panic("munmap failed, errno = %d\n",
126                                                   -err);
127                             }
128                             addr += PMD_SIZE;
129                     }



I can only assume the problem is that pte_newpage() still is true for the 
page in question.


The skas code looks identical so probably the same problem is found there.


What is responsible for marking the kernel vm pages as up to date? 
Shouldn't there be pte_mkuptodate/pmd_mkuptodate() calls just like there 
is in the same loop of fix_range()?


Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
