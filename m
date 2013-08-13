Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1V9CAv-0006El-6f
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Aug 2013 10:50:05 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V9CAt-0004WD-8P
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Aug 2013 10:50:05 +0000
Message-ID: <520A0F35.8000905@nod.at>
Date: Tue, 13 Aug 2013 12:49:25 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <20130811174831.GD10864@redhat.com>
	<CAFLxGvxsdsjJ9LZs4-NFpGYYvRbEQ_YK2D=5W1S6uGCaWcgzSw@mail.gmail.com>
	<CAFLxGvz-PVQvKcs8cKZ8bpEfRj6Hw5h4-qNYrSRSq5Ga1axRvw@mail.gmail.com>
	<20130812085300.GV5918@redhat.com>
	<20130813103603.GA27173@redhat.com>
In-Reply-To: <20130813103603.GA27173@redhat.com>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] How to reliably kill all vmlinux processes for a
 single VM?
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Am 13.08.2013 12:36, schrieb Richard W.M. Jones:
> On Mon, Aug 12, 2013 at 09:53:00AM +0100, Richard W.M. Jones wrote:
>> On Mon, Aug 12, 2013 at 10:15:24AM +0200, richard -rw- weinberger wrote:
>>> Found the root cause, patch is on the way.
>>
>> I can test patches if you CC me on them.
> 
> I'm still available to test patches :-)  Didn't see anything on
> this list nor on LKML.

I'm currently on the road...

> In particular I'm having a problem where it looks as if vmlinux is
> sending a signal to its parent process on shutdown.
>

Really?
If so, why does it not kill my shell if I run it directly?

Thanks,
//richard

> I can reliably reproduce this, although not with anything very
> minimal.  But if you run the libguestfs test suite like this you'll
> see it:
> 
>   make -C tests/regressions check TESTS=rhbz914931
> 
> The parent process (a C program which for unrelated reasons is called
> 'rhbz914931') receives a SIGTERM.  I checked the siginfo struct for
> this signal, and it appears to come from the vmlinux main process,
> which should not be happening.
> 
> So .. possibly there's something awry with how vmlinux delivers
> signals to its child processes on shutdown which is causing it both to
> miss out some children, and to kill other unrelated processes.  Or
> maybe this is just a coincidence.
> 
> Rich.
> 


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

