Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuZgX-0004Jb-Vj for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Feb 2004 08:08:57 -0800
Received: from bay14-dav24.bay14.hotmail.com ([64.4.48.81] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuZa2-0000Pr-Ed for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Feb 2004 08:02:14 -0800
From: "James McMechan" <James_McMechan@hotmail.com>
References: <20040214015148.26508.qmail@home19.riedel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <BAY14-DAV24lkDTM9wG00000c82@hotmail.com>
Subject: [uml-devel] Re: USB and UML
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
Date: Sat, 21 Feb 2004 07:59:21 -0800
To: Larry@Riedel.org
Cc: user-mode-linux-devel@lists.sourceforge.net

> Hi, sorry to bug-- if you have a second, I have a quick
> question; I would like to use a UML process for a USB device
> driver because I think it will eventually lock up or oops
> and I want to be able to just reconnect the device and
> restart the UML process.  It looks like at one time you were
> trying to maintain some code to allow this.  Do you know
> what is the latest status as far as this kind of capability?
> I do not care much about the kernel version inside the UML
> process, but the host would be the close to latest (eg
> currently 2.4.24).
That should work, I remember that it was working on 
2.4.18 and 2.4.19 but then they backported the host controller
changes from 2.5 which broke the um-usb for 2.4.20
In the 2.5 tree it worked untill about 2.5.39
I used it to test out some flaky drivers also, kaweth.o was
Oopsing on me and also for my smart card reader.

The host kernel can be any recent version I would suggest
applying the host-skas patch as then it is much faster and
the host kernel can be run under gdb (or attached to gdb)
See for example the debugging page at sourceforge
On a host kernel without skas you can use the debug
command line option to start a gdb but I haven't tested
it that way recently.

My current patches should be at 
http://jmcmechan.linuxdriven.net


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
