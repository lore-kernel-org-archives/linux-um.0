Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AjhD1-0007UH-9R for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 07:57:31 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AjhD0-00079q-EA
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 07:57:30 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Changes to port_user
Message-ID: <20040122162014.GA2895@ccure.user-mode-linux.org>
References: <20040122144020.GQ4203@erizo.shearer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122144020.GQ4203@erizo.shearer.org>
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
Date: Thu, 22 Jan 2004 11:20:14 -0500
To: Dan Shearer <dan@shearer.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jan 23, 2004 at 01:10:20AM +1030, Dan Shearer wrote:
> I've done some minor work in drivers/port_user.c, including replacing
> the binding to INADDR_ANY with a gethostbyname(passed_ip), so you
> can specify which single IP to listen on. 

Cool, that's needed doing for a while.
 
> Now what I'm trying to do is replace in.telnetd with something else, for
> the moment netcat as a simple case, or something that gives the same
> effect. 

If you want to be able to telnet to the port, then you need something which
speaks telnet, hence you need telnetd.

If you can connect with something else and have terminal stuff continue
to work, and replace the telnetd dependency with something that works more
widely out of the box, then I'm all for it.

> That involves understanding the significance of port_helper and
> kernel/helper.c, which I don't yet.

What happens is that UML runs telnetd with the port helper as its "login"
program (problem - not every telnetd out there supports -L, even if it is
installed, which it often isn't).

When there's a connection, UML gets a descriptor with the telnet on the
other end.  It needs to get telnetd talking on that to do the telnet
protocol and another descriptor coming out of telnetd with actual characters
that the user typed.  So, it does this as follows:
	it execs telnetd with stdin, stderr, stdout duped from the portal
file descriptor
	telnetd also gets a unix socket on descriptor 3
	port_helper gets the desired telnetd output descriptor on its
stdin/stdout
	it passes this back to UML over the unix socket on descriptor 3
which it inherited from telnetd

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
