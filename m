Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yg09-0004Uf-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 16:09:53 -0700
Received: from jstevenson.plus.com
	([212.159.71.212] helo=alpha.stev.org ident=mistral)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yg08-0002DF-8f
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Sep 2003 16:09:52 -0700
From: James Stevenson <james@stev.org>
Subject: Re: [uml-devel] uml-patch-2.4.22-4 
In-Reply-To: <200309141606.h8EG6VNu012090@ccure.karaya.com>
Message-ID: <Pine.LNX.4.44.0309150009450.23397-100000@god.stev.org>
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
Date: Mon, 15 Sep 2003 00:10:26 +0100 (IST)
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


> james@stev.org said:
> > Does anyone know what mmu_gathers is ? 
> 
> Turn off CONFIG_SMP for now.
 
Done and works.

Is this the only thing missing from
SMP or is there more known "hidden" bugs ?

thanks
	James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
