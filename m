Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AKLxz-0004AF-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 13 Nov 2003 10:13:15 -0800
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AKLxy-0005En-R4
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 13 Nov 2003 10:13:14 -0800
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20031113181311.GF9377@dijkstra.csh.rit.edu>
References: <20031113175701.GB899@donald.balu5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031113175701.GB899@donald.balu5>
Subject: [uml-devel] Re: Bug#220526: #220526: same problem on my box
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 13 Nov 2003 13:13:12 -0500
To: Martin Pitt <martin@piware.de>, 220526@bugs.debian.org
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Nov 13, 2003 at 06:57:02PM +0100, Martin Pitt wrote:

> I just tried out UML for the first time and have the same problem. I
> also happen to have the same kernel as the original submitter, an
> unpatched 2.6.9-test9.
> 
> I tried to run rootstrap.The error does occur indeterministically;
> sometimes it crashes immediately, sometimes I get to the "continue
> y/n" question and sometimes even as far as to the first package
> installation.
> 
> I just tried the same with a 2.4.22-grsec host kernel and it works
> fine.
> 
> What do you think, is it generally not possible to mix different major
> kernel releases (that would spoil much of UML's original idea) or is
> that a bug in 2.6.0-test9?

I'm fairly certain that UML has worked fine on previous 2.6.0-test kernels,
so this may be a new bug.

> BTW, from my POV this would be a grave bug...

That may be, but it doesn't meet the definition of a grave bug for Debian's
purposes, because the package works fine for all but a small percentage of
users who are using a certain pre-release Linux kernel.

-- 
 - mdz


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
