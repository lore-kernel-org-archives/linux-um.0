Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CL5sZ-0002Q5-Vw for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 13:19:15 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CL5sY-0005wT-Jf
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 13:19:15 -0700
Message-Id: <200410222128.i9MLSmWY005910@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] What to send to Andrew next 
In-Reply-To: Your message of "Fri, 22 Oct 2004 18:52:27 +0200."
	<200410221852.27232.blaisorblade_spam@yahoo.it> 
References: <200410220516.i9M5GwFL007932@ccure.user-mode-linux.org>
	<200410221852.27232.blaisorblade_spam@yahoo.it> 
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
Date: Fri, 22 Oct 2004 17:28:48 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

blaisorblade_spam@yahoo.it said:
> 1) FOR INSTANCE, I sent the patch avoiding SIGPROF being touched by
> change_signals(). Why did not you bother at it? 
> 2) copy_from_user_skas() does not make sense. When accessing the page
> tables,  they would be happy to get some locking. If you want to take
> a look to the  4G-4G patch from Ingo Molnar, which must do something
> identical,  

Because I lost them, probably.  I'll go look for them.

> Well, yes, but let's try to be fast on these. They are very good
> patches and  fix also security problems. 

Yeah, syscall-security-* can go in now.  I want to see his test cases before
pushing the signal delivery stuff though.

> And why on x86_64 you do: #define NR_syscalls 1024 

> irq-bits - needed for mainline updates at least since -bk4, but not
> complete. 

?  That's removing code that's duplicated now in -mm but not mainline.

Not sure, that was in the patch I have left over from earlier this year, and
I don't remember why it's there.

Looks like we largely agree.  I'm not going to get to push stuff Andrew-ward 
until Sunday at least, so feel free to send stuff in beforehand.

				Jeff




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
