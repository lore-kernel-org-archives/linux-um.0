Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yNgF-0000vr-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 20:36:07 -0700
Received: from tailtiu.davidcoulson.net ([207.166.203.132] helo=mail.mx.davidcoulson.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19yNgF-0000Hz-8e
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Sep 2003 20:36:07 -0700
Message-ID: <3F63E207.8070607@davidcoulson.net>
From: David Coulson <david@davidcoulson.net>
MIME-Version: 1.0
Subject: [Fwd: Re: [uml-devel] uml-patch-2.4.22-4]
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sat, 13 Sep 2003 23:35:35 -0400
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

+       {9, "urandom", S_IRUGO | S_IWUSR,           &urandom_fops},
+       {10, "anon", S_IRUGO | S_IWUSR,             &anon_fops},

That patch to mem.c is borked.

-------- Original Message --------
Subject: Re: [uml-devel] uml-patch-2.4.22-4
Date: Sat, 13 Sep 2003 23:32:38 -0400
From: David Coulson <david@davidcoulson.net>
To: Jeff Dike <jdike@addtoit.com>
References: <200309140317.h8E3H2e4008178@ccure.karaya.com>

Jeff Dike wrote:
> There are also a couple of cleanups from Stian, and also from me, since I
> was feeling left out of all the fun.

If I compile 2.4.22-4um without CONFIG_DEV_ANON, I get this:

mem.c: In function `memory_devfs_register':
mem.c:728: error: `anon_fops' undeclared (first use in this function)
mem.c:728: error: (Each undeclared identifier is reported only once
mem.c:728: error: for each function it appears in.)
mem.c:728: error: initializer element is not constant
mem.c:728: error: (near initialization for `list[8].fops')
mem.c:728: error: initializer element is not constant
mem.c:728: error: (near initialization for `list[8]')


What is CONFIG_DEV_ANON and why would I want it?

David

-- 
David Coulson                                    email: d@vidcoulson.com
Linux Developer /                          web: http://davidcoulson.net/
Network Engineer                                   phone: (216) 533-6967



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
