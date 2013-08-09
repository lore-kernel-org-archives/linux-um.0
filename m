Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rjones@redhat.com>) id 1V7uHN-0001gK-B2
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 21:31:25 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V7uHL-0006q4-JC for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 21:31:25 +0000
Date: Fri, 9 Aug 2013 22:31:13 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20130809213113.GS5918@redhat.com>
References: <20130809204355.GA10864@redhat.com>
	<CAFLxGvxSdR48N+_kb+mNkamEKENP3uWEJB4MxFCTEh94oOcXog@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFLxGvxSdR48N+_kb+mNkamEKENP3uWEJB4MxFCTEh94oOcXog@mail.gmail.com>
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
Subject: Re: [uml-devel] Using UML in libguestfs
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Aug 09, 2013 at 10:57:20PM +0200, richard -rw- weinberger wrote:
> On Fri, Aug 9, 2013 at 10:43 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
> > * UML is pretty fast!  It's certainly faster (by a factor of > 5) than
> > spinning up a lightweight KVM VM.
> 
> Wow!
> Does it only boot faster or is it also faster with reading data from a
> filesystem?

I've only got it booting so far, so I haven't been able to test file
transfer speeds.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming blog: http://rwmj.wordpress.com
Fedora now supports 80 OCaml packages (the OPEN alternative to F#)

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

