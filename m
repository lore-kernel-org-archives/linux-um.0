Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRG5Z-00018H-QF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 15:02:57 -0700
Received: from smtp-out.google.com ([216.239.45.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRG5Z-0003TJ-NO
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 15:02:57 -0700
Message-ID: <44343E86.30301@google.com>
From: Daniel Phillips <phillips@google.com>
MIME-Version: 1.0
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org>
	<20060324144535.37b3daf7.akpm@osdl.org>
	<20060325010524.GA8117@ccure.user-mode-linux.org>
In-Reply-To: <20060325010524.GA8117@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [PATCH 12/16] UML - Memory hotplug
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 05 Apr 2006 15:02:46 -0700
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> This is the big question with this patch.  How incestuous do I want to
> get with the VM system in order to get it to free up pages?  For now,
> I decided to be fairly hands-off, allocate as many pages as I can get,
> and return the total number to the host.  The host, if it wasn't happy
> with the results, can wait a bit while the UML notices that it is
> really low on memory and frees some up, and then hit up the UML for
> the remainder.

And also wrote:
> page = alloc_page(GFP_ATOMIC);

A slightly different objection than Andrew's: this will rapidly eat up
all the pages available for, e.g., receiving network packets, probably
not what you want.  How about flags=0?  This will dip a little way into
reserves but not as far as interrupts or realtime tasks, and will not
attempt any reclaim.  (Maybe we should have a GFP define for that.)

> INIT_LIST_HEAD(&unplugged->list);
> list_add(&unplugged->list, &unplugged_pages);

You don't need to initialize the list element you are adding.

Regards,

Daniel


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
