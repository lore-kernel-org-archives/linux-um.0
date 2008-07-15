Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KInRv-00005P-Qn for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Jul 2008 09:32:23 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KInRv-0003Hx-Am
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Jul 2008 09:32:23 -0700
Date: Tue, 15 Jul 2008 12:32:16 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080715163216.GD12154@c2.user-mode-linux.org>
References: <6d291e080807110053r3980a9dav226c6ea9d8e0b9af@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6d291e080807110053r3980a9dav226c6ea9d8e0b9af@mail.gmail.com>
Subject: Re: [uml-devel] Build Errors
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
To: Stoyan Gaydarov <stoyboyker@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jul 11, 2008 at 02:53:09AM -0500, Stoyan Gaydarov wrote:
> If I did these builds wrong then do let me know what I can
> do to fix them and re-run them so that I can provide some useful
> information in the future. 

There's not a lot of point to tarring up 17 logs when there are only
four distinct failures.  Two of them were due to you not having pcap
or VDE installed on the host.

The next most common one looks like SMP getting turned on somehow.

There's one with some undefined symbols at the very end, which I have
never seen before.

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
