Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A3PPT-0008UW-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 27 Sep 2003 17:27:35 -0700
Received: from starsky.19inch.net ([80.1.73.116] ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A3PPS-0005e2-Ln
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 27 Sep 2003 17:27:34 -0700
From: Paul Sladen <uml@paul.sladen.org>
Subject: Re: [uml-devel] Separate COW patch.
In-Reply-To: <2D4B6CD74137D4119A1100104BC6BCBF0BC585FC@dubntex006.qwest.net>
Message-ID: <Pine.LNX.4.21.0309280058070.31617-100000@starsky.19inch.net>
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
Date: Sun, 28 Sep 2003 01:00:46 +0100 (BST)
To: UML List <user-mode-linux-devel@lists.sourceforge.net>
Cc: Herbert Poetzl - Not on UML List <herbert@13thfloor.at>

On Fri, 26 Sep 2003, Montgomery, Kendal L wrote:
> I was wondering if there was anyone who is trying to use the COW filesystem
> in a normal linux kernel?

The UML COW is block-based and isn't really what you want.  Try:

  http://vserver.13thfloor.at/TBVFS/

	-Paul
-- 
War is inconsistent with Truth.  Nottingham, GB





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
