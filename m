Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AjsOu-0002LF-Ty for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 19:54:32 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30) id 1AjsOu-0002bL-Fc
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 19:54:32 -0800
Received: from localhost ([127.0.0.1]:33691 helo=shearer.org)
	by shearer.org with esmtp (Dan's MTA 1.0) id 1AjsQy-0004gD-Dp
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 14:26:40 +1030
Received: from dan by erizo.shearer.org with local (Spammer Slammer 3.141)
	id 1AjsQx-0004gA-2x for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 14:26:39 +1030
From: Dan Shearer <dan@shearer.org>
Message-ID: <20040123035639.GC4203@erizo.shearer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Subject: [uml-devel] Draft docs for port console channel
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
Date: Fri, 23 Jan 2004 14:26:39 +1030
To: user-mode-linux-devel@lists.sourceforge.net

A basic draft.
Dan Shearer
Jan '04

(This might be on the way to a more comprehensive document about console
channels in general)

How the 'port' console channel works
------------------------------------

This facility allows a UML's virtual console or serial line console (/dev/ttyx
or /dev/sslx from within UML) to be connected to a listening port on the host
system. You can telnet to that port and login, without the UML having any
networking configured.

0. About console channel driver

Each channel corresponds to an imaginary hardware device which can be hooked
directly up to the tty devices running inside UML. The files
drivers/chan_kern.c and chan_user.c define abstractions for consoles. When UML
writes to a tty it does so through these functions.

1. About telnetd

telnetd connects a network socket with a pty and interprets terminal protocol
commands if they appear with the data that it is relaying between the socket
and the pty. 

The socket gets passed to telnetd by some program (such inetd, or UML in this
case) in file descriptor 0 passed during the exec call.  telnetd allocates the
next free pts  (eg /dev/pts/1, if Unix98 ptys are in use) and receives a file
descriptor for it. telnetd then execs the login program with stdin/out/err all
containing the file descriptor number of the pts device. The login program
keeps running for the length of the session (it isn't just for authentication.)
The login program normally execs a shell, and the shell just interacts on stdio
as usual.

Some telnetd's have a a -L parameter that specify a login program. This login
program may do some authentication. In the case of UML it does no
authentication, just relays characters between file descriptors.

2. About the port console channel

telnetd is used to process the telnet protocol, but not to connect with a shell
(because there is no shell involved here, except within UML and that is not
relevant to the console channel.) What is required is that data coming from a
telnet client go through telnetd, which strips off all but the data, and then
that data gets sent back into UML to be delivered to the tty device, which
is usually connected to a getty process in /etc/inittab.

The mechanism for getting data back into UML is as follows:

	Before execing telnetd, UML first allocates a new pipe.

	The socket number for that pipe is passed in file descriptor 3.

	File descriptors are inherited with exec, so the login program
	gets it as well

	The login program, which is receiving data from the master side of 
	the pty that telnetd opened, sends the data back through this pipe

The relevant files are arch/um/drivers/port_user.c and port_kern.c.

3. Problems with this scheme

	a. inflexible. You can't have the raw data from the console
	port sent somewhere else, eg for presentation by some other kind of 
	console protocol

	b. telnetd is often not installed, or when it is it may not support
	the -L parameter for a custom login program

	c. klunky. 

	d. hasn't anyone heard of apt-get install termnetd? :-)


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
