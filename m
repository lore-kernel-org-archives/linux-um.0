Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQ5Jg-00066u-PZ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Apr 2005 08:16:08 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DQ5Je-0004e4-9a for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Apr 2005 08:16:08 -0700
Message-ID: <426D09AF.6030209@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <200504242039.57025.blaisorblade@yahoo.it>
In-Reply-To: <200504242039.57025.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [patch 0/7] uml: some invasive changes for -mm
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
Date: Mon, 25 Apr 2005 17:15:59 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> This is the first of a series of 7 invasive patches for the -mm tree, which 
> are to be reviewed (not only by UML folks), and possibly merged for the 
> 2.6.13 cycle.
> 
> The first one splits the i386 syscall table out of entry.S, without any real 
> change for them (the file is included in the old place); if there are any 
> syscall table changes, please be careful; this maybe means place *this* one 
> before the others (or even merge now the i386 code movement part); I don't 
> want that this patch is modified and that subtle bugs are introduced. The 
> code movement is a really trivial code movement, however (no hidden changes).
> 
> This is needed to enable us to include the i386 syscall table, so that we are 
> sure that they match. I already handled the real differences between i386 and 
> UML (see the patch).
I love this idea and it fits well to UML/s390, where syscall table already
lives in a separate source.
As change and grow of syscall tables is not really coordinated between different
arches, this change will simplify maintenance of UML-subarches a lot.

		Bodo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
