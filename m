Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: uml <uml@dot1q.net>
Message-id: <00d301c44c01$6deea090$dd02a8c0@ferraro>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
References: <007701c44be9$e4d7d630$dd02a8c0@ferraro>
	<10e901c44bf3$48506160$2000000a@schlepptopp>
Subject: [uml-devel] Re: [uml-user] SuSE 9.1 host + 2.4.26 Kernel + GCC 3.3.3
	similarities to 2.6.6!?
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
Date: Sun, 06 Jun 2004 16:04:09 -0400
To: uml-user <user-mode-linux-user@lists.sourceforge.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

I did this a while back... here's what I gleaned at that point:

---8<---
here's the modification I made to both the root Makefile and
arch/um/Makefile that caused it not to compile, the others may have
triggered a few complaints, but still worked -- I've no idea why -O2 didn't
generate this error upon compilation, nor why -fschedule-insns2 doesn't
generate it as I'm no kernel or C expert.

:%s/-O2/-O1 -fschedule-insns/g  (vi substitution regex)

---8<---
  HOSTCC  scripts/sumversion.o
scripts/sumversion.c: In function `parse_source_files':
scripts/sumversion.c:405: error: unable to find a register to spill in class
`AREG'
scripts/sumversion.c:405: error: this is the insn:
(insn:HI 280 279 294 16 0x4049e0b0 (parallel [
            (set (reg:SI 2 ecx [118])
                (unspec:SI [
                        (mem:BLK (reg/v/f:SI 64 [ dir ]) [0 A8])
                        (reg:QI 103)
                        (const_int 1 [0x1])
                        (reg:SI 102)
                    ] 20))
            (use (reg:SI 19 dirflag))
            (clobber (reg/f:SI 5 edi [orig:120 dir ] [120]))
            (clobber (reg:CC 17 flags))
        ]) 473 {strlenqi_1} (insn_list 279 (insn_list:REG_DEP_ANTI 271
(nil)))
    (expr_list:REG_DEAD (reg:SI 19 dirflag)
        (expr_list:REG_UNUSED (reg:CC 17 flags)
            (expr_list:REG_UNUSED (reg/f:SI 5 edi [orig:120 dir ] [120])
                (expr_list:REG_EQUAL (unspec:SI [
                            (mem:BLK (reg/v/f:SI 64 [ dir ]) [0 A8])
                            (reg:QI 103)
                            (const_int 1 [0x1])
                            (reg:SI 102)
                        ] 20)
                    (nil))))))
scripts/sumversion.c:405: confused by earlier errors, bailing out
make[1]: *** [scripts/sumversion.o] Error 1
make: *** [scripts] Error 2
---8<---

Here's the line I used elsewhere that worked: (vi substitution regex)
:%s/-O2/-O1 -fforce-mem -foptimize-sibling-calls -fstrength-reduce -fcse-fol
low-jumps -fcse-skip-blocks -frerun-cse-after-loop -frerun-loop-opt -fgcse -
fgcse-lm -fgcse-sm -fdelete-null-pointer-checks -fexpensive-optimizations -f
regmove -fschedule-insns2 -fsched-interblock -fsched-spec -fcaller-saves -fp
eephole2 -freorder-blocks -freorder-functions -fstrict-aliasing -falign-func
tions -falign-jumps -falign-loops -falign-labels/g

I don't know what to make of this, but if you want to compile with nearly
all of the O2 options, you can just leave that one out I believe, YMMV.

---8<---

----- Original Message ----- 
From: "roland" <for_spam@gmx.de>
To: "uml" <uml@dot1q.net>; "uml-user"
<user-mode-linux-user@lists.sourceforge.net>
Cc: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Sunday, June 06, 2004 2.22 PM
Subject: Re: [uml-user] SuSE 9.1 host + 2.4.26 Kernel + GCC 3.3.3
similarities to 2.6.6!?


