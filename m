Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IjrKC-0003Dp-3y for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 00:03:44 -0700
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IjrKA-0007wi-L6
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 00:03:44 -0700
Date: Mon, 22 Oct 2007 03:01:31 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
In-Reply-To: <20071022065202.GI2998@hacking>
Message-ID: <Pine.LNX.4.64.0710220300180.701@localhost.localdomain>
References: <200710200252.37919.p.giarrusso@gmail.com>
	<87y7dyhv2u.fsf@hades.wkstn.nix> <20071021114854.GF2455@hacking>
	<20071021130848.GA4621@c2.user-mode-linux.org>
	<20071021132031.GI2455@hacking>
	<20071021154346.GW8181@ftp.linux.org.uk>
	<20071022043746.GF2998@hacking>
	<20071022052214.GY8181@ftp.linux.org.uk>
	<20071022061245.GG2998@hacking> <87d4v7fy5i.fsf@hades.wkstn.nix>
	<20071022065202.GI2998@hacking>
MIME-Version: 1.0
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
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>, Al Viro <viro@ftp.linux.org.uk>

On Mon, 22 Oct 2007, WANG Cong wrote:

> On Mon, Oct 22, 2007 at 07:42:33AM +0100, Nix wrote:
> >On 22 Oct 2007, WANG Cong uttered the following:
> >> I build UML for non-SMP x86. But I don't know about UML_NET_VDE. ;(
> >>
> >> Errors threw out by gcc (too many) are put here:
> >> 	http://wangcong.org/down/errors.txt
> >
> >It's hard to tell without LOCALE=C, but those are the sorts of results
> >I'd expect if you had run make {old,menu,x}config without specifying
> >ARCH=um, so you've configured for one architecture and are now trying
> >to build another.
> >
> >Where is the include/asm symlink pointing to in your build tree?
>
> $ ls -l include/asm
> lrwxrwxrwx 1 wangcong wangcong 6 2007-10-22 12:34 include/asm -> asm-um
>
> OK. Let me do the following:
>
> 	$ make mrproper

...

if you wanted to be *really* anal retentive, you might want to run
"make distclean" instead but, from what i've seen so far, i don't
think that would change what you're seeing.

rday
-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://crashcourse.ca
========================================================================

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
