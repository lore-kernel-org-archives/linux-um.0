Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CDT5X-0003EL-OT for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Oct 2004 12:29:07 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CDT4c-0008HU-AH for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Oct 2004 12:29:07 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] building from source
References: <1220.157.182.105.1.1096501625.squirrel@www.csee.wvu.edu>
In-Reply-To: <1220.157.182.105.1.1096501625.squirrel@www.csee.wvu.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410012125.20048.blaisorblade_spam@yahoo.it>
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
Date: Fri, 1 Oct 2004 21:25:20 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: atanugul@csee.wvu.edu, user-mode-linux-user@lists.sourceforge.net

On Thursday 30 September 2004 01:47, atanugul@csee.wvu.edu wrote:
> Hi!
> I tried building a uml kernel from source.I have a debian 2.6.6 kernel on
> my system. I downloaded a 2.4.26 kernel and a matching uml patch
> (uml-patch-2.4.26-1.bz2) for it.I followed the steps specified in the
> user-mode-linux.
You should use either 2.4.26-3 on a 2.4.26 vanilla kernel or 2.4.24-1 on a 
2.4.24 vanilla kernel. All the releases between those two have various 
problems. In fact, the 2.4.26-3um patch fixes exactly this problem (which 
happens because you enabled CONFIG_SMP).

Bye

> Everything went well till step 5. When I did `make linux 
> ARCH=um' I got the following error messages:

> gcc -D__KERNEL__ -I/build/kernel-source-2.4.26/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2
> -U__i386__ -Ui386 -fprofile-arcs -ftest-coverage -g -D__arch_um__
> -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE
> -I/build/kernel-source-2.4.26/arch/um/include -Derrno=kernel_errno
> -I/build/kernel-source-2.4.26/arch/um/kernel/tt/include
> -I/build/kernel-source-2.4.26/arch/um/kernel/skas/include -c
> mk_thread_kern.cIn file included from mk_thread_kern.c:3:
> /build/kernel-source-2.4.26/include/linux/sched.h:366: error:
> `CONFIG_NR_CPUS' undeclared here (not in a
> function)/build/kernel-source-2.4.26/include/linux/sched.h:366: error:
> `CONFIG_NR_CPUS' undeclared here (not in a
> function)/build/kernel-source-2.4.26/include/linux/sched.h:528: error:
> `CONFIG_NR_CPUS' undeclared here (not in a function)make[1]: ***
> [mk_thread_kern.o] Error 1 make[1]: Leaving directory
> `/build/kernel-source-2.4.26/arch/um/sys-i386/util'make: ***
> [arch/um/sys-i386/util/mk_thread] Error 2

> Can anyone tell me what i should do?

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
