Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVCfn-00007e-Pv	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 11:08:07 -0700
Received: from mailhost.cs.man.ac.uk ([130.88.192.14])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DVCfm-0003af-9T	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 11:08:07 -0700
Message-ID: <427FA768.6030409@manchester.ac.uk>
From: Ian Rogers <ian.rogers@manchester.ac.uk>
MIME-Version: 1.0
Subject: Re: [uml-devel] Using SKAS, any examples?
References: <427895BC.2050201@manchester.ac.uk>
	<200505081902.25146.blaisorblade@yahoo.it> <427E55E6.2000503@manchester.ac.uk>
	<200505091708.30730.blaisorblade@yahoo.it>
In-Reply-To: <200505091708.30730.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Mon, 09 May 2005 19:09:44 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Hi,

Thanks for the help and I'm feeling encouraged again to try this through 
skas. I still have some thoughts though.

>>I hope to look into creating a patch to allow multiple segments in a
>>linux process. So an extension to skas on i386 and I can get my %fs wish
>>:-)
>>    
>>
>Well, it should be already doable in SKAS, with PTRACE_LDT (which relates to 
>modify_ldt() the same way that writing DO_MMAP relates to mmap()). Then, 
>after *setting* an appropriate descriptor in %fs (with PTRACE_POKEUSR if you 
>need), you're done.
>  
>
The LDT will give me a base address for the linear address used by the 
user process (I imagine this will be 0), but it won't do anything about 
the page table set up. I believe, the process may not work as the linear 
address can only be 32-bit. I thought there were extensions around this 
but it seems not. What I'd like would look like "Figure 3-28. Memory 
Management Convention That Assigns a Page Table
to Each Segment" in **"IA-32 Intel Architecture Software Developer's 
Manual, Volume 3: System Programming Guide". I think on a 32-bit machine 
to access multiple 4GB segments isn't possible, CR3 (PDBR) is shared by 
all segments and so the PDE's must just carve up the 4GB linear address 
space. It would be nice if CR3 (PDBR) were part of the selector. I could 
have more success on a 64bit machine...**

>Well, I've proposed some time ago to use segmentation for UML, but the 
>proposal was dropped "because an access through segmentation is a little 
>slower".
>
>Quite frankly, I'm quite unconvinced (because any access passes through 
>segmentation, even if normally segments have a 0 base and a disabled limit); 
>beyond, Xen uses segmentation in the same way that I was proposing for UML, 
>IIRC.
>  
>
I agree. The mechanism can be tested out and then reverted if it is 
hurting performance. Thanks again for the help and examples,

Ian Rogers


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
