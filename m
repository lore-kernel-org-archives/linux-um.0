Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uyQe-0006CF-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 11:01:56 -0700
Received: from [64.6.182.228] (helo=gummo.domain.trailerparc.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19uyQV-0002pe-2p
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 11:01:47 -0700
content-class: urn:content-classes:message
Subject: RE: [uml-devel] Creating virtual consoles on the fly
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <10C160F5A03A0942A1A87B658784CA6A0976D2@gummo.domain.trailerparc.com>
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
Date: Thu, 4 Sep 2003 11:00:54 -0700
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

This is the result of "openvt -l bash":

Couldnt get a file descriptor referring to the console
Could not get a file descriptor referring to the console

If I run /sbin/mingetty with a new console tty (say, ttys/2), the
virtual console xterm does come up, but then mingetty terminates, and no
login process is run for the new console. Could someone tell me what am
I doing wrong?

Thanks!

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au] 
Sent: Wednesday, September 03, 2003 9:39 PM
To: Michael Talyansky; user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Creating virtual consoles on the fly

On Thu, 4 Sep 2003 05:59, Michael Talyansky wrote:
> Is there a programmatic way to create a virtual console on the fly,
that
> is, without changing /etc/inittab and doing something like "telinit
q"?

What is wrong with openvt?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux
packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
