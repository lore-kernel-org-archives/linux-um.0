Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJbGI-0006Po-GH for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Apr 2004 09:53:18 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BJbGI-0002P4-2h for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Apr 2004 09:53:18 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Still can't get an 2.6.6-rcX UML
References: <20040425183446.27642.qmail@praize.com>
In-Reply-To: <20040425183446.27642.qmail@praize.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404301607.24027.blaisorblade_spam@yahoo.it>
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
Date: Fri, 30 Apr 2004 16:07:24 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: gboutwel <gboutwel@praize.com>

Alle 20:34, domenica 25 aprile 2004, gboutwel ha scritto:
> Hello,
>
>   On Debian Unstable/SID.  I do the following, I've done it several
> different ways for rc2 and rc1 and always I get hung up at the
> same point on the UML, I can compile patch and compile the host
> without problem.  This will be the first time since toying with
> UMl and 2.6 kernels that I haven't beenable to get an UML compiled.

>
> make linux ARCH=um
> // this is where it fails.  I fails on the
> // arch/um/util/mk_task_kern.o, #include "linux/sched.h" line
> // which then includes "userspace" includes, which I don't feel
> // comfortable modifying since they are part of my distro and
> // not sure how that would break other applications.

Well, something has been *really* been messed up. If I understand things 
properly, you are able to compile fine a 2.6.5 UML, right?

The problem is that:
a) I think that file should include the "kernelspace" headers... however the 
kludges needed to do it are very fragile when Kbuild changes a bit (this 
problem has repeatedly showed up against Linux 2.6).

However, things should succeed anyway, BUT

b) your distro headers are messed up...; the first thing I see is that it uses 
the 2.6 headers. Now, the missing header should be located in 
/usr/include/asm/mach-default/. Probably it is there; however the kernel uses 
normally a -Iasm/mach-default, so that #include <mach_mpspec.h> works.
Since one cannot require user programs to add -I to compile, Debian should 
symlink everything from /usr/include/asm/mach-default/ into /usr/include; 
i.e.:
ln -s  /usr/include/asm/mach-default/* /usr/include.

Then retry the build, and also watch this thread:

"[uml-devel] patch for 2.6.6-rc1".

Bye and HTH!
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
