Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AUE3j-0007uo-6W
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 10 Dec 2003 15:47:59 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AUE3i-0007uV-Fb
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 10 Dec 2003 15:47:58 -0800
Message-ID: <02b601c3bf78$a8a19b90$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.44.0312081233150.10622-100000@filer.marasystems.com>
Subject: Re: [uml-devel] Re: Workaround for bug #851759 -  SuSE YAST in textmode does not work
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Thu, 11 Dec 2003 00:52:23 +0100
To: Henrik Nordstrom <hno@marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

Hi Henrik,
i made the tests with your programs and here is the result:

linux-uml:/mnt # ./test1
Segmentation fault


linux-uml:/mnt # strace -f ./test1
execve("./test1", ["./test1"], [/* 43 vars */]) = 0
uname({sys="Linux", node="linux-uml", ...}) = 0
brk(0)                                  = 0x804a000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=12585, ...}) = 0
old_mmap(NULL, 12585, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0^\1\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1470060, ...}) = 0
old_mmap(NULL, 1269380, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001b000
old_mmap(0x4014a000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12e000) = 0x4014a000
old_mmap(0x4014f000, 7812, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4014f000
close(3)                                = 0
munmap(0x40017000, 12585)               = 0
--------------------------------------------------------------------------------------
-> here the output stops until i type sth. into another VC window and hit enter.
-> hitting ONLY enter isn`t enough - i need to type at least one char. furthermore,
-> typing chars into the VC LOGIN PROMPT and hitting enter isn`t enough,too. i need to
-> type it at the shell-prompt. after <key><enter> there, test1 segfaults like this:

--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++

this is absolutely reproducable. it _ALWAYS_ segfaults at once, when started from the
console and it _ALWAYS_ hangs after munmap, when started under control of strace (or
from within a shellscript).then it segfaults after <key><enter>. i have recognised that
an ALPHANUMERICAL key _AND_ enter needs to be pressed to initiate the segfault. using
cursorkeys alone or repeating commands at the shell-prompt (bash history cursor up/down)
does NOT inititate a segfault.

---------

test2 behaves different - and it behaves strange. first i recognized, that most of the
time, after starting the program, i`m back at the prompt without any output(no segfault).
but that`s not always - every 5-20 times i start test2, it hangs and can be ended by
pressing <key><enter> in antother VC, too.

under control of strace, again it ALWAYS hangs (as seen in  test1):

linux-uml:/mnt # strace -f ./test2
execve("./test2", ["./test2"], [/* 43 vars */]) = 0
uname({sys="Linux", node="linux-uml", ...}) = 0
brk(0)                                  = 0x804a000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=12585, ...}) = 0
old_mmap(NULL, 12585, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0^\1\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1470060, ...}) = 0
old_mmap(NULL, 1269380, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001b000
old_mmap(0x4014a000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12e000) = 0x4014a000
old_mmap(0x4014f000, 7812, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4014f000
close(3)                                = 0
munmap(0x40017000, 12585)               = 0
fork(Process 1561 attached
)                                  = 1561
[pid  1560] waitpid(1561, Process 1560 suspended
------------------------------------------------------------------
-> now it hangs
-> when i hit a <key><enter> in another VC it continues and gives:

 <unfinished ...>
[pid  1561] --- SIGSEGV (Segmentation fault) @ 0 (0) ---
Process 1560 resumed
Process 1561 detached
<... waitpid resumed> NULL, 0)          = 1561
--- SIGCHLD (Child exited) @ 0 (0) ---
exit_group(1561)                        = ?


In both cases, on the host(2.6-test9-skas) uml-linux-process(2.6-test11) is eating most of the cpu
(~ 1/3 user, ~ 2/3 system)

Hope this information is useful :)

regards
roland







----- Original Message ----- 
From: "Henrik Nordstrom" <hno@marasystems.com>
To: "Gerd Knorr" <kraxel@bytesex.org>
Cc: "roland" <for_spam@gmx.de>; <user-mode-linux-devel@lists.sourceforge.net>; "uml-user"
<user-mode-linux-user@lists.sourceforge.net>
Sent: Wednesday, December 10, 2003 10:14 PM
Subject: Re: [uml-devel] Re: Workaround for bug #851759 - SuSE YAST in textmode does not work


> On Mon, 8 Dec 2003, Gerd Knorr wrote:
>
> > IMHO this one is a UML kernel bug.
>
> The hang certainly can be considered a UML bug.
>
> I think the same hang should be seen on any SIGSEGV due to incorrect X86
> I/O operations. Can you try these two simple programs to try to isolate
> the error?
>
>
> /* test1.c */
>
> #include <sys/io.h>
>
> int main(int argc, char **argv)
> {
>     inw(0x1234);
> }
>
>
> /* test2.c */
>
> #include <sys/types.h>
> #include <sys/unistd.h>
> #include <sys/io.h>
>
> int main(int argc, char **argv)
> {
>    pid_t pid;
>    pid = fork();
>    if (pid == 0) {
>       inw(0x1234);
>    } else {
>       waitpid(pid, NULL, 0);
>    }
> }
>
>
> The test as such will however (if not hanging) give a false positive if
> UML is running within vmware and can be questioned unless complemented
> with a UML test.
>
> Regards
> Henrik
>
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
