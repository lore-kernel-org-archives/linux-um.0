Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KCrP3-0005v1-6X for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Jun 2008 00:32:53 -0700
Received: from ik-out-1112.google.com ([66.249.90.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KCrP0-00077p-GT
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Jun 2008 00:32:53 -0700
Received: by ik-out-1112.google.com with SMTP id c21so430878ika.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 29 Jun 2008 00:32:49 -0700 (PDT)
Message-ID: <48673A9B.8050907@panasas.com>
Date: Sun, 29 Jun 2008 10:32:43 +0300
From: Benny Halevy <bhalevy@panasas.com>
MIME-Version: 1.0
References: <1214488251-20927-1-git-send-email-bhalevy@panasas.com>
	<20080627162645.GC8381@c2.user-mode-linux.org>
	<7225594ED4A1304C9E43D030A886D221050BE1@daytona.int.panasas.com>
In-Reply-To: <7225594ED4A1304C9E43D030A886D221050BE1@daytona.int.panasas.com>
Subject: [SPAM] Re: [uml-devel] [PATCH] fix extern inline errors with gcc 4.3.0
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
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Jun. 28, 2008, 16:10 +0300, "Halevy, Benny" <bhalevy@panasas.com> wrote:
> On Fri 2008-06-27 19:26, Jeff Dike <jdike@addtoit.com> wrote:
>> On Thu, Jun 26, 2008 at 04:50:51PM +0300, Benny Halevy wrote:
>>> -KBUILD_CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
>>> +# Disable unit-at-a-time mode on pre-gcc-4.3 compilers, it makes gcc use
>>> +# a lot more stack due to the lack of sharing of stacklots:
>>> +# gcc 4.3.0 needs -funit-at-a-time for extern inline functions
>>> +KBUILD_CFLAGS += $(shell if [ $(call cc-version) -lt 0403 ] ; then \
>>> +			echo $(call cc-option,-fno-unit-at-a-time); fi ;)
>> How do we know that this patch won't cause the same crash reported in
>> http://marc.info/?l=linux-kernel&m=121011722806093&w=2?

Note that the crash happened with gcc 4.1.2 and it will get the
-fno-unit-at-a-time flag with the proposed patch.

That said, this option or the lack of it ought not to cause any
runtime crashes.  If it does, I'd feel much more comfortable to know
exactly what the root cause is before deciding to use the flag to
workaround^hide it.

Benny

> 
> I don't know what was the root cause for the crash you mentioned.
> FWIW, with these options UML/x86_64 builds on Fedora 9, w/ gcc 4.3.0
> and runs well for me.
> 
> Benny
> 
>> 				Jeff
>>
>> -- 
>> Work email - jdike at linux dot intel dot com
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
