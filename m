Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ahlongxp@gmail.com>) id 1LOR4e-0003sl-Ej
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2009 06:23:56 +0000
Received: from rv-out-0708.google.com ([209.85.198.244])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LOR4W-0002Od-CC for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2009 06:23:56 +0000
Received: by rv-out-0708.google.com with SMTP id f25so2204246rvb.22
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 17 Jan 2009 22:23:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200901170328.15178.rob@landley.net>
References: <20090115194033.GA10926@hack.private>
	<20090116124158.4364e269.akpm@linux-foundation.org>
	<200901170328.15178.rob@landley.net>
Date: Sun, 18 Jan 2009 14:23:46 +0800
Message-ID: <dc84318c0901172223p57872a8cr227d940b1c0a908a@mail.gmail.com>
From: Daolong Wang <ahlongxp@gmail.com>
Subject: Re: [uml-devel] [Patch] uml: fix a link error
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
To: Rob Landley <rob@landley.net>
Cc: =?ISO-8859-1?Q?Am=E9rico_Wang?= <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

I can confirm this link error. And this patch works for me.

On Sat, Jan 17, 2009 at 5:28 PM, Rob Landley <rob@landley.net> wrote:
> On Friday 16 January 2009 14:41:58 Andrew Morton wrote:
>> > diff --git a/arch/um/sys-i386/sys_call_table.S
>> > b/arch/um/sys-i386/sys_call_table.S index 00e5f52..04147dc 100644
>> > --- a/arch/um/sys-i386/sys_call_table.S
>> > +++ b/arch/um/sys-i386/sys_call_table.S
>> > @@ -6,6 +6,7 @@
>> >
>> >  #define sys_vm86old sys_ni_syscall
>> >  #define sys_vm86 sys_ni_syscall
>> > +#define sys_sigprocmask sigprocmask
>> >
>> >  #define old_mmap old_mmap_i386
>>
>> For how long has this problem been present?
>>
>> Why aren't lots of other people reporting it?
>
> I'm not sure User Mode Linux still has a lot of users regularly testing the
> latest and greatest version.  (QEMU and KVM kinda took the wind out of its
> sails.)
>
> I still find it useful to be able to stick printfs into the code and debug
> stuff even when the console isn't working, but I haven't been able to build a
> version of 2.6.28 that works for me at all:
>
> cat > mini.conf << EOF
> CONFIG_BINFMT_ELF=y
> CONFIG_HOSTFS=y
> CONFIG_LBD=y
> CONFIG_BLK_DEV=y
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_STDERR_CONSOLE=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_EXT2_FS=y
> CONFIG_EXT3_FS=y
> CONFIG_STATIC_LINK=y
> CONFIG_NO_HZ=y
> CONFIG_UNEVICTABLE_LRU=y
> EOF
> make ARCH=um allnoconfig KCONFIG_ALLCONFIG=mini.conf
> make ARCH=um -j 3
> ./linux rw init=/bin/bash rootfstype=hostfs
>
> The result panics (twice) and exits, instead of giving me a shell prompt.
> Built and run on stock Ubuntu 8.10.  (I posted about it on tuesday, but nobody
> replied...)
>
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
