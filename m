Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BToE8-0007ia-BA for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 13:45:16 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BToE7-0004zb-3s
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 13:45:15 -0700
Message-Id: <200405282133.i4SLX1B5002977@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] CVS not updated? 
In-Reply-To: Your message of "Fri, 28 May 2004 21:09:18 +0200."
	<200405282109.18920.blaisorblade_spam@yahoo.it> 
References: <20040518180259.GC29114@ccure.user-mode-linux.org>
	<200405231337.30401.blaisorblade_spam@yahoo.it>
	<20040523214437.GC25780@ccure.user-mode-linux.org>
	<200405282109.18920.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Fri, 28 May 2004 17:33:01 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> Why do you need a private key anywhere? The checkout should be done
> with  pserver (i.e. anonymous CVS); checkout + rebuild should be done
> on the  web-server. The private key is needed only by who writes
> something in the  repo, i.e. you and who you want; obviously public
> key must be stored in  authorized_keys but that is NOT a problem. 

This has nothing to do with CVS.  It has to do with syncing stuff to the
mirrors, which for a lot of them involves an rsync push over ssh.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
