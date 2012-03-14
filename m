Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stian@nixia.no>) id 1S7ie4-0001P8-1h
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Mar 2012 07:29:16 +0000
Received: from [195.159.66.52] (helo=lauken.nlc.no)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S7idv-0004Uk-HV for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Mar 2012 07:29:16 +0000
Message-ID: <3c4d14d64492ddd8be406d4a15f1ee63.squirrel@nlc.no>
In-Reply-To: <4F5FDF42.90004@nod.at>
References: <4F5FCC7D.5090307@panasas.com> <4F5FDF42.90004@nod.at>
Date: Wed, 14 Mar 2012 08:28:59 +0100
From: "Stian Skjelstad" <stian@nixia.no>
MIME-Version: 1.0
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
Subject: Re: [uml-devel] UML: Please help with __module_text_address crashing
To: Richard Weinberger <richard@nod.at>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

> Am 13.03.2012 23:38, schrieb Boaz Harrosh:
>> Since a while now my UMLs are constantly crashing in
>> __module_text_address
>>
>> which makes no sense because if I do gdb>  list
>> *(__module_text_address+0xd)
>> I get:t
>>
>> 0x6005614e is in __module_text_address
>> (/media/usr0/export/dev/bharrosh/git/pub/linux-open-osd/kernel/module.c:3469).
>> 3464     * module doesn't get freed during this.
>> 3465     */
>> 3466    struct module *__module_text_address(unsigned long addr)
>> 3467    {
>> 3468            struct module *mod = __module_address(addr);
>> 3469            if (mod) {
>> 3470                    /* Make sure it's within the text section. */
>> 3471                    if (!within(addr, mod->module_init,
>> mod->init_text_size)
>> 3472&&  !within(addr, mod->module_core, mod->core_text_size))
>> 3473                            mod = NULL;

source listing vs where it crashes can be off aslong as you use CFLAGS
with -On where n is greater than 0. So the first thing you can test is to
compile UML with CFLAGS="-g -O0". It might be that it doesn't crash
anymore then, if so, you can try to play with different gcc optimization
flags in order to find out what triggers it.

Other sources of the crash can be gcc bugs, or some special CPU
optimization BUG (either in gcc or the UML source).

Your backtrace also included spin-lock right before the panic, which could
be the source of the issue. If I remember right, the kernel has some debug
options that can be enabled for spin-locks.

Stian Skjelstad


------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

