Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: Expedted SIGSTOP,
	got status = <blah> (UML 2.4.24-1um)
Message-ID: <20040807005950.GA4939@ccure.user-mode-linux.org>
References: <410806FE.1000209@enterasys.com> <4113D92B.5040602@enterasys.com>
	<200408062246.i76Mk9QW004489@ccure.user-mode-linux.org>
	<41140ABD.7020806@enterasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41140ABD.7020806@enterasys.com>
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
Date: Fri, 6 Aug 2004 20:59:50 -0400
To: "D. Bahi" <dbahi@enterasys.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Fri, Aug 06, 2004 at 06:48:29PM -0400, D. Bahi wrote:
> reboot-signals is only listed in the 2.6 series patches;
> i didn't think to try it.
> 
> hey, THANKS! _it applies_ and almost solves the problem completely!!!

It applies because you're running an old 2.4.  That patch is in the current
2.4 UML.

> of my 20 simultaneous UMLs only one failed to launch:
> 
>    Checking for the skas3 patch in the host...found

This is a different UML ...

> Restarting system.
> 
> deactivate_all_fds failed, errno = 9
> Checking for the skas3 patch in the host...found
> Checking for /proc/mm...found

from this one, right?

If so, did the second one boot OK, and the only problem was the errno=9
thing?

Try attaching gdb to an example of the failed launch, and get a stack trace
from it.

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
