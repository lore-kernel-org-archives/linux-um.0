Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRqFo-0003qy-GR for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 03:30:52 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BRqFn-0008VR-9v for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 03:30:51 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <20040521202120.43068.qmail@web51103.mail.yahoo.com>
	<050e01c44002$d965b490$2000000a@schlepptopp>
In-Reply-To: <050e01c44002$d965b490$2000000a@schlepptopp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405222057.18606.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] [PATCH] for the NPTL problem (was: cannot
	set up thread-local storage???)
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
Date: Sat, 22 May 2004 20:57:18 +0200
To: roland <for_spam@gmx.de>, user-mode-linux-user@lists.sourceforge.net, Eli Criffield <elicriffield@yahoo.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Alle 15:44, sabato 22 maggio 2004, roland ha scritto:
> isn`t that the NPTL problem ?
> rename /lib/tls in your root_fs and reboot.
>
> furthermore:
> http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=107449893709134&w=2
>
> do see that right, there is a patch which could users probably keep away
> from hitting that bug ?

Never had NPTL on my system so I can't test, but what I see is that you're 
right, but he says "i'll test it soon" so this needs at least one people 
testing it. I'm reforwarding this to Jeff so that he picks this up.

It is possible that this does not work on distros other than Fedora; but 
actually "Ulrich" is the maintainer of standard glibc (even if he works for 
RedHat), so this should not be distro-specific.

Bye and thanks for the note!
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
