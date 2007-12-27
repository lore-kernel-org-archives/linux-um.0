Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J7iWF-0005G2-30 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Dec 2007 18:30:49 -0800
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J7iWD-0000Zj-QQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Dec 2007 18:30:47 -0800
Received: by wa-out-1112.google.com with SMTP id k22so4781629waf.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 26 Dec 2007 18:30:45 -0800 (PST)
Message-ID: <47730E4A.3000007@gmail.com>
Date: Wed, 26 Dec 2007 18:30:34 -0800
From: Todd Jackson <quantum.skyline@gmail.com>
MIME-Version: 1.0
References: <4772D501.6050306@gmail.com>
	<20071227004239.GB8218@c2.user-mode-linux.org>
In-Reply-To: <20071227004239.GB8218@c2.user-mode-linux.org>
Subject: Re: [uml-devel] __attribute_used__ error on 2.6.23.9
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
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> On Wed, Dec 26, 2007 at 02:26:09PM -0800, Quantum Skyline wrote:
>> Hi,
>>
>> I've been trying to modify the UML makefiles in the 2.6.23.9 kernel to 
>> compile against a different C library, but I'm running into trouble 
>> getting parts of UML to compile with GCC 4.2.1.  In particular, files in 
>> os-Linux that use functions like __uml_setup are causing GCC to throw 
>> errors.
>>
>> For example, when I try to compile arch/um/os-Linux/aio.c in my 
>> environment, I get the following:
>>
>> gcc-4.2.1-rev -Wp,-MD,arch/um/os-Linux/.aio.o.d  -Wall -Wundef 
>> -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common 
>> -Werror-implicit-function-declaration -Os -D__arch_um__ 
>> -DSUBARCH=\"i386\" -Dvmap=kernel_vmap 
>> -Din6addr_loopback=kernel_in6addr_loopback 
>> -Din6addr_any=kernel_in6addr_any -march=i686 
>> I know that __uml_setup and friends are defined in 
>> arch/um/include/init.h and it is being included, but it seems like GCC 
>> is not using it.  If I comment out __uml_setup, other files which have 
>> functions starting with two underscores like __uml_initcall also cause 
>> compilation to fail.
>>
>> Can anyone give some hints to solve this problem?
> 
> Probably you need the patch below.
> 
> 				Jeff
> 


Hi Jeff,

That patch didn't work...I'm still seeing the same error with the patch 
applied.

Is there anything glibc-specific that UML depends on?

Cheers,

Todd

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
