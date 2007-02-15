Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HI07J-0008Kz-IP for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 02:15:04 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HI07H-0007lj-C0
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 02:15:01 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 15 Feb 2007 20:29:28 +0100
References: <20070215160001.GA6774@avocado.homenet>
	<20070215170916.GC5641@ccure.user-mode-linux.org>
In-Reply-To: <20070215170916.GC5641@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200702152029.28670.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [UML] fix crash in block layer
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Jason Lunz <lunz@falooley.org>, user-mode-linux-devel@lists.sourceforge.net, Jens Axboe <jens.axboe@oracle.com>

On Thursday 15 February 2007 18:09, Jeff Dike wrote:
> On Thu, Feb 15, 2007 at 11:00:01AM -0500, Jason Lunz wrote:
> > Permit lvm to create logical volumes without crashing UML.
>
> Thanks, this is in my tree.

Hmm, this seems not a _correct_ fix - at least it will be buggy with high 
memory (which we could drop anyway - actually we _should_ drop it probably). 
And at a closer review other potential bugs (or at least misconceptions) 
surface.

The difference between low_pfn and pfn should be just high memory accounting - 
however also uml_reserved enters the picture, and that is bad.

From a closer look, it seems that uml_reserved is ignored for max_low_pfn and 
considered for max_pfn - with your code, you are going to ignore it 
everywhere, while probably you should consider it everywhere (i.e. use 
totalram_pages everywhere) - if it is correct to consider it (and I believe 
the code was written to do all that for an important reason).

The following could be a suggestion, if max_low_pfn is not used between the 
old and the new moment of assignment (and it seems it is not). This is just 
an idea however:

mem_init:

-        max_low_pfn = ...
        /* this will put all low memory onto the freelists */
        totalram_pages = free_all_bootmem();
+        max_low_pfn = totalram_pages;
#ifdef CONFIG_HIGHMEM
        totalhigh_pages = highmem >> PAGE_SHIFT;
        totalram_pages += totalhigh_pages;
#endif
        num_physpages = totalram_pages;
        max_pfn = totalram_pages;

Please note that I did not spend a lot of time on this, so everything could be 
wrong. However, testing cannot help with uml_reserved handling, and this is a 
dark corner.  So things should be better understood before merging the patch.

The code is too convoluted for a brief look - drawing a picture which explains 
all those variables would help. Both for UML and for every arch...

BTW: init_bootmem is not called by us and we probably should - min_low_pfn is 
not initialized.
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
