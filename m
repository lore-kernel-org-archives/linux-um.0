Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vNTv-0005Ny-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 13:46:59 -0700
Received: from [64.6.182.228] (helo=gummo.domain.trailerparc.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vNTu-0004EH-PE
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 13:46:58 -0700
content-class: urn:content-classes:message
Subject: RE: [uml-devel] Creating virtual consoles on the fly 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <10C160F5A03A0942A1A87B658784CA6A0976D4@gummo.domain.trailerparc.com>
From: "Michael Talyansky" <michaelt@doublewidesoft.com>
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
Date: Fri, 5 Sep 2003 13:46:22 -0700
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

That works fine. You could also to telinit -q which has the same effect
as kill -1 1.

I was looking for a programmatic way of doing it, like when someone
sends a command to UML from the outside to open a new virtual console. I
guess if there is no other way, this will have to do.

Do you know why mingetty is unhappy when run from the command line? If
there is some additional stuff I have to do programmatically, I can do
it from a script or a little program.

Thanks,
Michael

-----Original Message-----
From: Jeff Dike [mailto:jdike@addtoit.com] 
Sent: Friday, September 05, 2003 1:13 PM
To: Michael Talyansky
Cc: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Creating virtual consoles on the fly 

michaelt@doublewidesoft.com said:
> If I run /sbin/mingetty with a new console tty (say, ttys/2), the
> virtual console xterm does come up, but then mingetty terminates, and
> no login process is run for the new console. Could someone tell me
> what am I doing wrong? 

Have you tried putting an entry in inittab and kill -1 1?  I've tried
running
getty from the command like in the past, and IIRC it wasn't happy about
that.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
