Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Re: Workaround for bug #851759 -  SuSE YAST in
 textmode does not work
In-Reply-To: <20031208095906.GB22878@bytesex.org>
Message-ID: <Pine.LNX.4.44.0312081233150.10622-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 10 Dec 2003 22:14:07 +0100 (CET)
To: Gerd Knorr <kraxel@bytesex.org>
Cc: roland <for_spam@gmx.de>, user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

On Mon, 8 Dec 2003, Gerd Knorr wrote:

> IMHO this one is a UML kernel bug.

The hang certainly can be considered a UML bug.

I think the same hang should be seen on any SIGSEGV due to incorrect X86
I/O operations. Can you try these two simple programs to try to isolate 
the error?


/* test1.c */

#include <sys/io.h>

int main(int argc, char **argv)
{
    inw(0x1234);
}


/* test2.c */

#include <sys/types.h>
#include <sys/unistd.h>
#include <sys/io.h>

int main(int argc, char **argv)
{
   pid_t pid;
   pid = fork();
   if (pid == 0) {
      inw(0x1234);
   } else {
      waitpid(pid, NULL, 0);
   }
}


The test as such will however (if not hanging) give a false positive if
UML is running within vmware and can be questioned unless complemented 
with a UML test.

Regards
Henrik




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
