Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ak2Ay-0002SX-Lu for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 06:20:48 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Ak2Ax-0004SY-Td
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 06:20:48 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Draft docs for port console channel
Message-ID: <20040123144320.GB6768@ccure.user-mode-linux.org>
References: <20040123035639.GC4203@erizo.shearer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123035639.GC4203@erizo.shearer.org>
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
Date: Fri, 23 Jan 2004 09:43:20 -0500
To: Dan Shearer <dan@shearer.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jan 23, 2004 at 02:26:39PM +1030, Dan Shearer wrote:
> In the case of UML it does no
> authentication, just relays characters between file descriptors.

No.
> 	The login program, which is receiving data from the master side of 
> 	the pty that telnetd opened, sends the data back through this pipe

And no.  port_helper passes the actual file descriptor back to UML through
the unix socket on fd 3.  Then, UML receives characters directly from telnetd
without port_helper having to relay them.

Otherwise, this is pretty good.

> 	d. hasn't anyone heard of apt-get install termnetd? :-)

I never heard of termnetd.  I think it's less likely to be installed on
a given system than telnetd though :-)  If UML were to use it, it would
have to write out a config file and tell termnetd to use it.  That's not
horrible, but it is less convenient than being able to put everything on
the command line.

				Jeff


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
