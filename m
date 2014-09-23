Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rob@landley.net>) id 1XWSN0-0000Pq-B1
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Sep 2014 15:51:14 +0000
Received: from mail-ob0-f181.google.com ([209.85.214.181])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XWSMz-00046X-8y
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Sep 2014 15:51:14 +0000
Received: by mail-ob0-f181.google.com with SMTP id wo20so5206698obc.12
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 23 Sep 2014 08:51:07 -0700 (PDT)
Message-ID: <54218A8B.5030808@landley.net>
Date: Tue, 23 Sep 2014 09:58:19 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
References: <E1XW6rt-0005E0-Pl@sog-mx-2.v43.ch3.sourceforge.com>
	<54206CFB.4070308@kot-begemot.co.uk>
In-Reply-To: <54206CFB.4070308@kot-begemot.co.uk>
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
Subject: Re: [uml-devel] Fwd: Mail delivery failed: returning message to
	sender
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, richard.weinberger@gmail.com, user-mode-linux-devel@lists.sourceforge.net

On 09/22/14 13:39, Anton Ivanov wrote:
> Hi RIchard, hi list,
> 
> There is some problem with the list on sourceforge. It has bounced one
> of the patches - no 4.
> 
> I can resend this for book-keeping purposes.
> 
> If memory serves me right there are no changes in this particular one so
> the earlier version (3) from ~ 2 weeks ago can be used instead.
> 
> A.

As long as somebody's paying attention to UML again: what would be
involved in adding support for arm/mips/sh4/sparc...

I've mostly wandered off to use qemu these days, and I package system
images with native compilers you can boot up and compile software in:

http://landley.net/aboriginal/bin/

(Grab a system-image-$ARCH.tar.bz2 and ./run-emulator.sh in that, or
./dev-environment.sh if you want it to truncate and ext2 format a
scratch space block device and and mount it on /home in the emulated
system so you have persistent storage.)

I'm under the impression that user mode linux would need some glue code
to run on powerpc, but dunno what it would actually be...

Rob

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

