Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C9q3i-0007rA-QN for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Sep 2004 12:12:14 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1C9q3g-00061Q-S4 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Sep 2004 12:12:14 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] Managing 2.6 merge - url for the patches sent to merge
In-Reply-To: <200409212001.43965.blaisorblade_personal@yahoo.it>
Message-ID: <Pine.LNX.4.61.0409212105590.32104@filer.marasystems.com>
References: <200409181944.58072.blaisorblade_personal@yahoo.it>
	<200409202030.49422.blaisorblade_personal@yahoo.it>
	<200409210321.i8L3LgdR015667@ccure.user-mode-linux.org>
	<200409212001.43965.blaisorblade_personal@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Tue, 21 Sep 2004 21:11:45 +0200 (CEST)
To: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Gerd Knorr <kraxel@bytesex.org>

On Tue, 21 Sep 2004, Paolo Giarrusso wrote:

>> Mysteriously, setting that descriptor
>> CLOEXEC doesn't seem to help.
> No, this problem seems to go away on 2.6 hosts (at least, that's my random
> experience). It seems, so, a 2.4 host bug.
>
> See this patch from Henrik Normstrod for a workaround:
>
> http://marasystems.com/download/uml/10-flock.patch

When I looked into this problem I concluded the fcntl locks in the host 
kernel got completely messed up by the cloning or something similar. Using 
flock works just as good assuming the ubd files is local and is not 
plauged by the same host bug. Most likely the host gets confused by the 
close being done from another pid than who issued the lock.

The host bug is not limited to rebooting only, the lock is permanent and 
will stay forever. In fact I suspect the CLOEXEC flag as such is working, 
it is just that the host does not realize the lock belongs to this fd.

This Linux kernel issue can probably be utilized to play some interesting 
DOS games on Linux systems where you have a account or otherwise the 
ability to run code, but I have not cared to investigate the exact details 
closely.

Regards
Henrik


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
