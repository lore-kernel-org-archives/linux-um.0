Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uIof-0002wc-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 02 Sep 2003 14:35:57 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19uIoe-000546-8r
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Sep 2003 14:35:56 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h82LSij02293
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 2 Sep 2003 17:28:45 -0400
Message-Id: <200309021900.h82J0YHx001746@ccure.karaya.com>
Subject: Re: [uml-devel] uml-patch-2.4.20-7 
In-Reply-To: Your message of "Sat, 30 Aug 2003 23:47:49 BST."
             <3F512995.4050209@vgertech.com> 
References: <200308071929.h77JTo5N017958@uml.karaya.com>  <3F512995.4050209@vgertech.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 02 Sep 2003 15:00:34 -0400
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

nuno.silva@vgertech.com said:
> Can you give us a brief explanation on what this does? :) 

It's not useful at the moment.

It's to support the standalone COW driver when I get around to finishing it.
You will set up a COW file on the command line like
	cow0=/dev/ubd1,/dev/ubd0 ubd0=backing-file ubd1=cow-file

Since I can't break the existing
	ubdx=cow-file,backing-file
syntax, that will need to continue to be supported.

This causes a problem with ubd1=cow-file in the first example.  As the ubd
driver is currently written, this will cause ubd1 to be effectively
	ubd1=cow-file,backing-file
because it will read the backing file from the COW header.

With the standalone COW driver, this is undesirable.  We want ubd1 to not
be interpretted as a COW file since cow0 will be doing that.

So, the best thing I could think of was to make you specify ubd1 as
	ubd1d=cow-file
which says 'this is just blocks of data, even though it looks like a COW file'.

This is non-optimal since the common case in the long run (standalone COW)
should be easy and not require any special extra crap, but I don't see a
way of doing that without breaking everyone's scripts.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
