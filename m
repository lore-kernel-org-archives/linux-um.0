Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J66b6-0006Qv-WA for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Dec 2007 07:49:09 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J66b6-0008OM-Co
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Dec 2007 07:49:08 -0800
Date: Sat, 22 Dec 2007 10:49:01 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071222154901.GA4756@c2.user-mode-linux.org>
References: <ea11fea30712200923j3f6e73dal46b158f7fd084303@mail.gmail.com>
	<20071221213413.GA8405@c2.user-mode-linux.org>
	<ea11fea30712220611v7f4a87fcpafa151ec25734bfd@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ea11fea30712220611v7f4a87fcpafa151ec25734bfd@mail.gmail.com>
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

On Sat, Dec 22, 2007 at 07:41:09PM +0530, Manish Katiyar wrote:
> Hi Jeff,
> 
> I chose the default options while kernel building. Do I need to do
> anything specific to enable loop support ? ..What should i check to
> see if it is enabled or not ?. 

% grep LOOP arch/um/defconfig
CONFIG_BLK_DEV_LOOP=m

So you can either modprobe the module or configure it as built-in.

> also
> http://user-mode-linux.sourceforge.net/dl-ists.html link is not
> working to download the patches. Could you please check if the link is
> broken.

Those links are all obsolete anyway.

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
