Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cojzr-0006Jy-PO for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 07:01:19 -0800
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cojzp-000587-TH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 07:01:19 -0800
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] df -h and hostfs
In-Reply-To: <200501120110.32416.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0501121555010.31072@filer.marasystems.com>
References: <62845.80.203.0.208.1105438274.squirrel@80.203.0.208>
	<200501120110.32416.blaisorblade@yahoo.it>
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
Date: Wed, 12 Jan 2005 15:56:08 +0100 (CET)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, stian@nixia.no

On Wed, 12 Jan 2005, Blaisorblade wrote:

> Yes, good idea... fixing it like you said will guarantee correct free space
> stats (apart for quotas) but not correct used-space and total-space stats
> (they would be possible only for humfs if it uses some accounting).

It will be as good as if the root was NFS mounted, which is what most 
people expect.

Regards
Henrik


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
