Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzN5L-0000h0-4P for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:51:27 -0800
Received: from wproxy.gmail.com ([64.233.184.200])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EzN5I-0006VS-Rk
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:51:27 -0800
Received: by wproxy.gmail.com with SMTP id i12so72838wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 18 Jan 2006 15:51:20 -0800 (PST)
Message-ID: <43CED4AE.4020101@gmail.com>
From: Jacob Bachmeyer <jcb62281@gmail.com>
Reply-To: user-mode-linux-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [uml-devel] SKAS4 design question
References: <43CBF532.8020103@gmail.com>
	<200601181258.34474.blaisorblade@yahoo.it>
In-Reply-To: <200601181258.34474.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 18 Jan 2006 17:52:14 -0600
To: user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:

>On Monday 16 January 2006 20:34, Jacob Bachmeyer wrote:

>>Has any thought been given to making SKAS4 suitably generic that it
>>could be used for more than just UML?

>Not yet, thoughts welcome.

Let's see:

to support HURD (which uses the Mach ABI):

    -- existing facilities plus trap lcall gates

to support WINE (which follows Win32 conventions (ick!)): (x86 only)

    --existing facilities plus
     -- trap on access to specified pages

        Explanation:  Win32 API calls are not syscalls in the normal 
sense--rather they are made by calling into a system DLL.  These DLLs 
are mapped into the process' address space on Windows and under current 
WINE, much like shared objects in normal Linux.  This idea would enable 
WINE to not actually map these DLLs, but rather simply set the pages 
where the DLLs would be mapped as "fasttrap".  Then, when the program 
attempts to access a DLL's memory image, the kernel would intercept the 
request and quickly pass it to a userspace thread, which handles the 
"page fault".  The page remains set as "fasttrap", and the control 
process modifies the address space and CPU context appropriately before 
allowing execution to continue.

     -- read/write in guest address space

        Explanation:  mmap is fine for big changes to an address space 
(such as loading modules), but one capability WINE would need for this 
to be truly useful is 1/2/4/8/16-byte PEEK and POKE.  (Some Win32 
programs like to do wierd things with Windows' system code--in 
conjunction with "fasttrap", this would allow WINE to keep such programs 
happy.)  As I understand, ptrace already provides this, hopefully 
adequetely.

     -- intercept arbitrary interrupts in guest address space

        Explanation:  Many older Windows programs (Win16 era) 
occasionally directly invoke various soft interrupts (these are 
basically DOS syscalls).  The ability to intercept these is necessary, 
but need not be particularly efficient or fast.

     -- modify guest address space's LDT

        Explanation:  Again, Win16 support.  Old Windows actually 
allowed processes to request segments for whatever purpose.  This may or 
may not be doable on all modern hardware.

     -- transparently use threads in guest address spaces, if desired

        Explanation:  WINE currently uses the host's scheduler. 
Changing it to this new API shouldn't adversely affect that ability. 
(And on second thought, using a UML library might not be an option.)

>>PS:  If I understand correctly, UML with the current SKAS3 works by
>>swapping processes into and out of a single "user" address space.

>>I 
>>propose a system where many distinct "user" address spaces are
>>maintained by the kernel and execution is placed whereever the user-mode
>>scheduler says.

>What you say is not clear, but the most obvious understanding of the above 
>sentence is that you propose what already happens.

>However, SKAS3 and current ideas for SKAS4, with different APIs but similar 
>semantics, say: implement all guest processes as user-level threads (totally 
>implemented within UML) with the exception that we allow different address 
>spaces.

>So we have "switch the guest proc to a different address 
>space" (PTRACE_SWITCH_MM, in arch/i386/kernel/ptrace.c), manipulate with 
>mmap/munmap/mprotect any of these address spaces, and destroy it (all in 
>mm/proc_mm.c).

I shall clarify my proposal:  each thread is assigned an address space, 
while an address space can contain multiple threads.  Each thread also 
has a STOP/RUN flag, which if set to RUN, causes the host scheduler to 
consider that thread for execution (along with all other runnable 
threads).  This flag allows either the userspace control process to make 
scheduling decisions itself, (by only setting one of its threads to RUN) 
or to punt and have the kernel handle all scheduling for its threads (by 
setting them all to RUN and using STOP only to block a thread).

Could all SKAS4 APIs be multiplexed through one syscall?  (Perhaps 
simply as more ptrace functions, or as a new "skas4" syscall?)




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
