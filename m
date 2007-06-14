Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HyyCo-0006nr-KA for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jun 2007 15:54:18 -0700
Received: from smtpout10-04.prod.mesa1.secureserver.net ([64.202.165.238]
	helo=smtpout10.prod.mesa1.secureserver.net)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HyyCn-0005st-3X
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jun 2007 15:54:18 -0700
Message-Id: <7.0.1.0.2.20070614183558.0379e470@baretoes.net>
Date: Thu, 14 Jun 2007 18:53:02 -0400
From: Mark Lidd <mark@baretoes.net>
In-Reply-To: <20070614215822.GA12047@c2.user-mode-linux.org>
References: <20070614110816.5e579766944bbcab97407204a2c9ea3e.78a7ca2535.wbe@email.secureserver.net>
	<20070614215822.GA12047@c2.user-mode-linux.org>
Mime-Version: 1.0
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
Content-Type: multipart/mixed; boundary="===============1349594263=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: UML-user <user-mode-linux-devel@lists.sourceforge.net>

--===============1349594263==
Content-Type: multipart/alternative;
	boundary="=====================_97496742==.ALT"

--=====================_97496742==.ALT
Content-Type: text/plain; charset="us-ascii"; format=flowed

I want the UML to send data out the host's serial port so the UML 
process can setup a ppp session to something connected to the hosts 
serial port. --not talk to the host.

I know I can run pppd on the host and give the UML a network connect 
to it, but I don't want to do the connect that way.  I want as much 
of the processing as possible to be in a jailed UML.

I gather that I can give the UML the /dev/ttyS0 connection to the 
serial port and have the UML pppd connect to ss1, etc.

Thanks,
Mark

Thanks.  At 05:58 PM 6/14/2007, Jeff Dike wrote:
>On Thu, Jun 14, 2007 at 11:08:16AM -0700, Mark wrote:
> > My question is I've looked around, but don't understand why (page
> > 54) says that UML doesn't support PPP. Is pppd the problem and can I
> > just use something like slirp?   (I did find a debian package with UML
> > and slirp).
>
>You're looking for a mechanism to exchange packets with the host, not
>asking about ppp support within UML?
>
>ppp isn't supported because no one ever wrote it.  Slirp is basically
>the last choice for when nothing else will work, and ppp might be
>right down there with it.  TUN/TAP is the mechanism of choice.
>
>                                 Jeff
>
>--
>Work email - jdike at linux dot intel dot com



--=====================_97496742==.ALT
Content-Type: text/html; charset="us-ascii"

<html>
<body>
I want the UML to send data out the host's serial port so the UML process
can setup a ppp session to something connected to the hosts serial port.
--not talk to the host.<br><br>
I know I can run pppd on the host and give the UML a network connect to
it, but I don't want to do the connect that way.&nbsp; I want as much of
the processing as possible to be in a jailed UML.<br><br>
I gather that I can give the UML the /dev/ttyS0 connection to the serial
port and have the UML pppd connect to ss1, etc. <br><br>
Thanks,<br>
Mark<br><br>
Thanks.&nbsp; At 05:58 PM 6/14/2007, Jeff Dike wrote:<br>
<blockquote type=cite class=cite cite="">On Thu, Jun 14, 2007 at
11:08:16AM -0700, Mark wrote:<br>
&gt; My question is I've looked around, but don't understand why
(page<br>
&gt; 54) says that UML doesn't support PPP. Is pppd the problem and can
I<br>
&gt; just use something like slirp?&nbsp;&nbsp; (I did find a debian
package with UML<br>
&gt; and slirp).<br><br>
You're looking for a mechanism to exchange packets with the host,
not<br>
asking about ppp support within UML?<br><br>
ppp isn't supported because no one ever wrote it.&nbsp; Slirp is
basically<br>
the last choice for when nothing else will work, and ppp might be<br>
right down there with it.&nbsp; TUN/TAP is the mechanism of
choice.<br><br>
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab><x-tab>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab><x-tab>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab><x-tab>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>Jeff<br><br>
-- <br>
Work email - jdike at linux dot intel dot com</blockquote>
<x-sigsep><p></x-sigsep>
<font size=2><br>
</font></body>
</html>

--=====================_97496742==.ALT--



--===============1349594263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1349594263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1349594263==--


