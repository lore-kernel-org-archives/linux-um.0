Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkTnF-0000Fb-J1	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 14:26:57 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DkTnB-0001ds-0n	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 14:26:57 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Recent patches of note
References: <s2b19c99.097@ORANGE.OUS.EDU>
	<20050620145320.GB5530@ccure.user-mode-linux.org>
	<Pine.LNX.4.63.0506201233410.7343@sparrow>
In-Reply-To: <Pine.LNX.4.63.0506201233410.7343@sparrow>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506202331.26053.blaisorblade@yahoo.it>
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
Date: Mon, 20 Jun 2005 23:31:24 +0200
To: user-mode-linux-devel@lists.sourceforge.net, William Stearns <wstearns@pobox.com>
Cc: Jeff Dike <jdike@addtoit.com>, Anthony Brock <Anthony_Brock@ous.edu>

On Monday 20 June 2005 19:59, William Stearns wrote:
> Good afternoon, all,
>
> On Mon, 20 Jun 2005, Jeff Dike wrote:
> > On Thu, Jun 16, 2005 at 03:36:24PM -0700, Anthony Brock wrote:
> >> Second, I'm once again enountering problems with launch the UML
> >> instance. It likes to hang at:
> >>
> >>
> >> Checking that ptrace can change system call numbers...OK
> >> Checking syscall emulation patch for ptrace...OK
> >> Checking advanced syscall emulation patch for ptrace...OK
> >> Checking if syscall restart handling in host can be skipped...OK
> >> Checking for the skas3 patch in the host:
> >>   - /proc/mm...found
> >>   - PTRACE_FAULTINFO...found
> >>   - PTRACE_LDT...found
> >> Checking PROT_EXEC mmap in /tmp...OK
> >
> > I remembered what this was about.  Disable CONFIG_I8042, under -
> > 	UML-specific options
> > 	Input device support
> > 	Hardware I/O ports
> > 	i8042 PC Keyboard controller
> >
> > This is a UML bug which I haven't tracked down yet.
>
>  	Just for reference, that's CONFIG_SERIO_I8042 on 2.6 kernels.
>  	I disabled that on the kernel that was giving me the same hang
> point on x86_64 and....  same hang.  I turned off all the other hardware
> options in that menu (serial port, game port) and.... hmmm.  A kernel that
> was at least successfully building before is now:
>
>    CC      arch/um/sys-x86_64/signal.o
> arch/um/sys-x86_64/signal.c: In function 'setup_signal_stack_si':
> arch/um/sys-x86_64/signal.c:171: error: invalid lvalue in assignment
> make[1]: *** [arch/um/sys-x86_64/signal.o] Error 1
> make: *** [arch/um/sys-x86_64] Error 2
>
>  	The line in question is the ((unsigned char... :

That's a removed extension with GCC 4, so upgrading to FC4 is exactly the 
reason...

Replace the offending line with

frame -= 128 / sizeof(*frame);

And it should compile. In which case, Jeff may like a patch (or at least an 
ACK to do it himself).

>          frame = (struct rt_sigframe __user *)
>                  round_down(stack_top - sizeof(struct rt_sigframe), 16) -
> 8; ((unsigned char *) frame) -= 128;
>
>          if (!access_ok(VERIFY_WRITE, fp, sizeof(struct _fpstate)))
>                  goto out;

>  	I'm reasonably sure this showed up because I upgraded to fc4 at
> the end of last week - sorry about that.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
