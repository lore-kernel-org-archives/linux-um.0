Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlwBn-0001FM-EQ	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Jun 2005 14:58:19 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DlwBl-0005fA-JL	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Jun 2005 14:58:19 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] os_lock_file removal
Message-ID: <20050624211533.GA10972@ccure.user-mode-linux.org>
References: <42BC5CD9.2080005@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BC5CD9.2080005@oracle.com>
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
Date: Fri, 24 Jun 2005 17:15:33 -0400
To: Allan Graves <allan.graves@oracle.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jun 24, 2005 at 03:19:53PM -0400, Allan Graves wrote:
> Hi guys.  I'm working on developing a cluster file system and I'd like 
> to simulate concurrent shared storage access using uml and disk files.  
> I traced down the file locking, and it seems that (assuming I have a 
> cluster file system that keeps things up to date in the metadata of the 
> filesystem) if I remove this function I should be able to have more than 
> 1 instance accessing storage at the same time.  

Feel free to remove it if you personally guarantee that you will not run
two UMLs on the same host file without using a clusterfs.

It's purely a safety measure - if you're doing development using scratch
filesystems, it's not really benefitting you.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
