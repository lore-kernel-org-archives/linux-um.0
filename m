Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19v61z-00054f-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 19:08:59 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19v61x-00086S-8D
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 19:08:57 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h8521Zj29174
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 4 Sep 2003 22:01:35 -0400
Message-Id: <200309050211.h852BdAd027914@ccure.karaya.com>
Subject: Re: [uml-devel] uml + tls ... 
In-Reply-To: Your message of "Tue, 26 Aug 2003 10:44:18 +0200."
             <20030826084418.GA16426@bytesex.org> 
References: <20030822143622.GA17307@bytesex.org> <200308260216.h7Q2GNxI025616@ccure.karaya.com>  <20030826084418.GA16426@bytesex.org> 
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
Date: Thu, 04 Sep 2003 22:11:39 -0400
To: Gerd Knorr <kraxel@bytesex.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

kraxel@bytesex.org said:
> I have a workaround now. 

I just eliminated that first ALIGN().  There is really no point to it, so
it's OK to delete it.  This will be in the next patch.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
