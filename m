Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBR54-0008KO-2f for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 21:23:58 -0700
Message-ID: <4074D38D.10101@users.sourceforge.net>
From: kuas <ku4s@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Page frame access through from kernel thread
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
Date: Thu, 08 Apr 2004 00:22:37 -0400
To: user-mode-linux-devel@lists.sourceforge.net

Hello,

First of all, thanks for the information about UML system call mechanism 
previously. It gave me good information about UML. I am actually working 
on security project and using UML as the base. Right now, I am doing 
experiment with memory (paging mechanism) under UML. I am trying to scan 
all the fresh new pages as they are just being brought into the memory 
from a file.

I want to be able to handle pages brought in from any FS so that the 
solution is architectural independent. I am using guest kernel 2.4.22 
(skas mode). I think a good place to patch this is in memory.c since I 
can get back the newly brought in page and its pte entry.

static int do_no_page(struct mm_struct * mm, struct vm_area_struct * vma,
    unsigned long address, int write_access, pte_t *page_table)
{
    struct page * new_page;
    pte_t entry;
    :
    new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);
    :
    if (pte_none(*page_table)) {
          :
          entry = mk_pte(new_page, vma->vm_page_prot);
          :
    }
    :
}

That function calls nopage(), which returns the new_page struct and 
later I the pte_t "entry" is derived from that. I am confused of how can 
I know where the physical page frame is actually located so I can read 
to it from the kernel thread. Should I go deeper closer to the FS mechanism?

In the host linux, intel specification said pte consist of the base 
address of the page physical address (20 bits MSB) and page flags (12 
bits LSB). Is this the same in UML? I tried to see the "entry" value 
using GDB. The value is small, as an example: 0x05d80fb and it's always 
the same value as "address" (that passed in). Why? I think in a real 
system, address supposed to be offset to table PGD, PMD, and PTE. Is 
there any other conversion mechanism to get the "real" physhical address?

If the "entry" address is the physical address of the page frame, does 
that means the page frame already being transfered to user space 
address. I can't find where it was moved there and how can I access it? 
Am I stuck because the kernel space is running on different process from 
the client?

Sorry for the long questions. I thought I understood the concept of 
Linux MM, however UML might have slightly different mechanism to handle 
its page.

Thanks in advance for any info and comments.

Kuas.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
