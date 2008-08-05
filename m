Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQPpd-0002Bl-68 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 09:56:21 -0700
Received: from gw-colo-pa.panasas.com ([66.238.117.130]
	helo=natasha.panasas.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQPpb-0008KM-Oa
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 09:56:21 -0700
Message-ID: <48988612.3030204@panasas.com>
Date: Tue, 05 Aug 2008 19:55:46 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <489870E7.7070000@exasol.com> <489873E0.9030801@panasas.com>
	<489881BE.9070506@exasol.com>
In-Reply-To: <489881BE.9070506@exasol.com>
Subject: Re: [uml-devel] kernel module support broken on x86-64?
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
To: juergen.kadidlo@exasol.com
Cc: user-mode-linux-devel@lists.sourceforge.net

juergen.kadidlo@exasol.com wrote:
> Boaz Harrosh wrote:
>> juergen.kadidlo@exasol.com wrote:
>>   
>>> Hi!
>>>
>>>  I've compiled an UML kernel based on 2.6.25 but loading kernel modules 
>>> seems to be broken. No matter which module I try to load the output 
>>> looks similar to this:
>>>
>>>  overflow in relocation type 11 val 80836d41
>>> 'loop' likely not compiled with -mcmodel=kernel
>>>
>>> After searching for a while I found some threads from 2006 discussing 
>>> this issue, e.g.:
>>> http://www.mail-archive.com/user-mode-linux-devel@lists.sourceforge.net/msg03693.html
>>> and
>>> http://marc.info/?l=user-mode-linux-devel&m=115125101012707&w=2
>>>
>>> As Andi Kleen has mentioned in a mail from the first thread, simply 
>>> appending "-mcmodel=kernel" to the KBUILD_CFLAGS does not work (I tried 
>>> it anyway and can confirm his statement ;)
>>>
>>> Since I could not find any solution I've decided to write this mail and 
>>> ask about the current state of this issue and of course for a solution! 
>>> I simply don't want to believe that there is no loadable module support 
>>> for UML in 2008...
>>>
>>> Regards
>>> JK
>>>
>>>     
>>
>> Every thing is fine down here. What host Kernel-gcc-glibc / uml-gcc-glibc
>> are you using?
>>
>> I'm using out-of-tree modules with uml for every kernel since 2.6.19.
>> I have both Host and UML as x86_64 on FC7 with gcc 4.1.2
>>
>> Boaz
>>
>>   
> I'm glad to here that the bug has been fixed. Anyway, it does not work
> with my configuration:
> 
>  - CentOS 5.1 as host system and UML root fs
>  - Kernel 2.6.25.4 (vanilla, but config taken from the CentOS kernel)
>  - GCC 4.1.2
>  - GLIBC 2.5
> 
> Regards
> JK
> 

I used to run with red-hat 4.5 so this should work.
64 bit, right?

From passed experience I've seen that UML will only
work if I first do "make ARCH=um defconfig"  and then
manually enable any needed options with make xconfig.
other wise it breaks in all kind of ways. Even doing
a make oldconfig on a good uml config file from older
kernel will not work. Try to do defconfig and see if
it loads at all.

How do you compile and run the out-of-tree module
or is it one of the built in modules?

Boaz


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
