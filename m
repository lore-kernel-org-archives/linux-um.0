Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xu97-0007Kb-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 13:03:57 -0700
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xu96-0006An-3i
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 13:03:56 -0700
From: M A Young <m.a.young@durham.ac.uk>
Subject: Re: [uml-devel] Child exit when booting uml 2.4.20 on 2.6.0-test4
 host 
In-Reply-To: <200309081647.h88Glrjh030128@ccure.karaya.com>
Message-ID: <Pine.GSO.4.53.0309122100390.4368@altair.dur.ac.uk>
References: <3F59DC82.7070900@bezeqint.net>  <200309081647.h88Glrjh030128@ccure.karaya.com>
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
Date: Fri, 12 Sep 2003 21:03:46 +0100 (BST)
To: Jeff Dike <jdike@addtoit.com>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Mon, 8 Sep 2003, Jeff Dike wrote:

> Try it with the latest patch.  It should be fixed - I applied a different
> fix from the one suggested by Michael Young.

My limited testing suggest the problem is indeed fixed in 2.4.22-3um (and
presumably in -2um as well though I haven't tried it).

	Michael Young


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
