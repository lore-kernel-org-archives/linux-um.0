Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cdpoj-00056Z-Pk for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Dec 2004 05:00:45 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cdpoi-000376-6o for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Dec 2004 05:00:45 -0800
Message-ID: <41BD9270.9020102@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <200412101645.iBAGjWA13367@trolli.pdb.fsc.net>
	<200412102228.07984.blaisorblade_spam@yahoo.it>
In-Reply-To: <200412102228.07984.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [patch 1/1] make arch/um/kernel/skas/include/skas.h
	include asm/types.h
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
Date: Mon, 13 Dec 2004 14:00:32 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> On Friday 10 December 2004 17:45, bstroesser@fujitsu-siemens.com wrote:
> 
>>From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
>>
>>make arch/um/kernel/skas/include/skas.h include asm/types.h
>>This is necessary to have a typedef for __u64
> 
> 
> *Probably* won't work, as headers in arch/um/include.... are also includable 
> by userspace files, which can't include <asm/types.h>;
My patch changes arch/um/kernel/skas/include/skas.h, which is included by
arch/um/kernel/process.c, arch/um/sys-XXXX/signal.c and some
arch/um/kernel/skas/XXXX.c. IMHO, this should be safe, or do I miss somesthing?

well, it could happen
> to include the *host* asm/types.h, which will be bad on a x86_64 host, since 
> you could get a "unsigned long" (which is safe) even when compiling a 32-bit 
> UML!
> 
> Otherwise, there would not be includes in arch/um! They'd be in 
> include/asm-um!
> 
> And yes, this sucks, but is reality.
> 
> Workaround it - unsigned long long is always a correct definition.
This would be another possibility, but then the definition of "void map()" in
arch/um/kernel/skas/mem_user.c also should be changed. I choosed the option,
which changes less. Feel free to choose the other one.

Bodo
> 
>>Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
>>---
>>
>>
>>diff -puN arch/um/kernel/skas/include/skas.h~skas.h-include-types.h
>>arch/um/kernel/skas/include/skas.h ---
>>linux-2.6.10-rc2-mm4/arch/um/kernel/skas/include/skas.h~skas.h-include-type
>>s.h 2004-12-10 15:53:03.726530054 +0100 +++
>>linux-2.6.10-rc2-mm4-root/arch/um/kernel/skas/include/skas.h 2004-12-10
>>15:53:03.730528661 +0100 @@ -7,6 +7,7 @@
>> #define __SKAS_H
>>
>> #include "sysdep/ptrace.h"
>>+#include "asm/types.h"
>>
>> extern int userspace_pid[];
>>
>>_
> 
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
