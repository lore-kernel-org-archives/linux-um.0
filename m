Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVWBQ-00056K-IT for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 10:39:24 -0700
Received: from ug-out-1314.google.com ([66.249.92.171])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IVWBP-0000lE-Fa
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 10:39:24 -0700
Received: by ug-out-1314.google.com with SMTP id m2so275987uge
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 12 Sep 2007 10:39:21 -0700 (PDT)
Message-ID: <46E82417.8020501@googlemail.com>
Date: Wed, 12 Sep 2007 19:38:31 +0200
MIME-Version: 1.0
References: <46E81AC6.3000306@googlemail.com> <1189617555.4513.3.camel@chaos>
In-Reply-To: <1189617555.4513.3.camel@chaos>
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [uml-devel] [1/4] 2.6.23-rc6: known regressions
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jakub Jelinek <jakub@redhat.com>, Len Brown <len.brown@intel.com>, "Adrian Bunk \"\"" <bunk@kernel.org>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Stefan Becker <Stefan.Becker@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Markus <lists4me@web.de>, Pavel Machek <pavel@ucw.cz>, linux-alpha@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jeff Dike <jdike@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, "Antonino A. Daplas" <adaplas@gmail.com>

Thomas Gleixner pisze:
> On Wed, 2007-09-12 at 18:58 +0200, Michal Piotrowski wrote: 
>> Subject         : x86_64 vdso patch is broken somehow?
>> References      : http://lkml.org/lkml/2007/8/29/136
>> Last known good : ?
>> Submitter       : Chuck Ebbert <cebbert@redhat.com>
>> Caused-By       : Andi Kleen <ak@suse.de>
>>                   commit 2aae950b21e4bc789d1fc6668faf67e8748300b7
>> Handled-By      : ?
>> Status          : unknown
> 
> Patch available:
> http://lkml.org/lkml/2007/9/11/161

It is already fixed ;)

> 
>> Subject         : cpu hotplug support broken in 2.6.23-rc3/highres timers break cpu hotplug in 2.6.23-rc5
>> References      : http://lkml.org/lkml/2007/8/27/58
>>                   http://lkml.org/lkml/2007/9/3/65
>> Last known good : ?
>> Submitter       : Pavel Machek <pavel@ucw.cz>
>> Caused-By       : ?
>> Handled-By      : ?
>> Status          : problem is being debugged
> 
> This might be the same problem as the jinxed VAIO suspend/resume thingy,
> which is a regression as well.
> 
> Please assign the Handled-By to me.

Ok.

> 
> Thanks,
> 
> 	tglx
> 

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
