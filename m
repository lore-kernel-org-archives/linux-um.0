Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDpHA-0002Y7-Ph for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 11:42:52 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DDpH5-0005mr-RC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 11:42:52 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] ptrace_test.c program on PPC
References: <838f7c50050317161548f108@mail.gmail.com>
	<200503201136.32209.blaisorblade@yahoo.it>
	<838f7c5005032011255f738335@mail.gmail.com>
In-Reply-To: <838f7c5005032011255f738335@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CGHQCVA9Oe/JnO5"
Message-Id: <200503222026.58074.blaisorblade@yahoo.it>
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
Date: Tue, 22 Mar 2005 20:26:57 +0100
To: ashwin tanugula <ashwin.tanugula@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_CGHQCVA9Oe/JnO5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 20 March 2005 20:25, ashwin tanugula wrote:
> Hi,
> I know that UML has to be ported to PPC. I want to resume that work. I
> just wanted to make sure that my PPC box can run uml.(because the
> first step in porting uml is to check that the ptrace_test.c file
> outputs two same pids).
Since there have been working versions of the PPC port, it should be working 
well.
> I have set ORIG_EAX to 0. Is that correct or wrong?

Hmm, actually this is wrong... by reading ptrace_test.c, which I just found on 
my HD, it should work almost "out of the box".

However, if you look at the source, what it puts inside the ORIG_EAX is the 
number of getppid(), not of getpid(), i.e. 64. You don't need to change the 
value IMHO.

If you write 20 there it is perfectly expectable that the pids you get are 
different (as an exercise, try to understand why: if the child executes 
getpid() it gets its own PID, if it executes getppid() it gets the father's 
pid).

That said, the problem you should get is that I don't expect ORIG_EAX to be 
accepted. From reading include/asm-ppc/unistd.h, it seems that the register 
to be changed is r0 (so the macro is PT_R0).

Also, the ptrace_test.c requirement has been reduced a lot by SYSEMU 
introduction. Basically, ptrace_test.c uses a hack to avoid that the syscall 
is executed on the host, i.e. changing the syscall number to getpid. 
PTRACE_SYSEMU is a ptrace() option that says that the syscall invoked by the 
debugged thread must not be executed: we write the result from the UML 
execution of the syscall to the result register.
> Thanks,
> Ashwin.
>

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_CGHQCVA9Oe/JnO5
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="ptrace_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ptrace_test.c"

#include <stdio.h>
#include <signal.h>
#include <sys/wait.h>
#include <sys/ptrace.h>
#include <asm/ptrace.h>
#include <asm/unistd.h>

static char stack[65536];

int child(void *arg)
{
  if(ptrace(PTRACE_TRACEME, 0, 0, 0) < 0){
    perror("ptrace");
    exit(1);
  }
  kill(getpid(), SIGSTOP);
  while(1){
    printf("getpid() returned %d\n", getpid());
    sleep(3);
  }
  return(0);
}

int main(int argc, char **argv)
{
  int pid, status, syscall;

  printf("Parent pid = %d\n", getpid());
  if((pid = clone(child, &stack[65532], SIGCHLD, NULL)) < 0){
    perror("clone");
    exit(1);
  }
  if((pid = waitpid(pid, &status, WUNTRACED)) < 0){
    perror("Waiting for stop");
    exit(1);
  }
  if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0){
    perror("continuing");
    exit(1);
  }
  while(1){
    if((pid = waitpid(-1, &status, WUNTRACED)) <= 0){
      perror("wait");
      exit(1);
    }
    if(WIFSTOPPED(status) && (WSTOPSIG(status) == SIGTRAP)){
      syscall = ptrace(PTRACE_PEEKUSER, pid, 4 * ORIG_EAX, 0);
      if(syscall == __NR_getpid){
	if(ptrace(PTRACE_POKEUSER, pid, 4 * ORIG_EAX, __NR_getppid) < 0){
	  perror("ptrace");
	  exit(1);
	}
      }
      if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0){
	perror("continuing");
	exit(1);
      }
    }
    else printf("wait failed - pid = %d, status = %d\n", pid, status);
  }
}

--Boundary-00=_CGHQCVA9Oe/JnO5--





-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
