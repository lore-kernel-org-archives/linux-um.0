Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HbhSg-0008Rb-MI for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 11:22:32 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HbhSe-00038n-SK
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 11:22:30 -0700
Date: Wed, 11 Apr 2007 14:17:21 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070411181721.GA14517@c2.user-mode-linux.org>
References: <20070411160126.GA6324@c2.user-mode-linux.org>
	<75b57c110704111005w6b605d0cv921f3b2c6a6c4eae@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <75b57c110704111005w6b605d0cv921f3b2c6a6c4eae@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH 2/4] UML - Send pointers instead of
	structures to I/O thread
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Gerb Stralko <gerb.stralko@gmail.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Apr 11, 2007 at 01:05:16PM -0400, Gerb Stralko wrote:
> Is this wrong?  you declare io_reg as a pointer but then you pass him
> to os_write_file_k by  reference of a pointer? Should you just do this
> instead:

Intentional, I'm writing pointers, not structures, down the pipe.

Tx for the review, BTW.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
