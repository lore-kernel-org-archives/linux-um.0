Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ijpk8-0002Xo-0l for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Oct 2007 22:22:24 -0700
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ijpk6-0007Ch-L1
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Oct 2007 22:22:23 -0700
Date: Mon, 22 Oct 2007 06:22:14 +0100
From: Al Viro <viro@ftp.linux.org.uk>
Message-ID: <20071022052214.GY8181@ftp.linux.org.uk>
References: <200710111754.46854.rob@landley.net>
	<200710200252.37919.p.giarrusso@gmail.com>
	<87y7dyhv2u.fsf@hades.wkstn.nix> <20071021114854.GF2455@hacking>
	<20071021130848.GA4621@c2.user-mode-linux.org>
	<20071021132031.GI2455@hacking>
	<20071021154346.GW8181@ftp.linux.org.uk>
	<20071022043746.GF2998@hacking>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071022043746.GF2998@hacking>
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
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>

On Mon, Oct 22, 2007 at 12:37:46PM +0800, WANG Cong wrote:
> >Fallout continues; I've got a preliminary patch for it.  Basically, we
> >need to stop doing -U__i386__ et.al.
> >
> 
> Hi, Al.
> 
> I applied your patch and recompiled the kernel. But it failed again.
> ;(

Details would be welcome...  Notes: SMP on UML is no more; UML_NET_VDE
depends on having some userland library installed.  Aside of those two
it ought to build.

Build log on failing build would be nice, along with .config.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
