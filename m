Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: uml <uml@dot1q.net>
Message-id: <008901c44c40$c2ed0e30$dd02a8c0@ferraro>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
References: <114001c44bf7$b69ca120$2000000a@schlepptopp>
	<011001c44c0d$ebdeceb0$dd02a8c0@ferraro>
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
Date: Sun, 06 Jun 2004 23:37:30 -0400
To: uml-user <user-mode-linux-user@lists.sourceforge.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

After much testing and compiling, I have some results.

These optimizations cause problems, ranging from memory not being correctly
passed, to the UMID not being recognized to the console being unusable
(until reset), to just failure to boot:
-fgcse
-fgcse-lm
-fgcse-sm
-fschedule-insns
-fschedule-insns2

---8<---
Switch differences between -O1 and -O2 on GCC 3.3.3:
-fforce-mem
-foptimize-sibling-calls
-fstrength-reduce
-fcse-follow-jumps
-fcse-skip-blocks
-frerun-cse-after-loop
-frerun-loop-opt
-fgcse
-fgcse-lm
-fgcse-sm
-fdelete-null-pointer-checks
-fexpensive-optimizations
-fregmove
-fschedule-insns
-fschedule-insns2
-fsched-interblock
-fsched-spec
-fcaller-saves
-fpeephole2
-freorder-blocks
-freorder-functions
-fstrict-aliasing
-falign-functions
-falign-jumps
-falign-loops
-falign-labels

---8<---
-fforce-mem -foptimize-sibling-calls -fstrength-reduce -fcse-follow-jumps -f
cse-skip-blocks -frerun-cse-after-loop -frerun-loop-opt -fexpensive-optimiza
tions -fregmove -fsched-interblock -fsched-spec -fcaller-saves -fpeephole2 -
freorder-blocks -freorder-functions -fstrict-aliasing -falign-functions -fal
ign-jumps -falign-loops -falign-labels -fgcse -fgcse-lm -fgcse-sm
RESULT: Hangs on 'Mounted devfs on /dev'; killall -9 linux-2.4.26; reset;

-fforce-mem -foptimize-sibling-calls -fstrength-reduce -fcse-follow-jumps -f
cse-skip-blocks -frerun-cse-after-loop -frerun-loop-opt -fexpensive-optimiza
tions -fregmove -fsched-interblock -fsched-spec -fcaller-saves -fpeephole2 -
freorder-blocks -freorder-functions -fstrict-aliasing -falign-functions -fal
ign-jumps -falign-loops -falign-labels -fschedule-insns -fschedule-insns2
RESULT: Hangs on 'Mounted devfs on /dev'; killall -9 linux-2.4.26; reset;
---8<---

Perhaps someone can refine this?

----- Original Message ----- 
From: "uml" <uml@dot1q.net>
To: "uml-user" <user-mode-linux-user@lists.sourceforge.net>
Cc: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Sunday, June 06, 2004 5.33 PM
Subject: Re: [uml-user] SuSE 9.1 host + 2.4.26 Kernel + GCC 3.3.3
similarities to 2.6.6!?


> > answering myself:
> >
> > via google i found:
> > >Two different xterms emulators dumping core ... I'd be concerned a
> > >wee bit. One note, do not compile with excessive optimizations and
> > >especially -fschedule-insns and -fschedule-insns2 is the right way  <-
> !!!
> > >to produce faulty code with all gcc / egcs releases since 2.8.0     <-
> !!!
> > >on I86 machines. Not that it would make much sense with a terminal
> > >emulator anyway, but even so.
> >
> > and:
> > >linked to the Pentium Pro Blas single processor library.
> If -fschedule-insns
> > >is included four examples - 06, 07, 09 and 30 fail, 06 and 09 with
> segmentation  <-- !!!
> > >fault and 09 and 30 with a message that "SCALAR MECHINES SHOULD NOT
CALL
> JKGNMV".
> > >The performance is sometimes better and sometimes worse over the 31
> examples, but
> > >these are really too small for a proper bennch mark.
> >
> > and:
> > > ..so I guess the problem is not the classic --fschedule-insns bug.
> That's the option I found several weeks ago that gave me issues.
>
> > and:
> > http://www.linux-mips.org/archives/linux-mips/2004-03/msg00032.html
> >
> > could please someone try putting -fno-schedule-insns (and
> maybe -fno-schedule-insns2)
> > into the Makefile(s) and try again ?
> I'm having issues with at least -fno-schedule-insns -- where in the
> arch/um/Makefile do I make the change as well (or do I?)
>
>
> So I tried the following combos:
> perl -e 's/-O2/-O2 -fno-schedule-insns/g' -p -i.bak Makefile
> arch/um/Makefile
> perl -e 's/-O2/-O2 -fno-schedule-insns2/g' -p -i.bak Makefile
> arch/um/Makefile
> perl -e 's/-O2/-O2 -fno-schedule-insns -fno-schedule-insns2/g' -p -i.bak
> Makefile arch/um/Makefile
>
> No dice on any of them.
>
> I don't believe there is a -O2 in arch/um/Makefile as there is in 2.6.6 -- 
> should I make a change to the CFLAGS there?
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the new InstallShield X.
> From Windows to Linux, servers to mobile, InstallShield X is the one
> installation-authoring solution that does it all. Learn more and
> evaluate today! http://www.installshield.com/Dev2Dev/0504
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
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
