Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E47mi-0002Zj-5F	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Aug 2005 18:59:36 -0700
Received: from mx2.elte.hu ([157.181.151.9] helo=mx2.mail.elte.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1E47mh-0005Tp-Pz
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Aug 2005 18:59:36 -0700
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [uml-devel] Re: [RFC] [patch 0/39] remap_file_pages protection
	support, try 2
Message-ID: <20050814020021.GB23795@elte.hu>
References: <200508122033.06385.blaisorblade@yahoo.it>
	<20050812.112954.115910063.davem@davemloft.net>
	<200508122056.11442.blaisorblade@yahoo.it>
	<20050812.120517.65192635.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050812.120517.65192635.davem@davemloft.net>
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
Date: Sun, 14 Aug 2005 04:00:21 +0200
To: "David S. Miller" <davem@davemloft.net>
Cc: blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org, linux-kernel@vger.kernel.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com


* David S. Miller <davem@davemloft.net> wrote:

> From: Blaisorblade <blaisorblade@yahoo.it>
> Date: Fri, 12 Aug 2005 20:56:11 +0200
> 
> > However, I sent the initial tarball containing all them, so I hope
> > that will be useful.
> 
> So not only did you spam the list with 40 patch postings, you sent a 
> second copy of everything as a tarball attachment as well.  That's 
> even worse.
> 
> Please do not abuse the list server in this way, it is a resource that 
> is not just your's, but rather one which has to be shared amongst all 
> folks doing kernel development.

while i agree that 40 patches is not common, i'd like to point out that 
Paolo has sent 40 very nicely split up patches instead of one 
unreviewable monolithic patch, which are the encouraged format for 
kernel changes. I havent seen any hard limit mentioned for patch-bombs 
on lkml before - and i've seen much larger patchbombs going to lkml as 
well, without any followup chastising of the submitter. E.g.:

   Subject: [0/48] Suspend2 2.1.9.8 for 2.6.12

So if there needs to be some limit, it might be worth defining some 
actual hard limit for this.

But the more important point is that given how complex the VM, and in 
particular sys_remap_file_pages_prot() is, i'm personally much more 
happy about the work having been submitted in a split-up way than i am 
unhappy about the bombing!

Paolo has actually worked alot on this, which resulted in 40 real, new 
patches, so i couldnt think of any better way to present this work for 
review. Had he posted some link it would not be individually reviewable. 
(nor could the patch components be picked up by search utilities in that 
case - i frequently search lkml for patches, but naturally i dont 
traverse links referenced in them.) So i think we should rather be happy 
about the 40-patch progress that Paolo has made to Linux, than be 
unhappy about this intense work's effect on our infrastructure.

In other words, we should not be worried about the number of real 
changes submitted to lkml, and we should only hope for that number to 
increase, and we should encourage people to do it! Paolo did this in 2 
weeks, so it's not like he has sent changes accumulated over a long time 
in a patch-bomb. It was real, cutting-edge work very relevant to lkml, 
which work i believe Paolo didnt have much choice submitting in any 
other sensible and reviewable form.

(i think i agree that maybe the tarball should not have been sent - but 
even that one was within the usual size limits and other people send 
tarballs frequently too.)

	Ingo


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
