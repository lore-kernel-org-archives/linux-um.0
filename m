Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6oOz-00055B-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 07 Oct 2003 02:45:09 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1A6oOy-0003tt-Id
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 07 Oct 2003 02:45:08 -0700
Received: from hirsch.in-berlin.de (localhost [127.0.0.1])
	by hirsch.in-berlin.de (8.12.10/8.12.10/Debian-4) with ESMTP id h979j3Ng017615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 7 Oct 2003 11:45:03 +0200
Received: (from uucp@localhost)
	by hirsch.in-berlin.de (8.12.10/8.12.10/Debian-4) with UUCP id h979j3gM017612
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 7 Oct 2003 11:45:03 +0200
Received: from bytesex.org (kraxel@localhost [127.0.0.1])
	by bytesex.org (8.12.3/8.12.3/Debian-6.6) with ESMTP id h979xFu3002863
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 7 Oct 2003 11:59:15 +0200
Received: (from kraxel@localhost)
	by bytesex.org (8.12.3/8.12.3/Debian-6.6) id h979xFYF002862
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 7 Oct 2003 11:59:15 +0200
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20031007095915.GA2849@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] uml hangs in skas mode
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 7 Oct 2003 11:59:15 +0200
To: uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

I ran into a uml kernel issue with the suse hardware detection tool
(hwinfo).  hwinfo tries to detect whenever it runs within vmware or
not, and this doesn't work.  hwinfo just hangs forever.  The relevant
part of the code to reproduce it is below.

What I've figured so far:

  * hwinfo blocks in the waitpid() call, waiting for the forked
    child finish.
  * It happens in skas mode only, tt mode is fine.
  * It happens on a completely idle machine only.  As soon as I start to
    do something in another shell hwinfo continues to run (=> scheduler
    race?) 
  * It doesn't happen if I try to "strace -f" the process.

Any idea?

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
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
