Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IlSuB-0005WM-21 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Oct 2007 10:23:31 -0700
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IlSu8-0001ua-N2
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Oct 2007 10:23:30 -0700
Date: Fri, 26 Oct 2007 13:20:32 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
In-Reply-To: <20071026163945.GF7770@c2.user-mode-linux.org>
Message-ID: <Pine.LNX.4.64.0710261317030.32320@localhost.localdomain>
References: <Pine.LNX.4.64.0710260247060.27287@localhost.localdomain>
	<20071026163945.GF7770@c2.user-mode-linux.org>
MIME-Version: 1.0
Subject: Re: [uml-devel] infinite symlink loop for "sysdep-i386"
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
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 26 Oct 2007, Jeff Dike wrote:

> On Fri, Oct 26, 2007 at 02:48:21AM -0400, Robert P. J. Day wrote:
> >   in arch/um/include/sysdep-i386:
>
> > lrwxrwxrwx 1 rpjday rpjday   11 2007-10-22 04:08 sysdep-i386 -> sysdep-i386   ?????
>
> Sorry about the delay...
>
> I don't have any such animal here - can you make this happen on a clean tree?

ok, i just cleaned my git clone of everything but the .git directory,
did a "git pull" to make sure i'm up to date, then checked everything
out again with "git checkout -f", and now it's gone.  weird.  i'll try
to figure out what i was doing that caused it, since i'm not doing
*anything* with UML at the moment.

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
