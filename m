Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AL3BE-000112-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 15 Nov 2003 08:21:48 -0800
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AL3BD-00034J-In
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 15 Nov 2003 08:21:47 -0800
Message-ID: <11aa01c3ab95$20366b60$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <59298.216.123.206.129.1068491386.squirrel@webmail.mcsnet.ca>  <200311111912.hABJCdIU002422@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.6.0-test9-um on 2.6.0-test9-skas host
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
Date: Sat, 15 Nov 2003 17:25:44 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi !
First off, thanks for such great project and for your (and others) efforts on this.
I use Linux for a long time now, but I can hardly remember of any project which blew my mind the way UML does!
:)

i would like to tell that i`m successfully running 2.6.0-test9-um (suse9 and suse8.2 rootfs) on suse9 host with custom vanilla
2.6.0-test9 kernel,patched with skas-patch. i`m in "early-testing-stage", but at the moment it looks quite good :)

it seems that i have also trouble with the "clock-skew issue":
i run 2 uml instances in parallel and do a "while true;do find /;done >/dev/null &" inside both of them.
then i watch host and uml systems with "vmstat 1" - the vmstat on the host behaves like expected.
the vmstat in the uml`s behaves strange:  they don`t print their output once per second, but at very irregular intervals.
is this issue also resolved by the "long-standing patch from Sapan Bhatia" ?
answering the question to myself: i think - yes!
is there any time-schedule when we can expect this patch being available or can someone point me to the patch, if it`s somewhere
available?
if this is another "issue" - please someone tell me if i should report a bug on SF bugtracker.

BTW:
is there any suse people on this list? it seems for me that YAST (SuSE`s setup and configuration tool) has major problems when
started inside UML. Since suse9 is somewhat "uml ready" (skas patch included and uml-install-suse script delivered with distro) i
would really be happy to see this problem resolved.
i this list right for discussing the details or should this go to suse folks directly?

thanks & regards
roland





----- Original Message ----- 
From: "Jeff Dike" <jdike@addtoit.com>
To: <mark@mcsnet.ca>; "Sapan Bhatia" <bhatia@enseirb.fr>
Cc: <user-mode-linux-user@lists.sourceforge.net>
Sent: Tuesday, November 11, 2003 8:12 PM
Subject: Re: [uml-user] Clock skew? Problem - 'time sleep 1' can take 10 seconds!


> mark@mcsnet.ca said:
> > Running 2.4.22-um5 with host skas patch. With a tun/tap driver setup
> > in the um doing ping -f or any measurable amount of network traffic
> > going into the um causes 'time sleep 1' to take much longer (from 2 to
> > 10 seconds typical)
>
> I have a fix for this in the next patch.  It's a long-standing patch from
> Sapan Bhatia which sat in my queue since people hadn't been complaining
> about it.  More recently, people have started moaning, so the fix is in.
>
> Basically, it ties the internal UML clock to the host tsc.  It's under the
> control of CONFIG_UML_REAL_TIME_CLOCK, which should normally be left on.
> However, anyone debugging with UML who doesn't care about accurate timers
> may want to turn it off.  The reason is that any amount of time spent with
> UML stopped while you stare at gdb will cause a lot of ticks to get backed
> up, and it will deliver them all as soon as you continue UML.  I don't know
> if this will take any noticable time, but it's something to consider.
>
> Jeff



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
