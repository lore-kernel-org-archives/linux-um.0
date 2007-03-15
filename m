Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HRs6N-0002WC-Ai for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Mar 2007 08:43:08 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HRs6K-0007zO-PE
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Mar 2007 08:42:51 -0700
Date: Thu, 15 Mar 2007 08:14:04 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070315121404.GA3872@ccure.user-mode-linux.org>
References: <20070314141004.GA5116@ccure.user-mode-linux.org>
	<0A01463223B8164194908CAC85B66A1201A96E8B@ZMY16EXM67.ds.mot.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0A01463223B8164194908CAC85B66A1201A96E8B@ZMY16EXM67.ds.mot.com>
Subject: Re: [uml-devel] Regarding Address space in UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Krishnappa Abhijith-A21204 <abhijith@motorola.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Mar 15, 2007 at 11:19:37AM +0800, Krishnappa Abhijith-A21204 wrote:
> So Basically when we run a process in UML, the tracing thread enables
> tracing for that process.

You're talking about THE tracing thread.  This is true if you're
referring to the obsolete tt mode of UML. However, now, the processes
(one per virtual CPU) that run the kernel also do the ptracing.

Your statement is correct, but the terminology is a bit off.

> Also I had a query on creation of a corresponding process on host...
> Why it is done in UML... I mean why a corresponding process gets created
> in HOST ? Is it to catch all the signals that host KERNEL delivers ?

Creating a process on the host is the only way to get a new host address
space.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
