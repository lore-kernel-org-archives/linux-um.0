Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1RwgYZ-00083S-SR
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Feb 2012 21:01:59 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RwgYY-0005uT-CI
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Feb 2012 21:01:59 +0000
Message-ID: <4F3828BD.7070809@nod.at>
Date: Sun, 12 Feb 2012 22:01:49 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <20120130192552.GL23916@ZenIV.linux.org.uk>
	<1328311063-17630-1-git-send-email-richard@nod.at>
	<20120204001431.GY23916@ZenIV.linux.org.uk>
	<4F2C7F7A.1090605@nod.at>
	<20120212202728.GR23916@ZenIV.linux.org.uk>
In-Reply-To: <20120212202728.GR23916@ZenIV.linux.org.uk>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: Cleanup headers files
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Am 12.02.2012 21:27, schrieb Al Viro:
>> So, I pulled your work and merged it into my shiny new UML tree:
>> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
>
> Hmm...  I would really, really recommend you to clean the git history in that
> tree up.  As it is, you have
> 	* merge of that branch from um-headers
> 	* um: Switch to large mcmodel on x86_64
> 	* um: Serve io_remap_pfn_range()
> 	* 205 merges from Linus, from mid-April to late January.
> 	* mismerge from Linus on April 14; the diff between the result

Okay, I'll create a new tree. This one is definitely screwed.
Sorry for the inconvenience.

Thanks,
//richard

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

