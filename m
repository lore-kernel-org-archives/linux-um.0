Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqlBS-0001JM-Ja for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 21:09:22 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: Bug#260111: user-mode-linux: upgrade hangs at
	"NET4: Linux TCP/IP 1.0 for NET4.0 "
Message-ID: <20040731050804.GB4909@ccure.user-mode-linux.org>
References: <200407280315.08207.alydar@users.sourceforge.net>
	<410A833F.9030207@hevanet.com>
	<200407301849.i6UInpUE003226@ccure.user-mode-linux.org>
	<200407301744.02391.alydar@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407301744.02391.alydar@users.sourceforge.net>
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
Date: Sat, 31 Jul 2004 01:08:04 -0400
To: Allen Chan <alydar@users.sourceforge.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jul 30, 2004 at 05:44:00PM -0400, Allen Chan wrote:
> While isatty() is in <unistd.h> and tcgetattr() and tcsetattr() are in 
> <termios.h> in /usr/include, there does not appear to exist 
> equivalent kernel header files that will make those warnings go away 
> for chan_kern.c.  Do these functions have to be implemented 
> differently if placed at the kernel level?

No, because there really is no difference.  There are "user" files and 
"kernel" files only because user files include libc headers and kernel
files include kernel headers, and you can't mix kernel and libc headers
in the same file.

Possibly, in the libc headers, isatty et al, are macros which expand to
calling something else.  When you use kernel headers without those definitions,
you might get some functions with those names that do the wrong thing somehow.

It would be interesting to see a cpp expansion of that function in both
chan_user.c and chan_kern.c

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
