Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ydU2-0002fN-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 13:28:34 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ydU0-0005w3-PV
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Sep 2003 13:28:33 -0700
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] [PATCH] Starting a command inside UML from mconsole
In-Reply-To: <2878.1063561501@marajade.sandelman.ottawa.on.ca>
Message-ID: <Pine.LNX.4.44.0309142216310.7867-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sun, 14 Sep 2003 22:28:10 +0200 (CEST)
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, 14 Sep 2003, Michael Richardson wrote:

> It is entirely reasonable that the admin of the host system doesn't even
> have login priveledges on the guest system, but would like the guest to
> shutdown nicely before he reboots the host.

For this there already is control-alt-delete (cad command in mconsole). A
guest which wants to be cleanly shut down ought to have a cad handler in
it's inittab (all distros does).

I see the ability to execute commands from mconsole more of a advanced 
administration and debugging tool, where a channel to the guest is always 
guaranteed no matter what happens inside the guest (within reasonable 
limits). 

My personal feeling is that having a mconsole "backdoor" into executing
commands inside the guest is a generally good thing as it gives the host a
clean path for controlling the UML beyond just c-a-d. Even more so in
hosting or honeypot situations where it may not be possible to guarantee
that the hosted UML maintains a separate channel for the purpose. I would
even go as far as saying this is a thing which should be possible via the
sysrq interface on all architectures but unfortunately the kernel sysrq
interface is a bit too limited for this purpose.

Regards
Henrik



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
