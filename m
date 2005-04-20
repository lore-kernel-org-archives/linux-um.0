Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DO4N4-0007u0-0L for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Apr 2005 18:51:18 -0700
Received: from zproxy.gmail.com ([64.233.162.192])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DO4N2-0003th-I6 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Apr 2005 18:51:17 -0700
Received: by zproxy.gmail.com with SMTP id 16so31744nzp
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 19 Apr 2005 18:51:10 -0700 (PDT)
Message-ID: <cbec11ac0504191851267763d8@mail.gmail.com>
From: Ian McDonald <imcdnzl@gmail.com>
Reply-To: Ian McDonald <imcdnzl@gmail.com>
Subject: Re: [uml-devel] Problems with UML on Debian Sarge 64 host
In-Reply-To: <200504191805.35299.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
References: <cbec11ac0504132125779afc07@mail.gmail.com>
	<200504142307.11927.blaisorblade@yahoo.it>
	<cbec11ac0504142156705d0113@mail.gmail.com>
	<200504191805.35299.blaisorblade@yahoo.it>
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
Date: Wed, 20 Apr 2005 13:51:10 +1200
Content-Transfer-Encoding: 8bit
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> Comments inline
> >
> > On 15/04/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> > > On Thursday 14 April 2005 06:25, Ian McDonald wrote:
> > > > Hi there,
> 
> > > > The problem is that my bootup dies very early on and this is the total
> > > > output: Checking for /proc/mm...not found
> > > > Checking PROT_EXEC mmap in /tmp...OK
> > > > tracing thread pid = 20981
> > > > OP_FORK failed to attach pid
> 
> > > > I suspect that this is something to do with my mixed 32/64 bit
> > > > environment but I am not sure... Can anybody shed some light on this?
> > >
> > > I've seen that *sometimes* too on 64-bit envs., tried doing a "setarch
> > > i386 linux" or something like that, to force a 32-bit emulation?
> 
> > setarch isn't on this machine and I can't find the equivalent command for
> > sarge.
> Tried installing the needed package? On SUSE it's called "linux32".

The debian implementation has a 32 bit user space but it is picking up
64 bit for UML but just override with SUBARCH=i386.

I don't have root access to this box.

Interestingly enough it has now started working apart from some COW
backing store issues which I have to get the system administrator to
fix. I changed nothing but notice that the host kernel has changed
from 2.6.8 to 2.6.11.7 so something in host kernel may well have fixed
my issue! (which I have no control over).

> 
> Also, tried compiling UML itself on a real 32-bit box (with static linking,
> obviously)?
> 
Yes - work.

> > > Tried disabling the ptrace proxy in compilation, as the first thing?
> 
> > Tried that and no difference. Note that 2.6.11.x with bs4 doesn't
> > compile with this option showing unless you set FRAME_POINTER to n.
> > You get an error such as:
> 
> > kernel/built-in.o(.text+0x83f4): In function `profile_tick':
> > kernel/profile.c:387: undefined reference to `profile_pc'
> Hmm, interesting... However, the more likely culprit is CONFIG_SMP:

Tried it with CONFIG_SMP off and it resolved the issue.
> 
> include/asm-i386/ptrace.h
> 
> #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
> extern unsigned long profile_pc(struct pt_regs *regs);
> #else
> #define profile_pc(regs) instruction_pointer(regs)
> #endif
> instruction_pointer is defined, profile_pc is not.
> 
> > The only way I could find to set this option to n was hacking the
> > autoconf.h file...
> Disable CONFIG_DEBUG_INFO and FRAME_POINTER should become 'n'.
> 
> > So still no 32 bit UML... will try 64 bit (once I get access to the 64
> > bit compiler) and see if I can get that to work....
> Let me recall: you *did* succeed on your older fully-32bit Debian Woody
> system, right? Or did I leave something unfixed behind?

Yes I did succeed on my 32 bit Woody but that machine is being turned
off in next couple of weeks :-(

The UML appears now to be working (once I can do more tests) on 64 bit
once host kernel was upgraded to 2.6.11.7 (guess is 2.6.11.4+bs4 32
bit).

Thanks for your help. Unfortunately I don't have much time to help
write patches at present or too many tests as my UML testing has
slowed down my project and I have acquired two dedicated machines to
help me out... I will certainly try to help though whenever I get
bored (which is quite often!)

Regards,

Ian


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
