Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AjCzT-0004zM-0x for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 23:41:31 -0800
Received: from userbb201.dsl.pipex.com ([62.190.241.201]
	helo=irishsea.home.craig-wood.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AjCzS-0003Jj-IA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 23:41:30 -0800
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Subject: Re: [uml-devel] uml-patch-2.4.23-2
Message-ID: <20040121074127.GA26168@axis.demon.co.uk>
References: <200401171547.i0HFlPtk009266@uml.user-mode-linux.org>
	<20040120092050.GA31994@axis.demon.co.uk>
	<200401201500.i0KF09DG002355@ccure.user-mode-linux.org>
	<20040120173534.GA15399@axis.demon.co.uk>
	<200401202040.i0KKeCDG004061@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401202040.i0KKeCDG004061@ccure.user-mode-linux.org>
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
Date: Wed, 21 Jan 2004 07:41:27 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Jan 20, 2004 at 03:40:11PM -0500, Jeff Dike wrote:
> ncw1@axis.demon.co.uk said:
> > I diffed the hex dump to see what sort of corruptions they were.
> > Nothing obvious springs to mind, other than that the corruptions start
> > on a page boundary, but don't extend for a whole page.  Maybe the page
> > is being re-used before writeout has finished?
> 
> Interesting, but I'm not sure what it means.

fxs tells you what operation caused the problem.  Its output is a
little hard to decode though!

> I had a 100% reproducable test last night, thanks to Chris Aker, but
> it became somewhat iffy today.

fxs has blown up within a minute each time I've tried it with
ubd=mmap.  Not always in the same place though!

FWIW I left fxs running on 2.4.23-2 without ubd=mmap and it ran fine
all night.

> BTW, what filesystem is this?  I'm seeing corruption with ext3, but nothing
> with ext2.

Its ext2

/dev/root / ext2 rw,noatime,nodiratime 0 0

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
