Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATSwz-0002bp-9P
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 13:29:53 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ATSwy-0002Rs-Jk
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 13:29:52 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] [PATCH] provide asm/ldt.h 
In-Reply-To: <200312081921.hB8JLGAv029222@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0312082224010.14902-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Mon, 8 Dec 2003 22:29:40 +0100 (CET)
To: Jeff Dike <jdike@addtoit.com>
Cc: Steve Bennett <steveb@snapgear.com>, user-mode-linux-devel@lists.sourceforge.net

On Mon, 8 Dec 2003, Jeff Dike wrote:

> hno@marasystems.com said:
> > Which is a bit troublesome on self-hosted UML systems of when building
> >  kernel configuration dependent programs. 
> 
> Do you have any specific examples?

Consider a hosted system where the user is allowed to build his own UML 
kernel. With this there is various kernel-dependent programs such as 
iptables, strace etc which needs to be built.

It is obviously possible the user is made aware of the quirks of the UML 
kernel tree compared to the other architectures, instructing him to 
configure the kernel source using the host arch when building these tools, 
but should he be required to?

Luckily so I do not have this problem with any of the kernel dependent
software we use, but mainly because uml is not our main architecture so
our build process always builds primarily for the host, and also always
builds temporary kernel source trees matching the exact kernel version
when building kernel-dependent binaries, but I see the situation quite 
different in a UML hosting situation where UML is the primary architecture 
seen by the users.

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
