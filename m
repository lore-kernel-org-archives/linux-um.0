Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CM0g4-0006TY-S7 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 01:58:08 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CM0g3-0004gw-2U for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 01:58:08 -0700
Message-ID: <417CC1D7.7000605@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] What to send to Andrew next
References: <200410220516.i9M5GwFL007932@ccure.user-mode-linux.org>
	<200410221852.27232.blaisorblade_spam@yahoo.it>
	<200410222128.i9MLSmWY005910@ccure.user-mode-linux.org>
In-Reply-To: <200410222128.i9MLSmWY005910@ccure.user-mode-linux.org>
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
Date: Mon, 25 Oct 2004 11:05:27 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> blaisorblade_spam@yahoo.it said:
> 
>>1) FOR INSTANCE, I sent the patch avoiding SIGPROF being touched by
>>change_signals(). Why did not you bother at it? 
>>2) copy_from_user_skas() does not make sense. When accessing the page
>>tables,  they would be happy to get some locking. If you want to take
>>a look to the  4G-4G patch from Ingo Molnar, which must do something
>>identical,  
> 
> 
> Because I lost them, probably.  I'll go look for them.
> 
> 
>>Well, yes, but let's try to be fast on these. They are very good
>>patches and  fix also security problems. 
> 
> 
> Yeah, syscall-security-* can go in now.  I want to see his test cases before
> pushing the signal delivery stuff though.
> 
> 
I'm working to integrate the bulk of tiny tests into a few more handy programs,
they will be mailed as fast as possible.

On your list of incremental patches, there are still missing syscall-security-4
and -5, which fix a bug and a incorrect interpretation in the previos patches.
Is this intentionally?

And to close all holes I've seen so far, the TRACESYSGOOD patches are needed
(Test-case included in breakout.c).

Bodo


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
