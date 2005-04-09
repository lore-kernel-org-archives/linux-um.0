Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DK3PG-00081w-Ph for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Apr 2005 17:00:58 -0700
Received: from [209.67.213.234] (helo=ispbrasil.com.br)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DK3PE-0004sQ-OH
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Apr 2005 17:00:58 -0700
Message-ID: <000501c53c97$5a00b050$0201a8c0@lualele>
From: "itamar" <itamar@ispbrasil.com.br>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.4.27 + uml-2.4.27-bs2-pre10 compile error.
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
Date: Fri, 8 Apr 2005 21:01:54 -0300
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

I am trying to compile, but I am getting this error.

I am using Fedora 3

make all_targets
make[2]: Entering directory `/usr/src/linux-2.4.27/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.27/include -Wall -Wstrict-prototypes -Wno-trigraphs 
 -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -U__i386__ -Ui386 
 -DUM_FASTCALL  -D__arch_um__ -DSUBARCH="i386" -D_LARGEFILE64_SOURCE -I/usr/src/linux-2.4.27/arch/um/include 
 -Derrno=kernel_errno -I/usr/src/linux-2.4.27/arch/um/kernel/tt/include -I/usr/src/linux-2.4.27/arch/um/kernel/skas/include 
 -fno-unit-at-a-time   -nostdinc -iwithprefix 
include -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o sched.o 
sched.c
sched.c:213: error: conflicting types for 'reschedule_idle'
sched.c:210: error: previous declaration of 'reschedule_idle' was here
sched.c:213: error: conflicting types for 'reschedule_idle'
sched.c:210: error: previous declaration of 'reschedule_idle' was here
sched.c:371: error: conflicting types for 'wake_up_process'
/usr/src/linux-2.4.27/include/linux/sched.h:603: error: previous declaration 
of 'wake_up_process' was here
sched.c:371: error: conflicting types for 'wake_up_process'
/usr/src/linux-2.4.27/include/linux/sched.h:603: error: previous declaration 
of 'wake_up_process' was here
sched.c:409: error: conflicting types for 'schedule_timeout'
/usr/src/linux-2.4.27/include/linux/sched.h:148: error: previous declaration 
of 'schedule_timeout' was here
sched.c:409: error: conflicting types for 'schedule_timeout'
/usr/src/linux-2.4.27/include/linux/sched.h:148: error: previous declaration 
of 'schedule_timeout' was here
sched.c:739: error: conflicting types for '__wake_up'
/usr/src/linux-2.4.27/include/linux/sched.h:595: error: previous declaration 
of '__wake_up' was here
sched.c:739: error: conflicting types for '__wake_up'
/usr/src/linux-2.4.27/include/linux/sched.h:595: error: previous declaration 
of '__wake_up' was here
sched.c:749: error: conflicting types for '__wake_up_sync'
/usr/src/linux-2.4.27/include/linux/sched.h:596: error: previous declaration 
of '__wake_up_sync' was here
sched.c:749: error: conflicting types for '__wake_up_sync'
/usr/src/linux-2.4.27/include/linux/sched.h:596: error: previous declaration 
of '__wake_up_sync' was here
sched.c:759: error: conflicting types for 'complete'
/usr/src/linux-2.4.27/include/linux/completion.h:31: error: previous 
declaration of 'complete' was here
sched.c:759: error: conflicting types for 'complete'
/usr/src/linux-2.4.27/include/linux/completion.h:31: error: previous 
declaration of 'complete' was here
sched.c:769: error: conflicting types for 'wait_for_completion'
/usr/src/linux-2.4.27/include/linux/completion.h:30: error: previous 
declaration of 'wait_for_completion' was here
sched.c:769: error: conflicting types for 'wait_for_completion'
/usr/src/linux-2.4.27/include/linux/completion.h:30: error: previous 
declaration of 'wait_for_completion' was here
sched.c:804: error: conflicting types for 'interruptible_sleep_on'
/usr/src/linux-2.4.27/include/linux/sched.h:600: error: previous declaration 
of 'interruptible_sleep_on' was here
sched.c:804: error: conflicting types for 'interruptible_sleep_on'
/usr/src/linux-2.4.27/include/linux/sched.h:600: error: previous declaration 
of 'interruptible_sleep_on' was here
sched.c:815: error: conflicting types for 'interruptible_sleep_on_timeout'
/usr/src/linux-2.4.27/include/linux/sched.h:601: error: previous declaration 
of 'interruptible_sleep_on_timeout' was here
sched.c:815: error: conflicting types for 'interruptible_sleep_on_timeout'
/usr/src/linux-2.4.27/include/linux/sched.h:601: error: previous declaration 
of 'interruptible_sleep_on_timeout' was here
sched.c:828: error: conflicting types for 'sleep_on'
/usr/src/linux-2.4.27/include/linux/sched.h:597: error: previous declaration 
of 'sleep_on' was here
sched.c:828: error: conflicting types for 'sleep_on'
/usr/src/linux-2.4.27/include/linux/sched.h:597: error: previous declaration 
of 'sleep_on' was here
sched.c:839: error: conflicting types for 'sleep_on_timeout'
/usr/src/linux-2.4.27/include/linux/sched.h:598: error: previous declaration 
of 'sleep_on_timeout' was here
sched.c:839: error: conflicting types for 'sleep_on_timeout'
/usr/src/linux-2.4.27/include/linux/sched.h:598: error: previous declaration 
of 'sleep_on_timeout' was here
sched.c:210: warning: 'reschedule_idle' declared `static' but never defined
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.27/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.27/kernel'
make: *** [_dir_kernel] Error 2

Itamar Reis Peixoto
+55 (34) 3238 3845
e-mail : itamar@ispbrasil.com.br
http://www.ispbrasil.com.br 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
