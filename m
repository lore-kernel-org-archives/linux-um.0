Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yZO5-0003O7-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 09:06:09 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yZO4-0006XF-Ci
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Sep 2003 09:06:08 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h8EFvtj03142
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 11:57:56 -0400
Message-Id: <200309141606.h8EG6VNu012090@ccure.karaya.com>
Subject: Re: [uml-devel] uml-patch-2.4.22-4 
In-Reply-To: Your message of "Sun, 14 Sep 2003 15:24:08 BST."
             <Pine.LNX.4.44.0309141522550.29078-100000@god.stev.org> 
References: <Pine.LNX.4.44.0309141522550.29078-100000@god.stev.org> 
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
Date: Sun, 14 Sep 2003 12:06:31 -0400
To: James Stevenson <james@stev.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

james@stev.org said:
> Does anyone know what mmu_gathers is ? 

Turn off CONFIG_SMP for now.

			Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
