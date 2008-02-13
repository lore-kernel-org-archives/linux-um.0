Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JPLfu-0001kP-6c for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Feb 2008 09:45:38 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JPLfs-0006ED-MS
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Feb 2008 09:45:38 -0800
Date: Wed, 13 Feb 2008 12:45:31 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080213174531.GC12071@c2.user-mode-linux.org>
References: <47B20F17.3050308@gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47B20F17.3050308@gmail.com>
Subject: Re: [uml-devel] [PATCH] uml: adding include/asm generate rule
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
To: Jiri Olsa <olsajiri@gmail.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Feb 12, 2008 at 10:26:47PM +0100, Jiri Olsa wrote:
> Hi,
> 
> I noticed UML does not create include/asm symlink automatically.
> I found this during solving another issue, so I dont know if this
> really helps or it is useless..

This patch must be wrong, since
	include/asm is created by the generic kbuild, not the arch Makefile
	if include/asm wasn't being created, lots and lots of people
would have noticed
	the patch doesn't seem to take O= builds into account

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
