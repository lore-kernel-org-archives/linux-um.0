Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20031208095906.GB22878@bytesex.org>
References: <055801c3bd22$f1a1b3f0$2000000a@schlepptopp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <055801c3bd22$f1a1b3f0$2000000a@schlepptopp>
Subject: [uml-devel] Re: Workaround for bug #851759 -  SuSE YAST in textmode does not work
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
Date: Mon, 8 Dec 2003 10:59:06 +0100
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

> "list systemProbe = SCR:Read(.probe.system);"

Oh, that one.  Didn't know yast triggeres this too.  That is actually
a bug in the uml kernel (there should be a mail in the -devel archive
...).  One if the things the hardware probes does is to check whenever
it runs within vmware or not, and that test hangs (source code below).

Known workarounds:
  * boot with "hwprobe=-sys" (that will make the hardware detect
    skip the critical test), or
  * don't use skas mode (it hangs in skas mode only for some
    musterious reason), or
  * just do something else in another terminal, that will unblock
    it too (scheduler bug in the uml kernel?).

> btw: what would be a better solution: asking the suse people to make
> yast "uml-aware" or fixing those things inside uml?

IMHO this one is a UML kernel bug.

  Gerd

==============================[ cut here ]==============================
#define _GNU_SOURCE		/* we want memmem() */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>

#include <sys/types.h>
#include <sys/wait.h>

void sigsegv_handler(int signum) { exit(77); }

int chk_vmware(void)
{
  static int is_vmware = -1;
  int child, status;

  /* do the check only once */
  if(is_vmware < 0) {

    child = fork();

    if(child == 0) {
      signal(SIGSEGV, sigsegv_handler);

      asm(
        "push %ebx\n"
        "\tpush %edx\n"
        "\tpush %eax\n"
        "\tpush %ecx\n"
        "\tmov $0x564d5868,%eax\n"
        "\tmov $0xa,%ecx\n"
        "\tmov $0x5658,%edx\n"
        "\tin (%dx),%eax\n"
        "\tpop %ecx\n"
        "\tpop %eax\n"
        "\tpop %edx\n"
        "\tpop %ebx\n"
      );

      _exit(66);
    }
    else {
      if(waitpid(child, &status, 0) == child) {
        status = WEXITSTATUS(status);
        if(status == 66) is_vmware = 1;
        if(status == 77) is_vmware = 0;
      }
    }
  }
  return is_vmware;
}

int main(int argc, char *argv[])
{
	int rc;

	fprintf(stderr, "check for vmware... ");
	rc = chk_vmware();
	fprintf(stderr, "%s\n", rc ? "yes" : "no");
	return rc;
}


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
