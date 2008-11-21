Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1L3ZTp-00014t-6W
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Nov 2008 17:07:41 +0000
Received: from nf-out-0910.google.com ([64.233.182.186])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L3ZTl-0002ca-VD for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Nov 2008 17:07:41 +0000
Received: by nf-out-0910.google.com with SMTP id g16so498919nfd.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 21 Nov 2008 09:07:35 -0800 (PST)
Date: Fri, 21 Nov 2008 17:07:11 +0000
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Message-ID: <20081121170711.GA23653@hack.voiplan.pt>
References: <20081118174250.GE3185@hack.voiplan.pt>
	<20081118192626.GU28946@ZenIV.linux.org.uk>
	<20081119184014.GD22898@hack.voiplan.pt>
	<20081119190636.GW28946@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081119190636.GW28946@ZenIV.linux.org.uk>
Subject: Re: [uml-devel] [Patch] uml: fix undeclared variables
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
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Wed, Nov 19, 2008 at 07:06:36PM +0000, Al Viro wrote:
>On Wed, Nov 19, 2008 at 06:40:14PM +0000, Am??rico Wang wrote:
>> On Tue, Nov 18, 2008 at 07:26:26PM +0000, Al Viro wrote:
>> >On Tue, Nov 18, 2008 at 05:42:51PM +0000, Am??rico Wang wrote:
>> >> 
>> >> Fix three compile errors about undeclared variables in
>> >> arch/um/kernel/mem.c.
>> >
>> >And what, pray tell, would initialize it?
>> 
>> Sorry, I can't fully understand you. I got the following error:
>> 
>> arch/um/kernel/mem.c: In function ???init_highmem???:
>> arch/um/kernel/mem.c:177: error: ???pkmap_page_table??? undeclared (first
>> use in this function)
>> arch/um/kernel/mem.c:177: error: (Each undeclared identifier is
>> reported only once
>> arch/um/kernel/mem.c:177: error: for each function it appears in.)
>
>The error is there, all right.  However, proposed patch only hides the
>real problem.  Building uml/i386 with CONFIG_HIGHMEM will result in
>a badly broken kernel with that patch, with no visible hints at the
>cause of problems.
>
>You've got it to link, but that's not enough.  The problems you are seeing
>come from arch/x86/mm/highmem_32.c.  It uses several variables from
>arch/x86/mm/init_32.c and you have copied them to arch/um.  However, getting
>these variable defined is not going to make it work - the code that used
>to set it had been in init_32.c too and you've just left your copy initialized
>to NULL.  Which will *not* work.
>

Thanks for teaching this! I will look deep into this problem.


-- 
"Sometimes the only way to stay sane is to go a little crazy."


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
