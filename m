Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5HWv-0001HK-Qb for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 22:31:33 -0700
Received: from parcelfarce.linux.theplanet.co.uk
	([195.92.249.252] helo=www.linux.org.uk ident=93)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C5HWt-0001WV-0X
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 22:31:33 -0700
Message-ID: <413FEA72.2030705@pobox.com>
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Current state of UML - some help needed from mainline.
References: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>
	<413B76DB.5010600@pobox.com>
	<200409061956.34557.blaisorblade_spam@yahoo.it>
	<200409072013.49494.blaisorblade_spam@yahoo.it>
In-Reply-To: <200409072013.49494.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Thu, 09 Sep 2004 01:30:26 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

BlaisorBlade wrote:
> For LKML: I'm not subscribed, so don't forget to CC me.
> On Monday 06 September 2004 19:56, BlaisorBlade wrote:
> 
>>On Sunday 05 September 2004 22:28, Jeff Garzik wrote:
>>
>>>Overall I am really impressed.  Like other arches in the Linux kernel,
>>>it is IMO very important to be able to work "out of the box", without
>>>patches.
> 
> Yes - especially when microAPI changes happen every day, as of 2.6. I've just 
> downloaded a snapshot including the merge, so I'll be able to merge some 
> little fixes which have happened since.
> 
> Do you think that keeping a UML tree for new, experimental features is a good 
> idea, or that this role should go to -mm?
> 
> I ask this also because I don't know how much would help general review for 
> new features.

It's up to you.  Andrew pulls several BitKeeper trees into his -mm tree, 
so you could do both if you wished.  If you do that, though, just make 
sure that the code you push is in a state that's ready for review and 
testing :)


> For instance, the "hostfs" feature is in the middle of a rewrite and the new 
> code is still very broken (the current release says more or less "VFS: busy 
> inodes after unmount - self destroying in 5 seconds. Have a nice day", but 
> maybe this is fixed; plus has a number of other bugs).

I usually create a new "patch queue" for experimental features, to make 
sure that (a) it's seperated from the main testing branch but (b) it's 
easy to merge it back into the main testing branch when it's ready.  If 
you use BitKeeper, this is accomplished simply by creating another 
cloned repository.

	Jeff




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
