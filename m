Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KJwtF-0000Sw-6j for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jul 2008 13:49:21 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KJwtD-00023n-Mg
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jul 2008 13:49:21 -0700
Date: Fri, 18 Jul 2008 16:49:11 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080718204911.GC13572@c2.user-mode-linux.org>
References: <1214488251-20927-1-git-send-email-bhalevy@panasas.com>
	<g5g5vo$hok$1@ger.gmane.org>
	<20080715162400.GC12154@c2.user-mode-linux.org>
	<g5ir1u$14n$1@ger.gmane.org>
	<20080715201322.GA15836@c2.user-mode-linux.org>
	<487DDF69.9030801@panasas.com> <487DE1B3.1060502@panasas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <487DE1B3.1060502@panasas.com>
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
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, David Shane Holden <dpejesh@yahoo.com>

On Wed, Jul 16, 2008 at 02:55:31PM +0300, Boaz Harrosh wrote:
> BTW I use gcc 4.1 on FC7 and all is fine, but I have an x86_64 machine,
> is this problem i386 only?

It's been seen on both i386 and x86_64.  Initially, it was x86_64.  I
couldn't reproduce it here despite having the same environment and
config as the person reporting it.

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
