Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATTpF-0006Vb-L5
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 14:25:57 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1ATTpD-00026L-Hj
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 14:25:55 -0800
Message-ID: <004a01c3bdda$dd2e38e0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <055801c3bd22$f1a1b3f0$2000000a@schlepptopp> <20031208095906.GB22878@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [uml-user] Re: Workaround for bug #851759 -  SuSE YAST in textmode does not work
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
Date: Mon, 8 Dec 2003 23:30:18 +0100
To: Gerd Knorr <kraxel@bytesex.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

hi!

> Known workarounds:
>   * boot with "hwprobe=-sys" (that will make the hardware detect
>     skip the critical test), or
ah - thanks, that seems to work fine. is this just a param, that tells 
yast to skip the detection test? can you tell me,  why i need to pass 
that as a kernel param, not as a Yast param or an environment variable? 
if this doesn`t break or influence other things, i think this is _THE_
workaround for the problem and should be mentioned in the suse-howto or 
in the faq. btw: does YaST2 in gui mode behave the same? don`t have X11-
Yast installed inside my uml root-image - so i cannot test at the moment.

i deliver a text snippet here - perhaps someone could make some correction 
or addition because my english is not so perfect:

------------------

Yast problems within UML
------------------------
Yast is the setup and configuration tool of SuSE-Linux. If you are going 
to use it, you may encounter problems(Yast seems to freeze). It`s not for 
sure, but it is possibly an UML bug (to be fixed). Some modules within YaST 
do automatic hardware detection and there is a routine inside which detects, 
if your linux runs "inside" vmware. This seems to cause the problem. A known 
workaround for this is to add "hwprobe=-sys" to the uml commandline. This 
will make the hardware detection inside Yast skip the critical test. Further 
information can be found here:
http://sourceforge.net/mailarchive/message.php?msg_id=6224097


-----------------


regards
roland




----- Original Message ----- 
From: "Gerd Knorr" <kraxel@bytesex.org>
To: "roland" <for_spam@gmx.de>
Cc: <user-mode-linux-devel@lists.sourceforge.net>; "uml-user" <user-mode-linux-user@lists.sourceforge.net>
Sent: Monday, December 08, 2003 10:59 AM
Subject: [uml-user] Re: Workaround for bug #851759 - SuSE YAST in textmode does not work


> > "list systemProbe = SCR:Read(.probe.system);"
> 
> Oh, that one.  Didn't know yast triggeres this too.  That is actually
> a bug in the uml kernel (there should be a mail in the -devel archive
> ...).  One if the things the hardware probes does is to check whenever
> it runs within vmware or not, and that test hangs (source code below).
> 
> Known workarounds:
>   * boot with "hwprobe=-sys" (that will make the hardware detect
>     skip the critical test), or
>   * don't use skas mode (it hangs in skas mode only for some
>     musterious reason), or
>   * just do something else in another terminal, that will unblock
>     it too (scheduler bug in the uml kernel?).
> 
> > btw: what would be a better solution: asking the suse people to make
> > yast "uml-aware" or fixing those things inside uml?
> 
> IMHO this one is a UML kernel bug.
> 
>   Gerd
> 
> ==============================[ cut here ]==============================
> #define _GNU_SOURCE /* we want memmem() */
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <signal.h>
> 
> #include <sys/types.h>
> #include <sys/wait.h>
> 
> void sigsegv_handler(int signum) { exit(77); }
> 
> int chk_vmware(void)
> {
>   static int is_vmware = -1;
>   int child, status;
> 
>   /* do the check only once */
>   if(is_vmware < 0) {
> 
>     child = fork();
> 
>     if(child == 0) {
>       signal(SIGSEGV, sigsegv_handler);
> 
>       asm(
>         "push %ebx\n"
>         "\tpush %edx\n"
>         "\tpush %eax\n"
>         "\tpush %ecx\n"
>         "\tmov $0x564d5868,%eax\n"
>         "\tmov $0xa,%ecx\n"
>         "\tmov $0x5658,%edx\n"
>         "\tin (%dx),%eax\n"
>         "\tpop %ecx\n"
>         "\tpop %eax\n"
>         "\tpop %edx\n"
>         "\tpop %ebx\n"
>       );
> 
>       _exit(66);
>     }
>     else {
>       if(waitpid(child, &status, 0) == child) {
>         status = WEXITSTATUS(status);
>         if(status == 66) is_vmware = 1;
>         if(status == 77) is_vmware = 0;
>       }
>     }
>   }
>   return is_vmware;
> }
> 
> int main(int argc, char *argv[])
> {
> int rc;
> 
> fprintf(stderr, "check for vmware... ");
> rc = chk_vmware();
> fprintf(stderr, "%s\n", rc ? "yes" : "no");
> return rc;
> }
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
> 


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
