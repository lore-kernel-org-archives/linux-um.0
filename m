Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vJiV-0005ee-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 09:45:47 -0700
Received: from boof.brainfood.com ([146.82.138.61] helo=gradall.private.brainfood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vJiV-0004oz-Ar
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 09:45:47 -0700
From: Adam Heath <adam@doogie.org>
Subject: Re: [uml-devel] hostfs as root 
In-Reply-To: <11075.1062779336@marajade.sandelman.ottawa.on.ca>
Message-ID: <Pine.LNX.4.44.0309051143480.686-100000@gradall.private.brainfood.com>
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
Date: Fri, 5 Sep 2003 11:44:45 -0500 (CDT)
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: Matt Zimmerman <mdz@debian.org>, user-mode-linux-devel@lists.sourceforge.net

On Fri, 5 Sep 2003, Michael Richardson wrote:

>     Adam> No, it's a problem.  Just because there's no race in the emulated
>     Adam> environment, doesn't mean there isn't a race in the host.
>
>   I don't think that hostfs provides any inter-UML locking guarantees.
>   What do we do with flock(2)?
>
>   If you like, we can flock(2) the file too while we play with it.

This has not hing to do with inter-uml.  This has everything to do with uml
behaving like a sane, properly written application.

If 2 normal applications did something like this, they'd be buggy just as
well.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
