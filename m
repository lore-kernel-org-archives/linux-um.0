Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ikn8s-0002Or-6i for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Oct 2007 13:47:54 -0700
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ikn8q-0004Zz-FS
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Oct 2007 13:47:54 -0700
From: Rob Landley <rob@landley.net>
Date: Wed, 24 Oct 2007 16:46:54 -0500
References: <200710111754.46854.rob@landley.net>
	<20071024152240.GA7733@c2.user-mode-linux.org>
In-Reply-To: <20071024152240.GA7733@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200710241646.54942.rob@landley.net>
Subject: Re: [uml-devel] User Mode Linux still doesn't build in 2.6.23-final.
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
Cc: linux-kernel@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wednesday 24 October 2007 10:22:40 am Jeff Dike wrote:
> I poked around a bit for a sparc cross-toolchain, didn't find one, so
> I couldn't see what exactly the problem was.

Prebuilt for Ubuntu 7.04:
http://landley.net/code/firmware/downloads/cross-compiler/host-i686/cross-compiler-sparc.tar.bz2

Source code:
Or http://landley.net/code/firmware/downloads/firmware-0.2.2.tar.bz2

For the second one, extract it, cd into it, "./build.sh sparc", and when it 
finishes your sparc-gcc should be in "build/cross-compiler-sparc/bin".

You can move the cross-compiler-sparc directory anywhere you want in the 
filesystem, and it should still work.  Just add the "bin" subdirectory of it 
to $PATH and CROSS_COMPILE=sparc-

Rob
-- 
"One of my most productive days was throwing away 1000 lines of code."
  - Ken Thompson.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
