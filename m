Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ydZC-000373-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 13:33:54 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ydZB-00009Q-Gq
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Sep 2003 13:33:53 -0700
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] [PATCH] Starting a command inside UML from mconsole
In-Reply-To: <200309142050.03304.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.44.0309142231120.7867-100000@filer.marasystems.com>
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
Date: Sun, 14 Sep 2003 22:33:46 +0200 (CEST)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, 14 Sep 2003, BlaisorBlade wrote:

> Your idea is good(opening a file and dupping it to 0,1,2 handles should be 
> simple). Only I wouldn't like that it becomes too long to implement, i.e. to 
> do in user-space. And I must go discovering how exactly to do it inside the 
> kernel(I'll do this, however).

My feeling is that attaching to the console is a suitable default, maybe
with the option to attaching to a specified channel.

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
