Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vQvH-0003jU-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 17:27:27 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vQvG-0001nw-Dz
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 17:27:26 -0700
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] restricting hostfs access does not work
In-Reply-To: <200309051108.58297.Marcus.Blomenkamp@epost.de>
Message-ID: <Pine.LNX.4.44.0309060226170.4937-100000@filer.marasystems.com>
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
Date: Sat, 6 Sep 2003 02:27:20 +0200 (CEST)
To: Marcus Blomenkamp <Marcus.Blomenkamp@epost.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 5 Sep 2003, Marcus Blomenkamp wrote:

> I'm running a UML instance using a specific directory on the host as rootfs. 
> How can I restrict the instance to not gain access to upper level 
> directories? The hostfs=xxx option does not work for me.

The most secure option is by chrooting the uml, only giving the host 
process of the instance access to the files it should have access to..


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
