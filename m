Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BAz3D-0005ii-M8 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Apr 2004 15:28:11 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BAz3C-0002wq-Uh for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Apr 2004 15:28:11 -0700
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] klogd stimulates kernel panic w/ 2.4.24-1
In-Reply-To: <4072F711.8030209@nortelnetworks.com>
Message-ID: <Pine.LNX.4.44.0404070025380.15387-100000@filer.marasystems.com>
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
Date: Wed, 7 Apr 2004 00:28:00 +0200 (CEST)
To: Joe Marzot <gmarzot@nortelnetworks.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 6 Apr 2004, Joe Marzot wrote:

> There was also mention of a code fix in UML...which would be preferable 
> since I like klogd :)
> 
> Is there a patch for 2.4.24 which supports this?

Still waiting for Jeff to publish the required changes.. have patience.

Apparently it also depends on general Linux fixes outside of UML so 
probably 2.4.26 will be required to fix this proper, and maybe is why the 
fix has not been published yet?

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
