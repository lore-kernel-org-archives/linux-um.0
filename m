Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ynpO-00067y-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 00:31:18 -0700
Received: from mailout02.sul.t-online.com ([194.25.134.17])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ynpN-0005Jx-H6
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 15 Sep 2003 00:31:17 -0700
Subject: Re: [uml-devel] [PATCH] Starting a command inside UML from mconsole
From: Ulf.Bartelt@t-online.de (Ulf Bartelt)
In-Reply-To: <Pine.LNX.4.44.0309142216310.7867-100000@filer.marasystems.com>
References: <Pine.LNX.4.44.0309142216310.7867-100000@filer.marasystems.com>
Content-Type: text/plain
Message-Id: <1063611042.14239.16.camel@kira.chaos-gmbz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Mon, 15 Sep 2003 09:31:03 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Am Son, 2003-09-14 um 22.28 schrieb Henrik Nordstrom:
> On Sun, 14 Sep 2003, Michael Richardson wrote:
> 
> > It is entirely reasonable that the admin of the host system doesn't even
> > have login priveledges on the guest system, but would like the guest to
> > shutdown nicely before he reboots the host.
> 
> For this there already is control-alt-delete (cad command in mconsole). A
> guest which wants to be cleanly shut down ought to have a cad handler in
> it's inittab (all distros does).

Exactly.  All an uml hostig admin wants to know is the path to the uml
stop script and I *don't* want the admin to do other things than using
exactly that script, especially (s)he shall not issue commands at will
in my uml.  The uml was set up by me and only I know what and how to
take down and in which order.  So ctrl-alt-del or maybe some means to
tell the uml of a soon coming powerdown/powerfail should be all what's
needed to brimg a customer's uml down cleanly.

> I see the ability to execute commands from mconsole more of a advanced 
> administration and debugging tool, where a channel to the guest is always 
> guaranteed no matter what happens inside the guest (within reasonable 
> limits).

I was to lazy up to now to fight thru driving an uml by expect... from
debootstrap's state of having a mini-Debian installed to having it up
and reachable in the network, some install steps need to be done and a
"perfect remote control" without networking and other tricky things
would make my installer simpler.  But the init= bootarg is my friend and
I can live doing it that way...

So I think such an "uml remote control" would be nice to have but not
essential...

-- 
#
# Say it in Python ;-)
#
try:     you.run(away)
finally: borg.assimilate(you)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
