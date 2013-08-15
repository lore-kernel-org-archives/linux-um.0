Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rjones@redhat.com>) id 1VA1rT-0007Dd-Ps
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Aug 2013 18:01:27 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VA1rS-0002kf-A3 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Aug 2013 18:01:27 +0000
Date: Thu, 15 Aug 2013 19:01:14 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20130815180114.GP5918@redhat.com>
References: <20130811174831.GD10864@redhat.com>
	<CAFLxGvxsdsjJ9LZs4-NFpGYYvRbEQ_YK2D=5W1S6uGCaWcgzSw@mail.gmail.com>
	<CAFLxGvz-PVQvKcs8cKZ8bpEfRj6Hw5h4-qNYrSRSq5Ga1axRvw@mail.gmail.com>
	<20130812085300.GV5918@redhat.com>
	<20130813103603.GA27173@redhat.com> <520A0F35.8000905@nod.at>
	<20130813110651.GX5918@redhat.com>
	<20130813120401.GE10864@redhat.com>
	<20130813122533.GF10864@redhat.com>
	<CAFLxGvxSW5LD3_wQajM-B9L=x=wrgzZcsUVrPYnAUBhjA2YrDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFLxGvxSW5LD3_wQajM-B9L=x=wrgzZcsUVrPYnAUBhjA2YrDQ@mail.gmail.com>
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
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Aug 15, 2013 at 07:34:04PM +0200, richard -rw- weinberger wrote:
> On Tue, Aug 13, 2013 at 2:25 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
> > On Tue, Aug 13, 2013 at 01:04:01PM +0100, Richard W.M. Jones wrote:
> >> OK, I understand what's going wrong and how to reproduce the
> >> signal-to-parent problem.  It does look like a bug in vmlinux.
> >>
> >> It happens if the init process (PID 1) inside the VM gets a segfault.
> >
> > To add an additional data-point, applying the attached patch causes
> > the rogue SIGTERM-to-parent signal to disappear.  So at least we know
> > where it comes from!
> 
> I think we should call setsid() at UML startup.
> Thanks for reporting that issue.
> 
> BTW: You know that UML has a management console?
> http://user-mode-linux.sourceforge.net/old/mconsole.html

Yup, using the management console could be a good idea.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

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

