Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rjones@redhat.com>) id 1VA1q1-0008DD-6s
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Aug 2013 17:59:57 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VA1q0-0006mf-07 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Aug 2013 17:59:57 +0000
Date: Thu, 15 Aug 2013 18:59:45 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20130815175945.GO5918@redhat.com>
References: <20130809204355.GA10864@redhat.com>
	<20130814175911.GG10864@redhat.com>
	<CAFLxGvyNWbMiDjXREb8AbKHEyGvYBr4WhVAGsg6DfKYc8bfOjA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFLxGvyNWbMiDjXREb8AbKHEyGvYBr4WhVAGsg6DfKYc8bfOjA@mail.gmail.com>
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
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Aug 15, 2013 at 07:37:06PM +0200, richard -rw- weinberger wrote:
> On Wed, Aug 14, 2013 at 7:59 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
> >
> > I performed some benchmarks against KVM:
> >
> > http://rwmj.wordpress.com/2013/08/14/performance-of-user-mode-linux-as-a-libguestfs-backend/#content
> >
> > Notes for those that don't want to read all that, there are at least
> > two bugs I found:
> >
> > (1) fsync /dev/ubda (in the guest) is not honoured by the user-mode
> > linux process.  It should do an fsync on the corresponding backing file.
> 
> What exactly does libguestfs do?

http://libguestfs.org/ ...

> > (2) The ssl<N>=... serial port is really slow, at least 10 times
> > slower than virtio-serial which is the equivalent KVM feature.
> > libguestfs is chatty over the serial port, and so this has a
> > significant knock-on impact all over the place.
> 
> So, libguestfs transfers all data over a serial line?!

Well, it requires an 8-bit clean, reliable, bi-directional connection
into the guest.  We used to use TCP/IP but it's pretty slow compared
to virtio-serial and has a bunch of other problems.

For the UML backend I used the serial port.  There's no problem with
it -- it works and it's reliable, it's just slow.

> We could hack a faster transport into UML.
> As UML is only a process we can very easily access
> the host.
> Have looked at hostfs?

Not sure how hostfs would help?

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/

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

