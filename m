Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vRKh-0000qD-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 17:53:43 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vRKg-0004jH-Ds
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 17:53:42 -0700
From: Henrik Nordstrom <hno@marasystems.com>
Subject: RE: [uml-devel] Creating virtual consoles on the fly 
In-Reply-To: <10C160F5A03A0942A1A87B658784CA6A0976D4@gummo.domain.trailerparc.com>
Message-ID: <Pine.LNX.4.44.0309060250220.4937-100000@filer.marasystems.com>
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
Date: Sat, 6 Sep 2003 02:53:35 +0200 (CEST)
To: Michael Talyansky <michaelt@doublewidesoft.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Fri, 5 Sep 2003, Michael Talyansky wrote:

> Do you know why mingetty is unhappy when run from the command line? If
> there is some additional stuff I have to do programmatically, I can do
> it from a script or a little program.

Probably it wants to be a process group leader to start a new session.

try

  setsid mingetty ...

or if that fails

  setsid mingetty ... </dev/null >/dev/null 2>&1

Regards
Henrik



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
