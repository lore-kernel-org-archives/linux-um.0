Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ddz5S-0002Qc-RF	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Jun 2005 16:26:54 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Ddz5R-0003tQ-70	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Jun 2005 16:26:54 -0700
From: antoine <antoine@nagafix.co.uk>
In-Reply-To: <20050602210649.GA24306@ccure.user-mode-linux.org>
References: <1115392141.12197.3.camel@cobra>
	<1115483506.12131.33.camel@cobra>
	<1115481468.925.9.camel@localhost.localdomain>
	<20050507180356.GA10793@ccure.user-mode-linux.org>
	<1115573839.10373.42.camel@cobra>
	<20050508183533.GA27251@ccure.user-mode-linux.org>
	<1115590823.10373.68.camel@cobra> <1115600253.10373.74.camel@cobra>
	<1117691482.10122.107.camel@localhost>
	<20050602210649.GA24306@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1117766016.10122.202.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
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
Date: Fri, 03 Jun 2005 03:33:36 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Thanks, almost all applied cleanly - I skipped the s390 ones for now.
Compiling still requires a `touch arch/um/sys-x86_64/.stub_segv.o.d` to
make it proceed. Works for me! (tm)
But I can't get it to boot into init properly, I can only boot with
init=/bin/bash. (then remount root rw, mount proc)

Every time I run a command, I get something like:
bash: child setpgid (15484 to 15484): No such process
(I remember seeing this one before - but I can't remember the
solution :-(

I can bring the network up manually (ifconfig) and ping (in and out),
but running any of the /etc/init.d/ scripts locks up, same goes for
starting sshd or even "Hello World" in hello.sh

Sometimes when it goes into a spin, it loos on this (to infinity):
"[42949450.500000] fix_range_common: failed, killing current process"

Not sure where do go from here... Maybe patching with just the minimum?
It needs roughly at least up to fix-tt-USR1-handlers to be able to boot
(otherwise you get the error I posted yesterday).

Antoine




On Thu, 2005-06-02 at 17:06 -0400, Jeff Dike wrote:
> On Thu, Jun 02, 2005 at 06:51:22AM +0100, antoine wrote:
> > I applied the patches on the website to 2.6.12-rc5 (mm1 and mm2: most
> > patches apply cleanly to both, some have been merged in mm2 obviously),
> > I got an error here:
> 
> I pushed out a fixed set of patches (against -mm2) that work for me.
> 
> There were some include changes in stub_segv.c.
> 
> The .d file thing is still there.  That seems to have been caused by my 
> changing stub_segv.c to a userspace file.
> 
> 				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
