Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ymUG-0000fT-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 23:05:25 -0700
Received: from commsecureaustptyltd.sb1.optus.net.au ([203.202.148.106] helo=commsecure.com.au)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ymUG-00077K-8b
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Sep 2003 23:05:24 -0700
Received: from sunhill.commsecure.com.au (sunhill.commsecure.com.au [172.16.15.1])
	by commsecure.com.au (8.11.6/8.11.6) with ESMTP id h8F65Ic11383
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 16:05:18 +1000
Received: from ws14.commsecure.com.au (ws14.commsecure.com.au [172.16.15.14])
	by sunhill.commsecure.com.au (8.11.6/8.11.6) with ESMTP id h8F65LN16452
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 16:05:21 +1000
Received: from ws14.commsecure.com.au (localhost.localdomain [127.0.0.1])
	by ws14.commsecure.com.au (8.12.8/8.12.8) with ESMTP id h8F65KBe011437
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 16:05:21 +1000
Received: (from malcolm@localhost)
	by ws14.commsecure.com.au (8.12.8/8.12.8/Submit) id h8F65Ks8011435
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 15 Sep 2003 16:05:20 +1000
Subject: Re: [uml-devel] compile problem with uml-patch-2.4.22-4
From: Malcolm Tredinnick <malcolm@commsecure.com.au>
In-Reply-To: <200309150545.h8F5jJWw022233@hongkong.cs.nmsu.edu>
References: <200309150545.h8F5jJWw022233@hongkong.cs.nmsu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063605919.1070.21.camel@ws14.commsecure.com.au>
Mime-Version: 1.0
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
Date: Mon, 15 Sep 2003 16:05:19 +1000
To: user-mode-linux-devel@lists.sourceforge.net

On Mon, 2003-09-15 at 15:45, Ross Combs wrote:
> The latest 2.4 UML patch added support for an "Anonymous memory device".
> I have no idea what this is normally used for so I deselected it in the
> configuration.  However that leads to a compile error in mem.c which I
> hacked around by adding #if defined(CONFIG_DEV_ANON) .. #endif around
> the last line of the array initializer:
>    {10, "anon", S_IRUGO | S_IWUSR,             &anon_fops}
> 
> I'm not using devfs, so I'm not sure why that function is needed at all.
> 
> Anyway, it seems like a small oversight and I haven't noticed any ill
> effect from the change.

Jeff mentioned this in an earlier mail to this list. It is left over
cruft from an experiment. Just leave it turned on for now. :-)

Cheers,
Malcolm



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
