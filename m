Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IvDKo-0003ln-20 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Nov 2007 06:47:18 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IvDKm-000635-J2
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Nov 2007 06:47:18 -0800
Date: Thu, 22 Nov 2007 09:47:13 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071122144713.GC4813@c2.user-mode-linux.org>
References: <474575F8.3070400@gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <474575F8.3070400@gmail.com>
Subject: Re: [uml-devel] uml git tree
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

On Thu, Nov 22, 2007 at 01:28:40PM +0100, Jiri Olsa wrote:
> I'd like to ask if there's any UML git repository.

No, I keep track of my patches with quilt.

> If there isnt, whats the devel process. How often you merge to Linus tree?

I send stuff to -mm for testing.  Bug fixes I request be sent to Linus
in the current release.  Non-urgent stuff sits in -mm until the next
merge window.  Patches go to Andrew on a near-daily basis.

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
