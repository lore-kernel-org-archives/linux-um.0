Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEvF8-0006zy-Ow for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 12:45:02 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CEvEQ-0001T1-I1 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 12:45:02 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] 2.6.8.1: Kernel panic: handle_trap - failed to wait
	at end of syscall, errno = 4, status = 4479
References: <EAC7622167479948B614F8B9AD41C505ECA5CD@MAANDMBX2.ets.enterasys.com>
In-Reply-To: <EAC7622167479948B614F8B9AD41C505ECA5CD@MAANDMBX2.ets.enterasys.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410052144.09628.blaisorblade_spam@yahoo.it>
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
Date: Tue, 5 Oct 2004 21:44:09 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Tsillas, Demetrios J" <jtsillas@enterasys.com>

On Tuesday 05 October 2004 21:22, Tsillas, Demetrios J wrote:
> I'm trying with root_fs.fc-2-client.pristine.20040504. I've got
> the incrementals in there:
Tried without any of them? Does it make any difference? Also, against which 
tree are you applying patches, 2.6.8.1-1 or 2.6.9-rc2-mm4? And does using 
different filesystems change anything?

> VFS: Mounted root (ext2 filesystem) readonly.
> Mounted devfs on /dev
> INIT: version 2.85 booting
> Kernel panic: handle_trap - failed to wait at end of syscall, errno = 4,
> status = 4479

This is quite strange. The child has been stopped by SIGCHLD, which is 
completely unexpected (except if any syscall is executing on the host). Have 
you made sure you have moved, inside the fs, /lib/tls to /lib/notls?

About the 4479 value:
./testprogs/waitstatus 4479
WSTOPSIG(status) is 17

Signal 17 is SIGCHLD
waitstatus.c:

#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char * argv[])
{
        int status = 2943;
        if (argc >= 2)
                status = atol(argv[1]);
        if (WIFSIGNALED(status))
                printf("error, process signaled\n");
        if (WIFEXITED(status))
                printf("error, process exited\n");
        if (!WIFSTOPPED(status))
                printf("error, process not stopped\n");
        if (WSTOPSIG(status) != SIGTRAP)
                printf("WSTOPSIG(status) is %d\n", WSTOPSIG(status));
        return 0;
}

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
