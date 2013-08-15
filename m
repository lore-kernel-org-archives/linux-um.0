Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1VA1U4-0006nb-Th
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Aug 2013 17:37:16 +0000
Received: from mail-vc0-f178.google.com ([209.85.220.178])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VA1U0-0005b4-Gh
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Aug 2013 17:37:16 +0000
Received: by mail-vc0-f178.google.com with SMTP id ha12so701625vcb.9
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 15 Aug 2013 10:37:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130814175911.GG10864@redhat.com>
References: <20130809204355.GA10864@redhat.com>
	<20130814175911.GG10864@redhat.com>
Date: Thu, 15 Aug 2013 19:37:06 +0200
Message-ID: <CAFLxGvyNWbMiDjXREb8AbKHEyGvYBr4WhVAGsg6DfKYc8bfOjA@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] Performance tests (was: Using UML in libguestfs)
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Aug 14, 2013 at 7:59 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
>
> I performed some benchmarks against KVM:
>
> http://rwmj.wordpress.com/2013/08/14/performance-of-user-mode-linux-as-a-libguestfs-backend/#content
>
> Notes for those that don't want to read all that, there are at least
> two bugs I found:
>
> (1) fsync /dev/ubda (in the guest) is not honoured by the user-mode
> linux process.  It should do an fsync on the corresponding backing file.

What exactly does libguestfs do?

> (2) The ssl<N>=... serial port is really slow, at least 10 times
> slower than virtio-serial which is the equivalent KVM feature.
> libguestfs is chatty over the serial port, and so this has a
> significant knock-on impact all over the place.

So, libguestfs transfers all data over a serial line?!
We could hack a faster transport into UML.
As UML is only a process we can very easily access
the host.
Have looked at hostfs?

-- 
Thanks,
//richard

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

