Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQ7Qm-0000JB-GO for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 09:27:04 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BQ7Ql-0003Tr-NC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 09:27:03 -0700
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] 2.4.24-2 UML problems with hostfs ClearCase mounts
In-Reply-To: <40AA2F06.6020607@nortelnetworks.com>
Message-ID: <Pine.LNX.4.44.0405181824230.8450-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 18 May 2004 18:26:46 +0200 (CEST)
To: Joe Marzot <gmarzot@nortelnetworks.com>
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Tue, 18 May 2004, Joe Marzot wrote:

> Thank you so much for the reply - For the most part existing hostfs 
> support has been fine for me (I need the sync behaviour).
> 
> However with 2.4.24-1 I am still getting kernel panic crashes and it 
> looked like some crashes were handled in 2.4.24-2. I will try to pick 
> through the 2.4.24-2 patch and take just the not hostfs parts.

Pathes making hostfs usable in both 2.4.24-2 and 2.4.26-1 is available 
from http://marasystems.com/download/

> I do have loads of cores if anyone is interested since I hacked the 
> panic code to abort() as I was not catching these intermittent crashes 
> very often.

stack traces of the panics is more interesting (extract from the core
using gdb and the exact binary the core was generated from)..  even more
so if you find a common pattern and have some suspicion on how/when it may
occur.

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
