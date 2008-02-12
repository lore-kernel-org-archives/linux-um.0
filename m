Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JP2eL-0002r2-KB for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Feb 2008 13:26:46 -0800
Received: from fg-out-1718.google.com ([72.14.220.157])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JP2eJ-0000ur-TI
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Feb 2008 13:26:45 -0800
Received: by fg-out-1718.google.com with SMTP id d23so4187370fga.32
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 Feb 2008 13:26:42 -0800 (PST)
Message-ID: <47B20F0F.3050401@gmail.com>
Date: Tue, 12 Feb 2008 22:26:39 +0100
From: Jiri Olsa <olsajiri@gmail.com>
MIME-Version: 1.0
References: <47AF5930.5080907@gmail.com>
	<20080211231812.GC10369@c2.user-mode-linux.org>
In-Reply-To: <20080211231812.GC10369@c2.user-mode-linux.org>
Subject: Re: [uml-devel] compile problem
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
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Hi,

<asm/types.h> declares u32 only if there's __KERNEL__ defined, which is not case
of UML compile.

I found out the ptrace-abi.h is changed in the 2.6.24.1 and differs with the Linus
tree among others with adding following structure:

struct ptrace_bts_config {
        /* requested or actual size of BTS buffer in bytes */
        u32 size;
        /* bitmask of below flags */
        u32 flags;
        /* buffer overflow signal */
        u32 signal;
        /* actual size of bts_struct in bytes */
        u32 bts_size;
};

so thats where the u32 cames from in the Linus' tree.

Now when I know why my Linus' tree wont compile, I'd like to know why yours does :)
(I used your patch regarding the foo function errors as well...)
Maybe I have smth wrong with my headers, I use following symlinks:

/usr/include/linux -> $(kernel)/include/linux
/usr/include/asm -> $(kernel)/include/asm-x86
/usr/include/asm-generic -> $(kernel)/include/asm-generic


thanks,
jirka


Jeff Dike wrote:
> On Sun, Feb 10, 2008 at 09:06:08PM +0100, Jiri Olsa wrote:
>> Hi,
>>
>> I have problem with last Linus' git tree:
>>
>> scripts/kconfig/conf -s arch/um/Kconfig
>>   SYMLINK arch/um/include/kern_constants.h
>>   SYMLINK arch/um/include/sysdep
>>   CHK     arch/um/include/uml-config.h
>>   UPD     arch/um/include/uml-config.h
>>   CC      arch/um/sys-i386/user-offsets.s
>> In file included from /usr/include/asm/ptrace.h:5,
>>                  from arch/um/sys-i386/user-offsets.c:7:
>> /usr/include/asm/ptrace-abi.h:92: error: expected specifier-qualifier-list before 'u32'
> 
> This looks like a bug in your headers.  ptrace-abi includes
> <asm/types.h>, apparently to get the likes of u32, but they're not
> there.
> 
>> arch/um/sys-i386/user-offsets.c: In function 'foo':
>> arch/um/sys-i386/user-offsets.c:20: error: 'struct sigcontext' has
>> no member named 'eip'
> 
> This is a bit of a problem.  You installed new headers, which have the
> 'e' removed from the register names, but I can't just change UML
> because that will break compilation on current hosts with existing
> headers.
> 
> 				Jeff
> 



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
