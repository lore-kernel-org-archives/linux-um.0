Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vJ8J-0008TR-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 09:08:23 -0700
Received: from boof.brainfood.com ([146.82.138.61] helo=gradall.private.brainfood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vJ8I-0001rH-EY
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 09:08:22 -0700
From: Adam Heath <adam@doogie.org>
Subject: Re: [uml-devel] hostfs as root 
In-Reply-To: <31667.1062777050@marajade.sandelman.ottawa.on.ca>
Message-ID: <Pine.LNX.4.44.0309051106050.686-100000@gradall.private.brainfood.com>
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
Date: Fri, 5 Sep 2003 11:06:43 -0500 (CDT)
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: Matt Zimmerman <mdz@debian.org>, user-mode-linux-devel@lists.sourceforge.net

On Fri, 5 Sep 2003, Michael Richardson wrote:

>     >> I propose: stat(), save permissions chmod(u+rw) (as appropriate for
>     >> the open) open() chmod(oldperms)
>
>     Matt> Sounds like a recipe for lots of race conditions.
>
>   Uh, how?
>   Remember, this is in the kernel. We have locks.
>
>   If two UMLs come along, using the same rootfs, well, that's a different
> problem.

No, it's a problem.  Just because there's no race in the emulated environment,
doesn't mean there isn't a race in the host.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
