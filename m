Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsO5V-00022y-KJ
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 07:21:41 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AsO2Y-0003mm-31
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 07:18:38 -0800
Message-ID: <163e01c3f3d7$c1762710$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <20040122144020.GQ4203@erizo.shearer.org> <20040122162014.GA2895@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Changes to port_user
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 15 Feb 2004 16:24:07 +0100
To: Jeff Dike <jdike@addtoit.com>, Dan Shearer <dan@shearer.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

hi!

> If you want to be able to telnet to the port, then you need something which
> speaks telnet, hence you need telnetd.

> > Now what I'm trying to do is replace in.telnetd with something else, for
> > the moment netcat as a simple case, or something that gives the same
> > effect.

mhhh - as security oriented person i would like to admit:
should such "new technology" like uml really "support" unencrypted remote logins and should it support exposing "non encrypted
communication ports" to the outside world ?

telnet is ancient and IMHO it should be replaced by something more secure like ssh. sshd is installed by default on all major
distro`s and it has an "inetd" mode, too.
maybe telnetd can easily be replaced sshd ?

just my 10 eurocents....

regards
roland



----- Original Message ----- 
From: "Jeff Dike" <jdike@addtoit.com>
To: "Dan Shearer" <dan@shearer.org>
Cc: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Thursday, January 22, 2004 5:20 PM
Subject: Re: [uml-devel] Changes to port_user


> On Fri, Jan 23, 2004 at 01:10:20AM +1030, Dan Shearer wrote:
> > I've done some minor work in drivers/port_user.c, including replacing
> > the binding to INADDR_ANY with a gethostbyname(passed_ip), so you
> > can specify which single IP to listen on.
>
> Cool, that's needed doing for a while.
>
> > Now what I'm trying to do is replace in.telnetd with something else, for
> > the moment netcat as a simple case, or something that gives the same
> > effect.
>
> If you want to be able to telnet to the port, then you need something which
> speaks telnet, hence you need telnetd.
>
> If you can connect with something else and have terminal stuff continue
> to work, and replace the telnetd dependency with something that works more
> widely out of the box, then I'm all for it.
>
> > That involves understanding the significance of port_helper and
> > kernel/helper.c, which I don't yet.
>
> What happens is that UML runs telnetd with the port helper as its "login"
> program (problem - not every telnetd out there supports -L, even if it is
> installed, which it often isn't).
>
> When there's a connection, UML gets a descriptor with the telnet on the
> other end.  It needs to get telnetd talking on that to do the telnet
> protocol and another descriptor coming out of telnetd with actual characters
> that the user typed.  So, it does this as follows:
> it execs telnetd with stdin, stderr, stdout duped from the portal
> file descriptor
> telnetd also gets a unix socket on descriptor 3
> port_helper gets the desired telnetd output descriptor on its
> stdin/stdout
> it passes this back to UML over the unix socket on descriptor 3
> which it inherited from telnetd
>
> Jeff
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
