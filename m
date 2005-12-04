Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eiy0h-0000Xh-N8 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Dec 2005 09:50:51 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Eiy0f-0005VU-Au
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Dec 2005 09:50:51 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Is there an easy way to do a stack dump on UML?
References: <200512021412.21539.rob@landley.net>
	<200512022144.20730.rob@landley.net>
	<20051203060030.GB17426@ccure.user-mode-linux.org>
In-Reply-To: <20051203060030.GB17426@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512041150.32347.rob@landley.net>
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
Date: Sun, 4 Dec 2005 11:50:31 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Saturday 03 December 2005 00:00, Jeff Dike wrote:
> On Fri, Dec 02, 2005 at 09:44:20PM -0600, Rob Landley wrote:
> > I've never used mconsole.  Never needed it before.
> >
> > Perhaps if I attach to a serial console instead of stdio I can send sysrq
> > that way...
>
> No.  Just think a little.  Banging on the SysRq key on your keyboard can't
> do anything but send SysRq to the host.

I know.  That's why I asked.  I thought there might be some other key 
combination that could do the same thing for a UML console.  (QEMU listens to 
the tty to do various escapes in non-graphics mode, for example.)

> SysRq for a virtual machine has to be an out-of-band thing wrt the host. 

Yeah, sending compressed data across the console becomes a bit dangerous 
otherwise.  But again, the difference between a pipe and a tty is that a tty 
has out-of-band information attached.

Possibly a couple of different shift keys plus the character in question?  
(Something X wouldn't intercept first, qemu uses ctrl-alt and it seems to 
work for them.)  According to man 4 console_ioctl, TIOCLINUX subcode 6 gives 
me something called "shift_state", so maybe I can beat some information out 
of the tty to tell when the user hit "ctrl-alt t" and turn that into sysrq-t?  
In theory it might work both when stdin is a tty and via an xterm...

To-do item.  The documentation on this sucks pretty badly...

> For UML, that's mconsole.

Except that serial consoles can also do sysrq.  (I vaguely remember they send 
a break signal or some such.  Dunno how to do that on an emulated one...)

>     Jeff

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
