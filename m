Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H9GjP-0000kV-BT for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 00:10:15 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H9GjN-0001lP-Mm
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 00:10:15 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 23 Jan 2007 09:09:57 +0100
References: <200701171715.35504.blaisorblade@yahoo.it>
	<200701200018.30165.blaisorblade@yahoo.it>
	<20070122205945.GB5203@ccure.user-mode-linux.org>
In-Reply-To: <20070122205945.GB5203@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701230909.57513.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML/64bit is miscompiled by gcc 4.0.3 on Ubuntu
	6.06 LTS
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 22 January 2007 21:59, Jeff Dike wrote:
> On Sat, Jan 20, 2007 at 12:18:30AM +0100, Blaisorblade wrote:
> > Ok, I hope I remembered correctly how to debug such faults (I'm posting
> > the full procedure so you can give a look)
>
> Correct.
>
> > 0x00000000619a592f:     mov    %edx,%fs:(%rcx)  #faulting instruction.
>
> This and the registers involved are usually all you need.
>
> > RCX there is (long)regs->skas.regs[11] = -64, and for FS, since HOST_FS =
> > 25, I get:
> >
> > print/x regs->skas.regs[25]
> > $45 = 0x63
Since include/asm-x86_64/segment.h has:
#define FS_TLS_SEL ((GDT_ENTRY_TLS_MIN+FS_TLS)*8 + 3)
(which gives 0x63), this is the default value, ok.

> The presence of %fs in the instruction immediately suggests a TLS problem.
Yes, but the problem depends on miscompilation of UML (or rather, on using a 
different compiler), and arch_prctl_skas does not do a lot of work on x86_64 
(for what I can see). I'm astonished by the fact that less users complain 
about TLS on amd64 than on x86 (there are much less users, ok, but the 
difference is too high).

> Also, the trap number in cases like this should be 13, rather than the
> 14 you get with a normal page fault.

I remember that I saw 14 there, indeed. And indeed, it is so. See below:

(gdb) print regs->skas
$5 = {regs = {1, 547608288328, 547608288344, 4294967295, 547608288096, 
1077341640, 514, 0, 3399988123389603631, 18374403900871474943, 
18446744073709551614, 18446744073709551552, 2,
    0, 1076283584, 18446744073709551615, 1078130991, 51, 66067, 547608288008, 
43, 0, 0, 0, 0, 99, 0}, fp = {895, 0, 0, 281470681751424, 0 <repeats 60 
times>, 140733672859384},
  faultinfo = {error_code = 6, cr2 = 1613887512, trap_no = 14}, syscall = -1, 
is_user = 1}
(gdb) print/x regs->skas
$7 = {regs = {0x1, 0x7f7fff5c48, 0x7f7fff5c58, 0xffffffff, 0x7f7fff5b60, 
0x4036edc8, 0x202, 0x0, 0x2f2f2f2f2f2f2f2f, 0xfefefefefefefeff, 
0xfffffffffffffffe, 0xffffffffffffffc0,
    0x2, 0x0, 0x4026c8c0, 0xffffffffffffffff, 0x4042f92f, 0x33, 0x10213, 
0x7f7fff5b08, 0x2b, 0x0, 0x0, 0x0, 0x0, 0x63, 0x0}, fp = {0x37f, 0x0, 0x0, 
0xffff00001f80,
    0x0 <repeats 60 times>, 0x7fff1c9426f8}, faultinfo = {error_code = 0x6, 
cr2 = 0x6031f818, trap_no = 0xe}, syscall = 0xffffffffffffffff, is_user = 
0x1}

Then, new things:
(gdb) print $rsp
$9 = (void *) 0x60a23da0

> %fs isn't 0, so that's one thing that's not wrong.  What's in the
> corresponding segment?

regs[FS_BASE,GS_BASE] are both 0.
Instead, from strace I can see that
brk(0)                                  = 0x6031f000
brk(0x6031f880)                         = 0x6031f880
arch_prctl(ARCH_SET_FS, 0x6031f858)     = 0
is called at UML boot, very early, by glibc.

All of 4 runs have the same address in this call (no randomization on this? 
Strange!).

On the working binary, instead, this is what I get:
brk(0)                                  = 0x6031b000
brk(0x6031b880)                         = 0x6031b880 # malloc?
arch_prctl(ARCH_SET_FS, 0x6031b858)     = 0 #use the result, with some offset.

I do not think the exact address makes a difference (it will likely depend on 
the binary size).

I'll give a better look at some later time. Bye!
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
