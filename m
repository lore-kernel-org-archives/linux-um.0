Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yCl3-0008Bq-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 08:56:21 -0700
Received: from smtp011.mail.yahoo.com ([216.136.173.31])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19yCky-00009L-GB
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Sep 2003 08:56:16 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Creating virtual consoles on the fly
References: <Pine.LNX.4.44.0309060250220.4937-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0309060250220.4937-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309131633.07928.blaisorblade_spam@yahoo.it>
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
Date: Sat, 13 Sep 2003 16:33:07 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Alle 02:53, sabato 6 settembre 2003, Henrik Nordstrom ha scritto:

> Probably it wants to be a process group leader to start a new session.
Yeah, you are right! I'm not the one who asked the question but I've always 
been wondering for this(it's a mingetty, not an UML issue).
>
> try
>
>   setsid mingetty ...
Works! Thanks a lot!
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
