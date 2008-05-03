Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JsEfg-0008KM-NZ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 May 2008 03:08:48 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user46158)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JsEff-0007VB-0R
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 May 2008 03:08:48 -0700
References: <87ve256146.fsf@hades.wkstn.nix> <871w4sqxgv.fsf@hades.wkstn.nix>
	<20080428164443.GB9628@c2.user-mode-linux.org>
	<871w4n9fo8.fsf@hades.wkstn.nix>
	<20080501151351.GA6303@c2.user-mode-linux.org>
	<87prs57g4h.fsf@hades.wkstn.nix>
	<20080502163020.GB7843@c2.user-mode-linux.org>
	<87bq3o5yeo.fsf@hades.wkstn.nix>
	<20080502195720.GB10369@c2.user-mode-linux.org>
	<87k5ic47is.fsf@hades.wkstn.nix>
	<20080503005631.GA12599@c2.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
Date: Sat, 03 May 2008 11:08:24 +0100
In-Reply-To: <20080503005631.GA12599@c2.user-mode-linux.org> (Jeff Dike's
	message of "Fri, 2 May 2008 20:56:31 -0400")
Message-ID: <877ieb4s4n.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] actually useful backtrace from a CPU-chewing hang
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
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

On 3 May 2008, Jeff Dike told this:
> On Sat, May 03, 2008 at 12:21:15AM +0100, Nix wrote:
>> With this patch (migrating most of the work into os_nsecs(), with a
>> non-NO_HZ version doing skew computations too, atop your first patch,
>> and making a couple of variables static for good measure), I still had
>> no luck:
>
>>From a quick look, this seems right.  And this would be the gold
> standard of preventing UML from seeing time going backwards.

Oh. And it still doesn't work. Damn.

>> So there's basically nothing unusual here. The first gettimeofday() call
>> after the jump, and *whoompf* we're off into the magic land of looping
>> with no extra syscalls to speak of at all.
>
> This was with a solid hang?  The thing is still handling page faults
> from something at the end of that trace.  I would try again, making
> sure it's a solid hang, and including enough of the trace so that you
> stop seeing page faults:
>      waitpid(9963, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}])
> and system calls (WSTOPSIG(s) == 133) and see what's happening at that
> point.

I gave it thirty seconds after the time change. After that
gettimeofday() there is *nothing* (which is unsurprising; the kernel
thread is stuck in a tight loop trying to decrement 2^64 down to 0 by
repeated subtraction... there's not much time for syscalls there.)

> And if you never stop seeing page faults or system calls, then that's
> interesting too.

Howzabout if we never see any after that gettimeofday()? :/

-- 
`If you are having a "ua luea luea le ua le" kind of day, I can only
 assume that you are doing no work due [to] incapacitating nausea caused 
 by numerous lazy demons.' --- Frossie

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
