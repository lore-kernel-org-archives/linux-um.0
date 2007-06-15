Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HzLSa-0007oi-5G for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jun 2007 16:44:08 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HzLSX-000092-Aa
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jun 2007 16:44:08 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 16 Jun 2007 01:43:49 +0200
References: <20070614110816.5e579766944bbcab97407204a2c9ea3e.78a7ca2535.wbe@email.secureserver.net>
	<20070614215822.GA12047@c2.user-mode-linux.org>
	<7.0.1.0.2.20070614183558.0379e470@baretoes.net>
In-Reply-To: <7.0.1.0.2.20070614183558.0379e470@baretoes.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200706160143.50034.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [uml-user] ppp and UML -possible? why or why not?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Mark Lidd <mark@baretoes.net>, Jeff Dike <jdike@addtoit.com>

On venerd=EC 15 giugno 2007, Mark Lidd wrote:
> I want the UML to send data out the host's serial port so the UML
> process can setup a ppp session to something connected to the hosts
> serial port. --not talk to the host.
>
> I know I can run pppd on the host and give the UML a network connect
> to it, but I don't want to do the connect that way.  I want as much
> of the processing as possible to be in a jailed UML.
>
> I gather that I can give the UML the /dev/ttyS0 connection to the
> serial port and have the UML pppd connect to ss1, etc.
>
> Thanks,
> Mark

You can test if it works, but I believe that UML serial driver does not =

implement many of the ioctl's needed for a proper serial port, so it's =

difficult it will work.

Bye
-- =

Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
