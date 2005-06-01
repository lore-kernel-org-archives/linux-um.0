Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DdWPT-0000Uo-Me	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Jun 2005 09:49:39 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DdWPO-0007Iw-UN	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Jun 2005 09:49:39 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] panic on shutdown bt for 2.4.26+ UML
References: <4291FF1D.70505@enterasys.com>
In-Reply-To: <4291FF1D.70505@enterasys.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200506011851.18754.blaisorblade@yahoo.it>
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
Date: Wed, 1 Jun 2005 18:51:18 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "D. Bahi" <dbahi@enterasys.com>

On Monday 23 May 2005 18:04, D. Bahi wrote:
> any hints for where to look for a fix for this odd crash on shutdown?
On shutdown actually? Well, very strange.
> i must admit, lately, i've been rather frustrated with the lack of
> either maintainance or backporting in the 2.4 UML series.  of course
> this frustration is mostly because of my lack of ability to move forward
> past issues such as these. but also the UML web-site + blaise's + other
> patches out there along with all kinds of instructions on combinations
> on what to use....

> the mechanisims UML uses, jmps ptrace and the like, are not terribly
> familar to generic programmers. Is there a UML: How it Works for
> Developers - document somewhere?
Not a lot, sadly.

are you seeing this frequently? Have you updated to any 2.4.27 patch? There is 
IIRC a context switching bug fixed in them... On 2.6 there is a recent 
context switching fix from Bodo Stroesser (after 2.6.11) which I might look 
for...
> or must we be so dedicated that we 
> browse the mailing list archives and look for explainations piecemeal as
> responses to queries (as we've seen recently on the list)?

> appoligies for any toes i'm stepping on here - i want to help - i just
> need help to get there...
Probably the simplest way is to say what regressions currently has UML/2.6, or 
the reasons you don't use it, so that we can help fixing it.

> (gdb) bt
> #0  0x08161351 in kill ()
> #1  0x0817d662 in raise ()
> #2  0x0816163d in abort ()
> #3  0x080dac3e in panic_coreonpanic (self=0x81fec3c, unused1=0,
> unused2=0x8216d60) at um_arch.c:425
> #4  0x0805e46a in notifier_call_chain (n=0x0, val=0, v=0x8216d60) at
> sys.c:148

> #5  0x080533d9 in panic (fmt=0x81d1780 "switch_mm_skas -
> PTRACE_SWITCH_MM failed, errno = %d\n") at panic.c:77
This is very strange... can you go to that stack frame and print local vars 
together with a listing of /proc/<UMLPID>/fd? I suspect a EBADF here...

> #6  0x080dbf5a in switch_mm_skas (mm_fd=107) at process.c:353
> #7  0x08050b17 in schedule () at mmu_context.h:29
> #8  0x080d6d6e in cpu_idle () at process_kern.c:206
> #9  0x0805047a in rest_init () at init/main.c:353
> #10 0x080494e6 in start_kernel () at init/main.c:447
> #11 0x080dc437 in start_kernel_proc (unused=0x0) at process_kern.c:179
> #12 0x080d6979 in run_kernel_thread (fn=0x80dc410 <start_kernel_proc>,
> arg=0x0, jmp_ptr=0x81fec3c) at process.c:231
> #13 0x080dc162 in new_thread_handler (sig=10) at process_kern.c:72
> #14 <signal handler called>
> #15 0x08161351 in kill ()
> #16 0x08160fe5 in siglongjmp ()
> #17 0x080dbdc1 in start_idle_thread (stack=0x81f0000,
> switch_buf_ptr=0x81f0578, fork_buf_ptr=0x0) at process.c:303
> #18 0x080dc48a in start_uml_skas () at process_kern.c:193
> #19 0x080daae3 in linux_main (argc=19, argv=0x30000000) at um_arch.c:393
> #20 0x08050286 in main (argc=19, argv=0xbfffd0b4, envp=0xbfffd104) at
> arch/um/main.c:149
> #21 0x08160d13 in __libc_start_main ()
>
> --
> db

-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
