Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J6CxV-0008PN-BT for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Dec 2007 14:36:43 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J6CxS-0000Z6-MP
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Dec 2007 14:36:41 -0800
Date: Sat, 22 Dec 2007 17:36:31 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071222223631.GA7032@c2.user-mode-linux.org>
References: <ea11fea30712200923j3f6e73dal46b158f7fd084303@mail.gmail.com>
	<20071221213413.GA8405@c2.user-mode-linux.org>
	<ea11fea30712220611v7f4a87fcpafa151ec25734bfd@mail.gmail.com>
	<20071222154901.GA4756@c2.user-mode-linux.org>
	<ea11fea30712220900m12d18266ic115a517d2ee8196@mail.gmail.com>
	<20071222174013.GA5949@c2.user-mode-linux.org>
	<ea11fea30712221106s377111fepbdea5bb7d30437e@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ea11fea30712221106s377111fepbdea5bb7d30437e@mail.gmail.com>
Subject: Re: [uml-devel] [uml-user] Error mounting filesystems on -o loop
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
To: Manish Katiyar <mkatiyar@gmail.com>
Cc: UML-user <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Dec 23, 2007 at 12:36:02AM +0530, Manish Katiyar wrote:
> Why is it not able to allocate memory ??/

The obvious reason - there is no memory to allocate and you gave it no
swap?  So give it more memory or some swap space.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
