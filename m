Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yxq4-0004sN-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 11:12:40 -0700
Received: from smtp014.mail.yahoo.com ([216.136.173.58])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19yxq4-00033s-Fu
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 15 Sep 2003 11:12:40 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Starting a command inside UML from mconsole
References: <200309131820.45833.blaisorblade_spam@yahoo.it> <20030913194849.GX8622@alcor.net> <200309142050.03304.blaisorblade_spam@yahoo.it>
In-Reply-To: <200309142050.03304.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309151912.02394.blaisorblade_spam@yahoo.it>
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
Date: Mon, 15 Sep 2003 19:12:02 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:50, domenica 14 settembre 2003, BlaisorBlade ha scritto:
> > > - is the ability to read arguments with spaces(within quotes) needed
> > > even for the program name?
> Now, I'm posting the patch against 2.4.22-3um(I am not so fast to port
> patches back and forth to reach -4um for now). It does compile, I've got to
> test the parsing part but I want to post it even now so that you can say me
> if I'm doing it well or using a completely wrong way, and such things(I'm
> new to kernel hacking, as I said, even if I found enough docs).

> Thanks for the interest, and sorry if you think you wasted your time.
In fact :-(. Sorry for anyone who tried it: the parsing code is totally wrong. 
I'm going to correct it. I wrote it very fast, and I was thinking only to the 
kernel related issues...
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
