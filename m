Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KGzXF-0003je-6w for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jul 2008 10:02:25 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KGzXD-0001Yq-8x
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jul 2008 10:02:25 -0700
Date: Thu, 10 Jul 2008 13:02:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080710170210.GB18429@c2.user-mode-linux.org>
References: <5df78e1d0807030053x8a9bfabo582ea78e74b2c65b@mail.gmail.com>
	<20080703135639.GA8262@c2.user-mode-linux.org>
	<5df78e1d0807031806s74c13c84idadc62c1d1e0e93b@mail.gmail.com>
	<5df78e1d0807091925q64c0121fk3d33c37df8d80d18@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5df78e1d0807091925q64c0121fk3d33c37df8d80d18@mail.gmail.com>
Subject: Re: [uml-devel] 2.6.25 uml kernel crashes when it calls down() on	a
	semaphore with zero counter
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jiaying Zhang <jiayingz@google.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jul 10, 2008 at 10:25:29AM +0800, Jiaying Zhang wrote:
> Do you have any thought about what the problem might be?
> Thanks a lot!

Yeah, my first thought is that your code is buggy.

Since 2.6.25 seems OK, you can bisect between then and now to see
either what caused the bug or what is triggering the crash on an
existing bug.

The other thing you can do is gdb the UML and see if gdb gives you a
better stack trace.

			Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
