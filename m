Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APVun-0007Fu-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 27 Nov 2003 15:51:17 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1APVum-00086p-CN
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 27 Nov 2003 15:51:16 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Re: [uml-user] uml 2.6.0-test9 crash
In-Reply-To: <3FC66DC3.2010909@darkman.de>
Message-ID: <Pine.LNX.4.44.0311280047120.28924-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Fri, 28 Nov 2003 00:50:58 +0100 (CET)
To: Sven 'Darkman' Michels <sven@darkman.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, 27 Nov 2003, Sven 'Darkman' Michels wrote:

> The UML did the frist two dd's without problems, then it started to
> hang.. i checked outside and saw the process switching states from
> R to D and then back to R... so after a few secs the dd's did all
> succeed and the uml is still running. So it didn't crash or so
> but it also didn't play very well with that.

Sounds as if it started to get blocked by disk I/O on the host.. ubd 
device I/O is a latency killer for UML as a blocking disk I/O operation 
will block the whole UML kernel until the host finishes.

> BTW: did you had any problems with building an uml kernel on 9.0?

I have no problem with building UML on RH9, but I have a memory of some
singnal trick which was needed at some point.. Make sure the UML is up to
date.

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
