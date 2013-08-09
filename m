Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rjones@redhat.com>) id 1V7u1u-0001hg-EY
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 21:15:26 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V7u1p-0005SD-Dg for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 21:15:26 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r79LFFRM032684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 9 Aug 2013 17:15:15 -0400
Received: from localhost (vpn1-6-126.ams2.redhat.com [10.36.6.126])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id r79LFETM024888 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 9 Aug 2013 17:15:14 -0400
Date: Fri, 9 Aug 2013 22:15:12 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20130809211512.GB10864@redhat.com>
References: <20130809204355.GA10864@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130809204355.GA10864@redhat.com>
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
To: user-mode-linux-devel@lists.sourceforge.net

On Fri, Aug 09, 2013 at 09:43:55PM +0100, Richard W.M. Jones wrote:
> * I'm trying to use a serial port to communicate between guest and
> host, using ssl3=fd:<N>.  This causes the Linux process to crash soon
> (but not immediately) after the guest has opened /dev/ttyS3:
> 
>   spurious interrupt in ubd_handler, err = -4

So I realized this is caused by a coding mistake by me.  I had set to
O_CLOEXEC flag on the file descriptor, so it was being closed across
the exec of vmlinux.

It still doesn't quite work, but the error above has gone away.

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