> hi!
> > As well, I encountered the same memory problems -- it wouldn't recognize
> > more than 32M!
> >
> > Can anyone else confirm?  (Roland?)
> i can at least confirm that 2.4 uml kernel has O1/O2 compile issues too -
> got the same hang at "Init 3...." on suse9/9.1 as in 2.6.6.
>
> afaik, these symptoms are known "compile issues":
> - hang after "Checking for /proc/mm..."
> - hang after "Init...."
> - command line options not being recognized (mem is no more than 32M,umid
>   not being recognized....)
> - terminal being unusable after shutdown/halt - needs "reset"
> - uml processes left running after shutdown/halt
> - further...?
>
> as -O2 Options break down  into:
>
> -fforce-mem  -foptimize-sibling-calls  -fstrength-reduce
> -fcse-follow-jumps  -fcse-skip-blocks  -frerun-cse-after-loop
> -frerun-loop-opt -fgcse  -fgcse-lm  -fgcse-sm
> -fdelete-null-pointer-checks  -fexpensive-optimizations  -fregmov
> -fschedule-insns  -fschedule-insns2  -fsched-interblock  -fsched-spec
> -fcaller-saves  -fpeephole2  -freorder-blocks  -freorder-functions
> -fstrict-aliasing  -falign-functions  -falign-jumps  -falign-loops
> -falign-labels
>
> just someone needs to dig into that, which of these optimizations result
in a
> "corrupt" uml binary. maybe it's only one - maybe several ones.
> does someone have a compile farm to "trial and error" this very quickly ?
;)
>
> regards
> roland
>
>
> ----- Original Message ----- 
> From: "uml" <uml@dot1q.net>
> To: "uml-user" <user-mode-linux-user@lists.sourceforge.net>
> Sent: Sunday, June 06, 2004 7:15 PM
> Subject: [uml-user] SuSE 9.1 host + 2.4.26 Kernel + GCC 3.3.3 similarities
to 2.6.6!?
>
>
> > For the sake of discussion/argument/curiosity, I decided to compile
2.4.26
> > on SuSE9.1 with a slackware root_fs (9.1)...
> >
> > Guess what I encountered that was similar to the 2.6.6 kernel
compilation??
> >
> > I had to replace every instance of -O2 with -O1 in order for it to run.
I
> > am beginning to question the compiler rather than  UML now.  I'm using
GCC
> > 3.3.3 (default).
> >
> > As well, I encountered the same memory problems -- it wouldn't recognize
> > more than 32M!
> >
> > Can anyone else confirm?  (Roland?)
> >
> > The host is SMP, but UML is NOT compiled for SMP support.
> >
> > Here's the total procedure I used:
> > ---8<---
> > #!/bin/sh
> > cd /tmp
> > wget http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.26.tar.bz2
> > wget
> >
http://umn.dl.sourceforge.net/sourceforge/user-mode-linux/uml-patch-2.4.26-1.bz2
> > tar -xjvf linux-2.4.26.tar.bz2
> > cd linux-2.4.26
> > bzcat /tmp/uml-patch-2.4.26-1.bz2 | patch -p1
> > make menuconfig ARCH=um  [turn on COW support -- but that's the only
change
> > from default!]
> > perl -e 's/-O2/-O1/gi' -p -i.bak Makefile arch/um/Makefile
> > make linux modules ARCH=um
> > strip linux
> > cp linux ../linux-2.4.26
> > cd ..
> > ./linux-2.4.26 ubd0=slack91.cow,slack91.img mem=128M eth0=tuntap,tap2
> > umid=slack91test
> > ---8<---
> >
> > Without the 'perl -e 's/-O2/-O1/gi' -p -i.bak Makefile arch/um/Makefile'
> > substitutions, it will compile, but I experience the same issues I do
with
> > 2.6.6.
> >
> > Ideas?
> >
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by the new InstallShield X.
> > From Windows to Linux, servers to mobile, InstallShield X is the one
> > installation-authoring solution that does it all. Learn more and
> > evaluate today! http://www.installshield.com/Dev2Dev/0504
> > _______________________________________________
> > User-mode-linux-user mailing list
> > User-mode-linux-user@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
> >
>



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
