Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vKJx-0003S5-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 10:24:29 -0700
Received: from pluto.nixia.no ([195.159.42.3])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19vKJx-0006cC-4z
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 10:24:29 -0700
Message-ID: <19654.193.212.97.12.1062774897.squirrel@pluto.nixia.no>
Subject: Re: [uml-devel] hostfs as root
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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
Date: Fri, 5 Sep 2003 17:14:57 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net

The problem occurs when you create a file you are later not allowed to
open if I'm seeing this right, so, the best fix would be not to close the
file when we create them in the first place. Fix the behavour that we

create file
close file
open file again
do action

If that is redone till

create file
do action


The mode issue goes pretty much away, since trying to open a file you are
not allowed to read will normally fail both in host and uml. Only problem
is when creating new files as far as I can see.


Might be more job, but the result is more cleaner than than chmod stuff on
the fly.

Stian




This mail has been scanned for known viruses on an open, Linux-based mailsystem
developed by http://Knowledge-Network.no and http://Nixia.no.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
