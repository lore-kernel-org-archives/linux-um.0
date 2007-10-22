Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IjvZo-0004do-MV for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 04:36:09 -0700
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IjvZm-0006NP-H9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 04:36:07 -0700
Date: Mon, 22 Oct 2007 12:36:00 +0100
From: Al Viro <viro@ftp.linux.org.uk>
Message-ID: <20071022113600.GA8181@ftp.linux.org.uk>
References: <20071021130848.GA4621@c2.user-mode-linux.org>
	<20071021132031.GI2455@hacking>
	<20071021154346.GW8181@ftp.linux.org.uk>
	<20071022043746.GF2998@hacking>
	<20071022052214.GY8181@ftp.linux.org.uk>
	<20071022061245.GG2998@hacking> <87d4v7fy5i.fsf@hades.wkstn.nix>
	<20071022065202.GI2998@hacking>
	<20071022065943.GC10864@uranus.ravnborg.org>
	<20071022074823.GJ2998@hacking>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071022074823.GJ2998@hacking>
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
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>, Sam Ravnborg <sam@ravnborg.org>

On Mon, Oct 22, 2007 at 03:48:23PM +0800, WANG Cong wrote:
> I just followed what Sam told me, errors are much fewer this time,
> but still exist. Error messages are:
> 
>   CC      arch/um/kernel/syscall.o
>   CC      arch/um/kernel/sysrq.o
> arch/um/kernel/sysrq.c: In function ???show_stack???:
> arch/um/kernel/sysrq.c:63: error: ???UESP??? undeclared (first use in this function)
> arch/um/kernel/sysrq.c:63: error: (Each undeclared identifier is reported only once
> arch/um/kernel/sysrq.c:63: error: for each function it appears in.)
> make[1]: *** [arch/um/kernel/sysrq.o] Error 1
> make: *** [arch/um/kernel] Error 2
> 
> Or I missed something again?
> 
> And I use `make defconfig ARCH=um' to generate .config, my tree
> is 2.6.23-git16 (Al, is this OK?).

Now apply the patch upthread, it should've fixed that one (and yes, you
are down to the stuff this patch is supposed to fix - and does so here).

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
