Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1d0NoO-0004Wl-F6
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Apr 2017 07:44:32 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d0NoM-0001ms-7y
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Apr 2017 07:44:32 +0000
References: <20170403195458.112185-1-mka@chromium.org>
	<20170417203738.GQ28657@google.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <f0499858-1c3c-5a51-27c6-d3f5e82d1173@nod.at>
Date: Tue, 18 Apr 2017 09:44:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170417203738.GQ28657@google.com>
Subject: Re: [uml-devel] [PATCH] um: Include kbuild.h instead of duplicating
	its macros
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
To: Matthias Kaehlcke <mka@chromium.org>, Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Matthias,

Am 17.04.2017 um 22:37 schrieb Matthias Kaehlcke:
> El Mon, Apr 03, 2017 at 12:54:58PM -0700 Matthias Kaehlcke ha dit:
> 
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>>  arch/x86/um/shared/sysdep/kernel-offsets.h | 9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/um/shared/sysdep/kernel-offsets.h b/arch/x86/um/shared/sysdep/kernel-offsets.h
>> index 46a9df99f3c5..7e1d35b6ad5c 100644
>> --- a/arch/x86/um/shared/sysdep/kernel-offsets.h
>> +++ b/arch/x86/um/shared/sysdep/kernel-offsets.h
>> @@ -2,16 +2,9 @@
>>  #include <linux/sched.h>
>>  #include <linux/elf.h>
>>  #include <linux/crypto.h>
>> +#include <linux/kbuild.h>
>>  #include <asm/mman.h>
>>  
>> -#define DEFINE(sym, val) \
>> -	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
>> -
>> -#define BLANK() asm volatile("\n->" : : )
>> -
>> -#define OFFSET(sym, str, mem) \
>> -	DEFINE(sym, offsetof(struct str, mem));
>> -
>>  void foo(void)
>>  {
>>  #include <common-offsets.h>
>> -- 
> 
> Ping, any comment on this patch?

Looks good, nothing exploded while a quick test.
I'll queue it for the next merge window. :-)

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

