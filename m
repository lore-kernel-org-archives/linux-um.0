Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQA2P-0002H6-FS for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 11:46:21 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CQA2O-0004CD-83 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 11:46:21 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] con=port hangs uml guest when it trys to create
	mingettys for the ttyp's
References: <20041105155432.49097.qmail@web26105.mail.ukl.yahoo.com>
In-Reply-To: <20041105155432.49097.qmail@web26105.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411052045.56320.blaisorblade_spam@yahoo.it>
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
Date: Fri, 5 Nov 2004 20:45:56 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Roland Kaeser <roli8200@yahoo.de>

On Friday 05 November 2004 16:54, Roland Kaeser wrote:
> Hello
>
> I try to use con=port:<number> for the local uml guest consoles. But I
> recognized that the uml guest system hangs unless a telnet connection to
> the port was made, while creating the mingettys for the ttyps on
> startuptime.

Seems almost a correct behaviour - who should send it the datas to? Check the 
"input drivers" page on the site. However, I understand from the code below 
that you get problems.

If, however, the *UML kernel* hangs, then it's a much harder problem.

> On Fedora look on /etc/rc.d/rc.sysinit for the section:
>
> if [ "$HOSTTYPE" != "s390" -a "$HOSTTYPE" != "s390x" ]; then
>   last=0
>   for i in `LC_ALL=C grep '^[0-9].*respawn:/sbin/mingetty' /etc/inittab |
> sed 's/^.* tty\([0-9][0-9]*\).*/\1/g'`; do
>
>         > /dev/tty$i
>
>         last=$i
>   done
>   if [ $last -gt 0 ]; then
>
>        > /dev/tty$((last+1))
>        > /dev/tty$((last+2))
>
>   fi
> fi
Yes, this situation is nasty. No idea for now apart commenting it out.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
