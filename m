Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KInJy-0007X4-DW for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Jul 2008 09:24:10 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KInJw-0008Fo-QG
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Jul 2008 09:24:10 -0700
Date: Tue, 15 Jul 2008 12:24:00 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080715162400.GC12154@c2.user-mode-linux.org>
References: <1214488251-20927-1-git-send-email-bhalevy@panasas.com>
	<g5g5vo$hok$1@ger.gmane.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <g5g5vo$hok$1@ger.gmane.org>
Subject: Re: [uml-devel] [PATCH] fix extern inline errors with gcc 4.3.0
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
To: David Shane Holden <dpejesh@yahoo.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Jul 14, 2008 at 11:30:15AM -0700, David Shane Holden wrote:
> I tried to build a UML 2.6.26 kernel on Debian (32-bit) and ran into the 
> same problem reported here http://marc.info/?t=121011533500002&r=1&w=2. 

It's really 2.6.26, and not something from a day or two earlier?  I
fixed the compilation bugs, supposedly, just before 2.6.26.

>   If I use gcc 4.3 everything works fine, but if I use gcc 4.1 or 4.2, 
> UML crashes on startup.

If the crash says ptrace in it, then I'm currently trying to figure
out what's happening with that.

> Also, is there any chance of getting a SKAS4 patch against 2.6.26?

Yup, I'm working on it...

     	 	    Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
